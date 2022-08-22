module bindbc.allegro5.allegro_image;

import bindbc.allegro5.config;

static if (allegroImage):

static if (staticBinding) {
	extern(C) @nogc nothrow:

	bool al_init_image_addon();
	void al_shutdown_image_addon();
	uint al_get_allegro_image_version();

	static if (allegroSupport >= AllegroSupport.v5_2_6) {
		bool al_is_image_addon_initialized();
	}

}
else {
	extern(C) @nogc nothrow {
		alias pal_init_image_addon = bool function();
		alias pal_shutdown_image_addon = void function();
		alias pal_get_allegro_image_version = uint function();

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			alias pal_is_image_addon_initialized = bool function();
		}
	}
	__gshared {
		pal_init_image_addon al_init_image_addon;
		pal_shutdown_image_addon al_shutdown_image_addon;
		pal_get_allegro_image_version al_get_allegro_image_version;

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			pal_is_image_addon_initialized al_is_image_addon_initialized;
		}
	}

	import bindbc.loader;

	@nogc nothrow:

	version (Allegro_Monolith) {} else { 
		
		private {
			__gshared SharedLib lib;
			__gshared AllegroSupport loadedVersion;
		}

		void unloadAllegroImage() {
			if (lib != invalidHandle) {
				lib.unload();
			}
		}

		AllegroSupport loadedAllegroImageVersion() {
			return loadedVersion; 
		}

		bool isAllegroImageLoaded() {
			return lib != invalidHandle;
		}

		AllegroSupport loadAllegroImage() {
			const(char)[][1] libNames = [
				libName!"image",
			];

			typeof(return) result;
			foreach (i; 0..libNames.length) {
				result = loadAllegroImage(libNames[i].ptr);
				if (result != AllegroSupport.noLibrary) {
					break;
				}
			}
			return result;
		}

		AllegroSupport loadAllegroImage(const(char)* libName) {
			lib = load(libName);
			if (lib == invalidHandle) {
				return AllegroSupport.noLibrary;
			}

			loadedVersion = bindAllegroImage(lib);
			return loadedVersion == allegroSupport ? allegroSupport : AllegroSupport.badLibrary;
		}
	}

	package AllegroSupport bindAllegroImage(SharedLib lib) {
		
		auto lastErrorCount = errorCount();

		lib.bindSymbol(cast(void**)&al_init_image_addon, "al_init_image_addon");
		lib.bindSymbol(cast(void**)&al_shutdown_image_addon, "al_shutdown_image_addon");
		lib.bindSymbol(cast(void**)&al_get_allegro_image_version, "al_get_allegro_image_version");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&al_is_image_addon_initialized, "al_is_image_addon_initialized");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_5;
			}
		}

		return allegroSupport;
	}
}
