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

	@nogc nothrow:

	version (Allegro_Monolith) {} else {

		private {
			__gshared SharedLib lib;
			__gshared AllegroSupport loadedVersion;
		}

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
			const(char)[][1] libNames = [
				dynlibFilename!"physfs",
			];

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
			loadedVersion = bindAllegroPhysFS(lib);
			return loadedVersion == allegroSupport ? allegroSupport : AllegroSupport.badLibrary;
		}
	}

	package AllegroSupport bindAllegroPhysFS(SharedLib lib) {
		auto lastErrorCount = errorCount();
		auto loadedVersion = AllegroSupport.badLibrary;

		lib.bindSymbol(cast(void**)&al_set_physfs_file_interface, "al_set_physfs_file_interface");
		lib.bindSymbol(cast(void**)&al_get_allegro_physfs_version, "al_get_allegro_physfs_version");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}

		return allegroSupport;
	}
}
