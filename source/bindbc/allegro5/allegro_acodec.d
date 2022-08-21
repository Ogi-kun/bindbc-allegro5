module bindbc.allegro5.allegro_acodec;

import bindbc.allegro5.config;

static if (allegroACodec):
static assert (allegroAudio, "`allegro_acodec` depends on `allegro_audio`");

static if (staticBinding) {
	extern(C) @nogc nothrow:
	bool al_init_acodec_addon();
	uint al_get_allegro_acodec_version();

	static if (allegroSupport >= AllegroSupport.v5_2_6) {
		bool al_is_acodec_addon_initialized();
	}
}
else {
	extern(C) @nogc nothrow {
		alias pal_init_acodec_addon = bool function();
		alias pal_get_allegro_acodec_version = uint function();

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			alias pal_is_acodec_addon_initialized = bool function();
		}
	}
	__gshared {
		pal_init_acodec_addon al_init_acodec_addon;
		pal_get_allegro_acodec_version al_get_allegro_acodec_version;

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			pal_is_acodec_addon_initialized al_is_acodec_addon_initialized;
		}
	}


	import bindbc.loader;

	@nogc nothrow:

	version (Allegro_Monolith) {} else { 

		private {
			__gshared SharedLib lib;
			__gshared AllegroSupport loadedVersion;
		}

		void unloadAllegroACodec() {
			if (lib != invalidHandle) {
				lib.unload();
			}
		}

		AllegroSupport loadedAllegroACodecVersion() {
			return loadedVersion; 
		}

		bool isAllegroACodecLoaded() {
			return lib != invalidHandle;
		}

		AllegroSupport loadAllegroACodec() {

			const(char)[][1] libNames = [
				libName!"acodec",
			];

			typeof(return) result;
			foreach (i; 0..libNames.length) {
				result = loadAllegroACodec(libNames[i].ptr);
				if (result != AllegroSupport.noLibrary) {
					break;
				}
			}
			return result;
		}

		AllegroSupport loadAllegroACodec(const(char)* libName) {
			lib = load(libName);
			if (lib == invalidHandle) {
				return AllegroSupport.noLibrary;
			}
			loadedVersion = bindAllegroACodec(lib, libName);
			return loadedVersion;
		}
	}

	package AllegroSupport bindAllegroACodec(SharedLib lib, const(char)* libName) {

		auto lastErrorCount = errorCount();
		auto loadedVersion = AllegroSupport.badLibrary;


		lib.bindSymbol(cast(void**)&al_init_acodec_addon, "al_init_acodec_addon");
		lib.bindSymbol(cast(void**)&al_get_allegro_acodec_version, "al_get_allegro_acodec_version");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}
		loadedVersion = AllegroSupport.v5_2_0;


		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&al_is_acodec_addon_initialized, "al_is_acodec_addon_initialized");
			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
			loadedVersion = AllegroSupport.v5_2_6;
		}

		return loadedVersion;
		
	}

}
