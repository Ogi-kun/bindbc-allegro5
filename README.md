# bindbc-allegro5
__Note__ This is not an official BindBC package. 

This project provides both static and dynamic bindings to the [Allegro libraries](https://liballeg.org). They are compatible with `@nogc` and `nothrow` and can be compiled with `-betterC` compatibility. 

Currently in beta. Only tested on Windows and Linux.

## General BindBC Usage

BindBC is a cross-platform API for creating D bindings for C libraries. This entire section was adapted from bindbc-sdl’s README. You may skip to [Package Declarations section](#package-declarations) if you are already familiar with BindBC conventions.

By default, bindbc-allegro5 is configured to compile as dynamic bindings that are not BetterC-compatible. The dynamic bindings have no link-time dependency on the Allegro libraries, so the SDL shared libraries must be manually loaded at runtime. When configured as static bindings, there is a link-time dependency on the Allegro libraries—either the static libraries or the appropriate files for linking with shared libraries on your system (see below).

When using DUB to manage your project, the static bindings can be enabled via a DUB `subConfiguration` statement in your project’s package file. BetterC compatibility is also enabled via subconfigurations.

To use any of the supported Allegro libraries, add bindbc-allegro5 as a dependency to your project’s package config file and include the appropriate version for any of the addons you want to use. For example, the following is configured to use Font and TTF addons, in addition to the base Allegro binding, as dynamic bindings that are not BetterC-compatible:

__dub.json__
```
dependencies {
    "bindbc-allegro5": "~>1.0.0",
}
"versions": [
    "Allegro_Font",
    "Allegro_TTF"
],
```

__dub.sdl__
```
dependency "bindbc-allegro5" version="~>1.0.0"
versions "Allegro_Font" "Allegro_TTF"
```

#### The Dynamic Bindings
The dynamic bindings require no special configuration when using DUB to manage your project. There is no link-time dependency. At runtime, the Allegro shared libraries are required to be on the shared library search path of the user’s system. On Windows, this is typically handled by distributing the Allegro DLLs with your program. On other systems, it usually means installing the Allegro runtime libraries through a package manager.

To load the shared libraries, you need to call the appropriate load function. This returns a member of the `AllegroSupport` enumeration:

* `AllegroSupport.noLibrary` indicating that the library failed to load (it couldn’t be found)
* `AllegroSupport.badLibrary` indicating that one or more symbols in the library failed to load
* a member of `AllegroSupport` indicating a version number that matches the version of Allegro that bindbc-allegro5 was configured at compile-time to load. By default, that is `AllegroSupport.v5_2_0`, but can be configured via a version identifier (see below). This value will match the global manifest constant, `allegroSupport`.

```d
import bindbc.allegro;

/*
 This version attempts to load the Allegro shared library using well-known 
 variations of the library name for the host system.
*/
AllegroSupport ret = loadAllegro();
if (ret != allegroSupport) {

    /*
     Handle error. For most use cases, it’s reasonable to use the the error 
     handling API in bindbc-loader to retrieve error messages for logging and 
     then abort. If necessary, it’s possible to determine the root cause via 
     the return value:
    */

    if (ret == AllegroSupport.noLibrary) {
        // The Allegro shared library failed to load
    }
    else if (AllegroSupport.badLibrary) {
        /*
         One or more symbols failed to load. The likely cause is that the shared
         library is for a lower version than bindbc-allegro5 was configured 
         to load (via Allegro_5_2_8, etc.)
        */
    }
}
/*
 This version attempts to load the Allegro library using a user-supplied file 
 name. Usually, the name and/or path used will be platform specific, as in this 
 example which attempts to load `allegro-5.2.dll` from the `libs` subdirectory,
 relative to the executable, only on Windows.
*/
version (Windows) loadAllegro("libs/allegro-5.2.dll");
```

[The error reporting API](https://github.com/BindBC/bindbc-loader#error-handling) in bindbc-loader can be used to log error messages.

```d
// Import the dependent package
import bindbc.allegro;

/*
 Import the sharedlib module for error handling. Assigning an alias ensures 
 the function names do not conflict with  other public APIs. This isn’t strictly 
 necessary, but the API names are common enough that they could appear in other
 packages.
*/
import loader = bindbc.loader.sharedlib;

bool loadLib() {
    /*
     Compare the return value of loadAllegro with the global `allegroSupport` 
     constant to determine if the version of Allegro configured at compile time 
     is the version that was loaded.
    */
    auto ret = loadAllegro();
    if (ret != allegroSupport) {
        // Log the error info
        foreach (info; loader.errors) {
            /*
             A hypothetical logging function. Note that `info.error` and 
             `info.message` are `const(char)*`, not
             `string`.
            */
            logError(info.error, info.message);
        }

        // Optionally construct a user-friendly error message for the user
        string msg;
        if (ret == AllegroSupport.noLibrary) {
            msg = "This application requires the Allegro library.";
        }
        else {
            msg = "The version of the Allegro library on your system is too low. Please upgrade."
        }
        // A hypothetical message box function
        showMessageBox(msg);
        return false;
    }
    return true;
}
```

By default, each bindbc-allegro5 binding is configured to compile bindings for stable APIs of the lowest supported version of the C libraries. This ensures the widest level of compatibility at runtime. This behavior can be overridden via specific version identifiers. It is recommended that you always select the minimum version you require _and no higher_. In this example, the Allegro dynamic binding is compiled to support Allegro 5.2.2:

__dub.json__
```
"dependencies": {
    "bindbc-allegro5": "~>1.0.0"
},
"versions": ["Allegro_5_2_2"]
```

__dub.sdl__
```
dependency "bindbc-allegro5" version="~>1.0.0"
versions "Allegro_5_2_2"
```

With this example configuration, `allegroSupport` is configured at compile time as `AllegroSupport.v5_2_2`. If Allegro 5.2.2 or later is installed on the system, `loadAllegro` will return `AllegroSupport.v5_2_2`. If a lower version of Allegro is installed, `loadAllegro` will return `AllegroSupport.badLibrary`. In this scenario, calling `loadedAllegroVersion()` will return an `AllegroSupport` member indicating which version of Allegro, if any, actually loaded.

If a lower version is loaded, it’s still possible to call functions from that version of Allegro, but any calls to functions from versions between that version and the one you configured will result in a null pointer access. For example, if you configured `Allegro 2.0.4` and loaded `Allegro 2.0.2`, then function pointers from both 2.0.3 and 2.0.4 will be `null`. For this reason, it’s recommended to always specify your required version of the Allegro library at compile time and abort when you receive an `AllegroSupport.badLibrary` return value from `loadAllegro`.

No matter which version was configured, the successfully loaded version can be obtained via a call to `loadedAllegroVersion`. It returns one of the following:

* `AllegroSupport.noLibrary` if `loadAllegro` returned `AllegroSupport.noLibrary`
* `AllegroSupport.badLibrary` if `loadAllegro` returned `AllegroSupport.badLibrary` and no version of Allegro successfully loaded
* a member of `AllegroSupport` indicating the version of Allegro that successfully loaded. When `loadAllegro` returns `AllegroSupport.badLibrary`, this will be a version number lower than the one configured at compile time. Otherwise, it will be the same as the manifest constant `allegroSupport`.

The function `isAllegro5Loaded` returns `true` if any version of the shared library has been loaded and `false` if not.

```d
AllegroSupport ret = loadAllegro();
if (ret != allegroSupport) {
    if (AllegroSupport.badLibrary) {
        /*
         Let’s say we’ve configured support for Allegro 5.2.5 for some of the functions 
         added to the Allegro API in that version and don’t use them if they 
         aren’t available. Let’s further say that the absolute minimum version
         of Allegro we require is 5.2.2, because we rely on some of the functions 
         that version added to the Allegro API.

         In this scenario, `AllegroSupport.badLibrary` indicates that we have 
         loaded a version of Allegro that is less than 5.2.5. Maybe it’s 5.2.4, 
         or 5.2.1. We require at least 5.2.2, so we can check.
        */
        if (loadedAllegroVersion < AllegroSupport.5_2_2) {
            // Version too low. Handle the error.
        }
    }
    /*
     The only other possible return value is `AllegroSupport.noLibrary`, 
     indicating the Allegro library or one of its dependencies could not be found.
    */
    else {
        // No library. Handle the error.
    }
}
```

For most use cases, it’s probably not necessary to check for `AllegroSupport.badLibrary` or `AllegroSupport.noLibrary`. The bindbc-loader package provides [a means to fetch error information](https://github.com/BindBC/bindbc-loader#error-handling) regarding load failures. This information can be written to a log file before aborting the program.

See [Package Declarations section](#package-declarations) for the supported versions of each Allegro library and the corresponding version IDs to pass to the compiler.


### The Static Bindings

First things first: static _bindings_ do not require static _linking_. The static bindings have a link-time dependency on either the shared _or_ static Allegro libraries and any satellite Allegro libraries the program uses. On Windows, you can link with the static libraries or, to use the DLLs, the import libraries. On other systems, you can link with either the static libraries or directly with the shared libraries.

Static bindings requires the Allegro development packages be installed on your system. [Allegro releases on GitHub](https://github.com/liballeg/allegro5/releases) provide precompiled Windows binaries. On OS X, you can use [Homebrew](https://formulae.brew.sh/formula/allegro). On Unix-like systems, you can install them via your system package manager. See [Allegro downloads page](https://liballeg.org/download.html) for details and additional options.

When linking with the shared (or import) libraries, there is a runtime dependency on the shared library just as there is when using the dynamic bindings. The difference is that the shared libraries are no longer loaded manually–loading is handled automatically by the system when the program is launched. Attempting to call `loadAllegro` with the static binding enabled will result in a compilation error.

When linking with the static libraries, there is no runtime dependency on Allegro. Besides static Allegro libraries, you also need to acquire all its dependencies and link with them. This is a lot of work with questionable benefits. 

Enabling the static bindings can be done in two ways.

#### Via the Compiler’s `-version` Switch or DUB’s `versions` Directive
Pass the `BindAllegro_Static` version to the compiler and link with the appropriate libraries. Note that `BindAllegro_Static` will also enable the static bindings for any addons used.

When using the compiler command line or a build system that doesn’t support DUB, this is the only option. The `-version=BindAllegro_Static` option should be passed to the compiler when building your program. All of the required C libraries, as well as the bindbc-allegro5 static libraries, must also be passed to the compiler on the command line or via your build system’s configuration.

__Note__: Though bindbc5-allegro is not an official BindBC package, it supports `BindBC_Static` version identifier.

For example, when using the static bindings for Allegro and Allegro_image with DUB:

__dub.json__
```
"dependencies": {
    "bindbc-allegro5": "~>1.0.0"
},
"versions": ["BindAllegro_Static", "Allegro_Image"],
"libs-windows": ["liballegro", "liballegro_image"]
```

__dub.sdl__
```
dependency "bindbc-allegro5" version="~>1.0.0"
versions "BindAllegro_Static" "Allegro_Image"
libs "liballegro" "liballegro_image"
```

#### Via DUB Subconfigurations
Instead of using DUB’s `versions` directive, a `subConfiguration` can be used. Enable the `static` subconfiguration for the bindbc-allegro5 dependency:

__dub.json__
```
"dependencies": {
    "bindbc-allegro5": "~>1.0.0"
},
"subConfigurations": {
    "bindbc-allegro5": "static"
},
"versions": [
    "Allegro_Image"
],
"libs": ["liballegro", "liballegro_image"]
```

__dub.sdl__
```
dependency "bindbc-allegro5" version="~>1.0.0"
subConfiguration "bindbc-allegro5" "static"
versions "Allegro_Image"
libs "liballegro" "liballegro_image"
```

This has the benefit of completely excluding from the build any source modules related to the dynamic bindings, i.e., they will never be passed to the compiler. Using the version approach, the related modules are still passed to the compiler, but their contents are versioned out.

### BetterC support
BetterC support is enabled via the `dynamicBC` and `staticBC` subconfigurations, for dynamic and static bindings respectively. To enable the static bindings with BetterC support:

__dub.json__
```
"dependencies": {
    "bindbc-allegro5": "~>1.0.0"
},
"subConfigurations": {
    "bindbc-allegro5": "staticBC"
},
"versions": [
    "Allegro_Image"
],
"libs": ["liballegro", "liballegro_image"]
```

__dub.sdl__
```
dependency "bindbc-allegro5" version="~>1.0.0"
subConfiguration "bindbc-allegro5" "staticBC"
versions "Allegro_Image"
libs "liballegro" "liballegro_image"
```

Replace `staticBC` with `dynamicBC` to enable BetterC support with the dynamic bindings.

When not using DUB to manage your project, first use DUB to compile the BindBC libraries with the `dynamicBC` or `staticBC` configuration, then pass `-betterC` to the compiler when building your project (and `-version=BindAllegro_Static` if you used the `staticBC` configuration).

## Package Declarations

To bind statically, define `BindAllegro_Static` version. If you use bindbc-allegro5 in conjunction with other BindBC packages, you can define `BindBC_Static` version to bind them all statically (some third-party BindBC packages may not support this). 

Functions:
```d
AllegroSupport loadAllegro();
AllegroSupport loadAllegro(const(char)* libName);
void unloadAllegro();
bool isAllegroLoaded();
AllegroSupport loadedAllegroVersion();
```

### Supported Allegro versions:

| Version     | Version ID       | `AllegroSupport` |
|-------------|------------------|-------------------|
| 5.2.0       | default          | `v5_2_0`          |
| 5.2.1       | `Allegro_5_2_1`  | `v5_2_1`          |
| 5.2.2       | `Allegro_5_2_2`  | `v5_2_2`          |
| 5.2.3       | `Allegro_5_2_3`  | `v5_2_3`          |
| 5.2.4       | `Allegro_5_2_4`  | `v5_2_4`          |
| 5.2.5       | `Allegro_5_2_5`  | `v5_2_5`          |
| 5.2.6       | `Allegro_5_2_6`  | `v5_2_6`          |
| 5.2.7       | `Allegro_5_2_7`  | `v5_2_7`          |
| 5.2.8       | `Allegro_5_2_8`  | `v5_2_8`          |


__Note__: To use Allegro debugging capabilities, define `ALLEGRO_DEBUG` version and link with debug library builds. 

__Note__: Parts of Allegro API, including most of the new functions introduced in 5.2.x releases, are marked as unstable. To use them, define `ALLEGRO_UNSTABLE` version. This will make compatibility checks more strict: this particular WIP version must be found on user’s system. For example, if `ALLEGRO_UNSTABLE` and `Allegro_5_2_3` are defined, and the user has Allegro 5.2.4 installed, Allegro will fail to initialize.

__Note__: To access X-specific functions, define `ALLEGRO_X11` version.

### Addons

Official addons are part of Allegro, so they don’t have their own versioning. 

Allegro can be build as a monolith library with all addons included. To link with such a library, define `Allegro_Monolith` version. With dynamic bindings, `loadAllegro` will also load all addon function. Attempts to call addon loading functions (like `loadAllegroImage`) will fail at compile time.

#### `Allegro_Image`
```d
AllegroSupport loadAllegroImage();
AllegroSupport loadAllegroImage(const(char)* libName);
void unloadAllegroImage();
bool isAllegroImageLoaded();
AllegroSupport loadedAllegroImageVersion();
```

#### `Allegro_Primitives`
```d
AllegroSupport loadAllegroPrimitives();
AllegroSupport loadAllegroPrimitives(const(char)* libName);
void unloadAllegroPrimitives();
bool isAllegroPrimitivesLoaded();
AllegroSupport loadedAllegroPrimitivesVersion();
```

#### `Allegro_Color`
```d
AllegroSupport loadAllegroColor();
AllegroSupport loadAllegroColor(const(char)* libName);
void unloadAllegroColor();
bool isAllegroColorLoaded();
AllegroSupport loadedAllegroColorVersion();
```

#### `Allegro_Font`
```d
AllegroSupport loadAllegroFont();
AllegroSupport loadAllegroFont(const(char)* libName);
void unloadAllegroFont();
bool isAllegroFontLoaded();
AllegroSupport loadedAllegroFontVersion();
```

#### `Allegro_TTF`
**Note**: Requires `Allegro_Font`
```d
AllegroSupport loadAllegroTTF();
AllegroSupport loadAllegroTTF(const(char)* libName);
void unloadAllegroTTF();
bool isAllegroTTFLoaded();
AllegroSupport loadedAllegroTTFVersion();
```

#### `Allegro_Audio`
```d
AllegroSupport loadAllegroAudio();
AllegroSupport loadAllegroAudio(const(char)* libName);
void unloadAllegroAudio();
bool isAllegroAudioLoaded();
AllegroSupport loadedAllegroAudioVersion();
```

#### `Allegro_ACodec`
**Note**: Requires `Allegro_Audio`
```d
AllegroSupport loadAllegroACodec();
AllegroSupport loadAllegroACodec(const(char)* libName);
void unloadAllegroACodec();
bool isAllegroACodecLoaded();
AllegroSupport loadedAllegroACodecVersion();
```

#### `Allegro_Video`
**Note**: Requires `Allegro_Audio`
```d
AllegroSupport loadAllegroVideo();
AllegroSupport loadAllegroVideo(const(char)* libName);
void unloadVideoAllegro();
bool isAllegroVideoLoaded();
AllegroSupport loadedAllegroVideoVersion();
```

#### `Allegro_Memfile`
```d
AllegroSupport loadAllegroMemfile();
AllegroSupport loadAllegroMemfile(const(char)* libName);
void unloadAllegroMemfile();
bool isAllegroMemfileLoaded();
AllegroSupport loadedAllegroMemfileVersion();
```

#### `Allegro_PhysFS`
```d
AllegroSupport loadAllegroAllegroPhysFS();
AllegroSupport loadAllegroAllegroPhysFS(const(char)* libName);
void unloadAllegroPhysFS();
bool isAllegroPhysFSLoaded();
AllegroSupport loadedAllegroPhysFSVersion();
```

#### `Allegro_NativeDialog`
```d
AllegroSupport loadAllegroAllegroDialog();
AllegroSupport loadAllegroAllegroDialog(const(char)* libName);
void unloadAllegroDialog();
bool isAllegroDialogLoaded();
AllegroSupport loadedAllegroDialogVersion();
```
