module bindbc.allegro5.allegro_physfs;

import bindbc.allegro5.config;

static if (allegroPhysFS):

static if (staticBinding) {
	extern(C) @nogc nothrow:
	void al_set_physfs_file_interface();
	uint al_get_allegro_physfs_version();
}
else {
	extern(C) @nogc nothrow {
		alias pal_set_physfs_file_interface = void function();
		alias pal_get_allegro_physfs_version = uint function();
	}
	__gshared {
		pal_set_physfs_file_interface al_set_physfs_file_interface;
		pal_get_allegro_physfs_version al_get_allegro_physfs_version;
	}

	import bindbc.loader;

	private {
		__gshared SharedLib lib;
		__gshared AllegroSupport loadedVersion;
	}

	@nogc nothrow:

	void unloadAllegroPhysFS() {
		if (lib != invalidHandle) {
			lib.unload();
		}
	}

	AllegroSupport loadedAllegroPhysFSVersion() {
		return loadedVersion; 
	}

	bool isAllegroPhysFSLoaded() {
		return lib != invalidHandle;
	}

	AllegroSupport loadAllegroPhysFS() {
		// FIXME: add OSX & POSIX
		version (Windows) {
			version (ALLEGRO_DEBUG) {
				const(char)[][1] libNames = [
					"allegro_physfs-debug-5.2.dll",
				];
			}
			else {
				const(char)[][1] libNames = [
					"allegro_physfs-5.2.dll",
				];
			}
		}
		else static assert(0, "bindbc-allegro5 is not yet supported on this platform.");

		typeof(return) result;
		foreach (i; 0..libNames.length) {
			result = loadAllegroPhysFS(libNames[i].ptr);
			if (result != AllegroSupport.noLibrary) {
				break;
			}
		}
		return result;
	}

	AllegroSupport loadAllegroPhysFS(const(char)* libName) {
		lib = load(libName);
		if (lib == invalidHandle) {
			return AllegroSupport.noLibrary;
		}

		auto lastErrorCount = errorCount();
		loadedVersion = AllegroSupport.badLibrary;

		lib.bindSymbol(cast(void**)&al_set_physfs_file_interface, "al_set_physfs_file_interface");
		lib.bindSymbol(cast(void**)&al_get_allegro_physfs_version, "al_get_allegro_physfs_version");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}
		loadedVersion = AllegroSupport.v5_2_0;

		return loadedVersion;
	}
}
