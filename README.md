# bindbc-allegro5

__Note__ This is not an official BindBC package.

This project provides both static and dynamic bindings
to the [Allegro libraries](https://liballeg.org). They are compatible
with `@nogc` and `nothrow` and can be compiled with BetterC compatibility.


## Basic Usage

The default configuration generates dynamic bindings to core Allegro v5.2.0
without BetterC compatibility. Dynamic binding assume run-time dynamic linking.

When using run-time dynamic linking, there are no link-time dependencies,
but the shared libraries (.dll/.so/.dylib depending on platform) must be present
on the user’s machine, and you need to load the libraries and bind to their
symbols before use. This is done by calling `loadAllegro` and the respective
functions from the addon submodules.

To target a newer version of Allegro, pass the respective version ID
from the [supported version list](#supported-versions), and to enable addons,
pass the respective version IDs from the [addon list](#addons).

An example that’s configured to use Allegro v5.2.3 with Font and TTF addons:

__dub.json__
```json
dependencies {
    "bindbc-allegro5": "~>1.0.0",
},
"versions": [
	"Allegro_5_2_3",
    "Allegro_Font",
    "Allegro_TTF"
]
```

__app.d__
```d
import bindbc.allegro5;
import bindbc.allegro5.allegro_font;
import bindbc.allegro5.allegro_ttf;

void main() {
    {
        AllegroSupport ret = loadAllegro();
        assert(ret < allegroSupport, "Error loading Allegro");
    }
    {
        AllegroSupport ret = loadAllegroFont();
        assert(ret < allegroSupport, "Error loading Allegro Font addon");
    }
    {
        AllegroSupport ret = loadAllegroTTF();
        assert(ret < allegroSupport, "Error loading Allegro TTF addon");
    }

    al_init();

    /* Your awesome game */

    al_uninstall_system();
}
```

`AllegroSupport` is a enumeration of `noLibrary`, `badLibrary`, and values from
the from the [supported version list](#supported-versions). `allegroSupport`
is a manifest constant equal to the target Allegro version (`v5_2_3` in our case).
`loadAllegro` will return  version number on success or `noLibrary`/ `badLibrary`
on failure. The version number may be lower than `allegroSupport`, indicating
that the older version was loaded. This example just asserts that the libraries
are loaded properly and are no older than v5.2.3, but in the real code you
should show a proper error message if the libraries are not found
or not compatible. See
[bindbc-loader error reporting API](https://github.com/BindBC/bindbc-loader#error-handling).


## Supported Versions

| Version | Version ID       | `AllegroSupport` |
|---------|------------------|------------------|
| 5.2.0   | default          | `v5_2_0`         |
| 5.2.1   | `Allegro_5_2_1`  | `v5_2_1`         |
| 5.2.2   | `Allegro_5_2_2`  | `v5_2_2`         |
| 5.2.3   | `Allegro_5_2_3`  | `v5_2_3`         |
| 5.2.4   | `Allegro_5_2_4`  | `v5_2_4`         |
| 5.2.5   | `Allegro_5_2_5`  | `v5_2_5`         |
| 5.2.6   | `Allegro_5_2_6`  | `v5_2_6`         |
| 5.2.7   | `Allegro_5_2_7`  | `v5_2_7`         |
| 5.2.8   | `Allegro_5_2_8`  | `v5_2_8`         |
| 5.2.9   | `Allegro_5_2_9`  | `v5_2_9`         |
| 5.2.10  | `Allegro_5_2_10` | `v5_2_10`        |

__Note__: Parts of Allegro API, including most of the new functions introduced
in 5.2.x releases, are marked as unstable. If you want to enable unstable API,
pass the `ALLEGRO_UNSTABLE` version. Unstable API is tied to a specific release;
e.g. if `ALLEGRO_UNSTABLE` and `Allegro_5_2_3` are passed but the user happen
to have Allegro v5.2.4 or newer, the system will fail to initialize.


## Addons

| Addon                              | Version ID           | Submodule               |
|------------------------------------|----------------------|-------------------------|
| Image                              | `Allegro_Image`      | `allegro_image`         |
| Primitives                         | `Allegro_Primitives` | `allegro_primitives`    |
| Color                              | `Allegro_Color`      | `allegro_color`         |
| Font                               | `Allegro_Font`       | `allegro_font`          |
| TTF (requires Font addon)          | `Allegro_TTF`        | `allegro_ttf`           |
| Audio                              | `Allegro_Audio`      | `allegro_audio`         |
| Audio Codec (requires Audio addon) | `Allegro_ACodec`     | `allegro_acodec`        |
| Video (requires Audio addon)       | `Allegro_Video`      | `allegro_video`         |
| Memfile                            | `Allegro_Memfile`    | `allegro_memfile`       |
| PhysicsFS                          | `Allegro_PhysFS`     | `allegro_physfs`        |
| Native Dialogs                     | `Allegro_Dialog`     | `allegro_native_dialog` |

Official addons are part of the Allegro package, so they don’t have their own
versioning.

Allegro can be built with all addons included. This is called monolith build.
To bind to it, pass `Allegro_Monolith` version. With dynamic bindings,
`loadAllegro` will also bind to all addon functions. You don’t need to call
addon loading functions such as `loadAllegroImage` (they are not even defined
in the monolith version).


## Dynamic Bindings API

```d
AllegroSupport loadAllegro();
AllegroSupport loadAllegro(const(char)* libName);
void unloadAllegro();
bool isAllegroLoaded();
AllegroSupport loadedAllegroVersion();
```

Image addon:
```d
AllegroSupport loadAllegroImage();
AllegroSupport loadAllegroImage(const(char)* libName);
void unloadAllegroImage();
bool isAllegroImageLoaded();
AllegroSupport loadedAllegroImageVersion();
```

Primitives addon:
```d
AllegroSupport loadAllegroPrimitives();
AllegroSupport loadAllegroPrimitives(const(char)* libName);
void unloadAllegroPrimitives();
bool isAllegroPrimitivesLoaded();
AllegroSupport loadedAllegroPrimitivesVersion();
```

Color addon:
```d
AllegroSupport loadAllegroColor();
AllegroSupport loadAllegroColor(const(char)* libName);
void unloadAllegroColor();
bool isAllegroColorLoaded();
AllegroSupport loadedAllegroColorVersion();
```

Font addon:
```d
AllegroSupport loadAllegroFont();
AllegroSupport loadAllegroFont(const(char)* libName);
void unloadAllegroFont();
bool isAllegroFontLoaded();
AllegroSupport loadedAllegroFontVersion();
```

TTF addon:
```d
AllegroSupport loadAllegroTTF();
AllegroSupport loadAllegroTTF(const(char)* libName);
void unloadAllegroTTF();
bool isAllegroTTFLoaded();
AllegroSupport loadedAllegroTTFVersion();
```

Audio addon:
```d
AllegroSupport loadAllegroAudio();
AllegroSupport loadAllegroAudio(const(char)* libName);
void unloadAllegroAudio();
bool isAllegroAudioLoaded();
AllegroSupport loadedAllegroAudioVersion();
```

Audio Codec addon:
```d
AllegroSupport loadAllegroACodec();
AllegroSupport loadAllegroACodec(const(char)* libName);
void unloadAllegroACodec();
bool isAllegroACodecLoaded();
AllegroSupport loadedAllegroACodecVersion();
```

Video addon:
```d
AllegroSupport loadAllegroVideo();
AllegroSupport loadAllegroVideo(const(char)* libName);
void unloadVideoAllegro();
bool isAllegroVideoLoaded();
AllegroSupport loadedAllegroVideoVersion();
```

Memfile addon:
```d
AllegroSupport loadAllegroMemfile();
AllegroSupport loadAllegroMemfile(const(char)* libName);
void unloadAllegroMemfile();
bool isAllegroMemfileLoaded();
AllegroSupport loadedAllegroMemfileVersion();
```

PhysicsFS addon:
```d
AllegroSupport loadAllegroPhysFS();
AllegroSupport loadAllegroPhysFS(const(char)* libName);
void unloadAllegroPhysFS();
bool isAllegroPhysFSLoaded();
AllegroSupport loadedAllegroPhysFSVersion();
```

Native Dialogs  addon:
```d
AllegroSupport loadAllegroDialog();
AllegroSupport loadAllegroDialog(const(char)* libName);
void unloadAllegroDialog();
bool isAllegroDialogLoaded();
AllegroSupport loadedAllegroDialogVersion();
```

## The Static Bindings

Static bindings can be used for static linking and load-time dynamic linking.
You may need Allegro development package installed on your system.
[Allegro releases on GitHub](https://github.com/liballeg/allegro5/releases)
provide precompiled Windows binaries. On OS X, you can use
[Homebrew](https://formulae.brew.sh/formula/allegro). On other systems, they may
be available on your system package repository. See
[Allegro downloads page](https://liballeg.org/download.html)
for details and additional options.

When using load-time dynamic linking, there is a runtime dependency on the shared
libraries just as there is when using the run-time dynamic bindings. The difference
is that the OS automatically loads the required libraries and bind to their symbols
when the program is launched, so there’s no need to call any functions from dynamic
binding API such as `loadAllegro` (they are not even defined in the static bindings).
You need to statically link against the import libraries from the development
packages (on Windows) or directly against the shared libraries (on other systems).

When using static linking, there are no runtime dependencies, but there is
a link-time dependency on static Allegro libraries from the development packages,
*and all their dependencies* in the form of static libraries for the target platform.
This is the only option if dynamic linking is not allowed, such as when targeting
iOS. See [Allegro README](https://github.com/liballeg/allegro5?tab=readme-ov-file#library-dependencies)
for details.

Static bindings are enabled by passing the `BindAllegro_Static` version.
Alternatively, if you use DUB to build your project, you can select the `static`
configuration:

__dub.json__
```json
"dependencies": {
    "bindbc-allegro5": "~>1.0.0"
},
"subConfigurations": {
    "bindbc-allegro5": "static"
},
"versions": [ "Allegro_Image" ],
"libs": ["liballegro", "liballegro_image"]
```
This package also recognizes the `BindBC_Static` version that can be used
to enable static binding for all BindBC packages that support this option.


## BetterC support

BetterC support is enabled by selecting `dynamicBC` or `staticBC` configuration,
for dynamic and static bindings respectively. When not using DUB to manage your
project, first use DUB to compile the BindBC libraries in the `dynamicBC`
or `staticBC` configuration, then pass `-betterC` to the compiler when building
your project (and `-version=BindAllegro_Static` if you selected the `staticBC`
configuration).


## Misc

To enable Allegro debugging capabilities, pass `ALLEGRO_DEBUG` version
and link against debug library builds.

To access X11-specific functions, pass `ALLEGRO_X11` version.

