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
	pragma(inline, true) extern(C) @nogc nothrow {
		bool al_init_acodec_addon() => ptr_al_init_acodec_addon();
		uint al_get_allegro_acodec_version() => ptr_al_get_allegro_acodec_version();
		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			bool al_is_acodec_addon_initialized() => ptr_al_is_acodec_addon_initialized();
		}
	}
	private __gshared {
		typeof(&al_init_acodec_addon) ptr_al_init_acodec_addon;
		typeof(&al_get_allegro_acodec_version) ptr_al_get_allegro_acodec_version;
		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			typeof(&al_is_acodec_addon_initialized) ptr_al_is_acodec_addon_initialized;
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
				dynlibFilename!"acodec",
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
			loadedVersion = bindAllegroACodec(lib);
			return loadedVersion == allegroSupport ? allegroSupport : AllegroSupport.badLibrary;
		}
	}

	package AllegroSupport bindAllegroACodec(SharedLib lib) {

		auto lastErrorCount = errorCount();

		lib.bindSymbol(cast(void**)&ptr_al_init_acodec_addon, "al_init_acodec_addon");
		lib.bindSymbol(cast(void**)&ptr_al_get_allegro_acodec_version, "al_get_allegro_acodec_version");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&ptr_al_is_acodec_addon_initialized, "al_is_acodec_addon_initialized");
			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_5;
			}
		}

		return allegroSupport;

	}

}
