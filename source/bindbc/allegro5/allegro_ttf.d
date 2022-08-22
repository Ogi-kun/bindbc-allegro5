module bindbc.allegro5.allegro_ttf;

import bindbc.allegro5.config;

static if (allegroTTF):
static assert (allegroFont, "`allegro_ttf` depends on `allegro_font`");

import bindbc.allegro5.allegro_font : ALLEGRO_FONT;
import bindbc.allegro5.bind.file : ALLEGRO_FILE;


enum ALLEGRO_TTF_NO_KERNING  = 1;
enum ALLEGRO_TTF_MONOCHROME  = 2;
enum ALLEGRO_TTF_NO_AUTOHINT = 4;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	bool al_init_ttf_addon();
	void al_shutdown_ttf_addon();
	uint al_get_allegro_ttf_version();

	ALLEGRO_FONT* al_load_ttf_font(const(char)* filename, int size, int flags);
	ALLEGRO_FONT* al_load_ttf_font_f(ALLEGRO_FILE* file, const(char)* filename, int size, int flags);
	ALLEGRO_FONT* al_load_ttf_font_stretch(const(char)* filename, int w, int h, int flags);
	ALLEGRO_FONT* al_load_ttf_font_stretch_f(ALLEGRO_FILE* file, const(char)* filename, int w, int h, int flags);

	static if (allegroSupport >= AllegroSupport.v5_2_6) {
		bool al_is_ttf_addon_initialized();
	}
}

else {
	extern(C) @nogc nothrow {
		alias pal_init_ttf_addon = bool function();
		alias pal_shutdown_ttf_addon = void function();
		alias pal_get_allegro_ttf_version = uint function();

		alias pal_load_ttf_font = ALLEGRO_FONT* function(const(char)* filename, int size, int flags);
		alias pal_load_ttf_font_f = ALLEGRO_FONT* function(ALLEGRO_FILE* file, const(char)* filename, int size, int flags);
		alias pal_load_ttf_font_stretch = ALLEGRO_FONT* function(const(char)* filename, int w, int h, int flags);
		alias pal_load_ttf_font_stretch_f = ALLEGRO_FONT* function(ALLEGRO_FILE* file, const(char)* filename, int w, int h, int flags);
	
		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			alias pal_is_ttf_addon_initialized = bool function();
		}
	}
	__gshared {
		pal_init_ttf_addon al_init_ttf_addon;
		pal_shutdown_ttf_addon al_shutdown_ttf_addon;
		pal_get_allegro_ttf_version al_get_allegro_ttf_version;

		pal_load_ttf_font al_load_ttf_font;
		pal_load_ttf_font_f al_load_ttf_font_f;
		pal_load_ttf_font_stretch al_load_ttf_font_stretch;
		pal_load_ttf_font_stretch_f al_load_ttf_font_stretch_f;
	
		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			pal_is_ttf_addon_initialized al_is_ttf_addon_initialized;
		}
	}

	import bindbc.loader;

	@nogc nothrow:

	version (Allegro_Monolith) {} else {

		private {
			__gshared SharedLib lib;
			__gshared AllegroSupport loadedVersion;
		}
		
		void unloadAllegroTTF() {
			if (lib != invalidHandle) {
				lib.unload();
			}
		}
	
		AllegroSupport loadedAllegroTTFVersion() {
			return loadedVersion; 
		}
	
		bool isAllegroTTFLoaded() {
			return lib != invalidHandle;
		}
	
		AllegroSupport loadAllegroTTF() {
			const(char)[][1] libNames = [
				libName!"ttf",
			];
	
			typeof(return) result;
			foreach (i; 0..libNames.length) {
				result = loadAllegroTTF(libNames[i].ptr);
				if (result != AllegroSupport.noLibrary) {
					break;
				}
			}
			return result;
		}

		AllegroSupport loadAllegroTTF(const(char)* libName) {
			lib = load(libName);
			if (lib == invalidHandle) {
				return AllegroSupport.noLibrary;
			}
			loadedVersion = bindAllegroTTF(lib);
			return loadedVersion;
		}
	}

	package AllegroSupport bindAllegroTTF(SharedLib lib) {

		auto lastErrorCount = errorCount();
		auto loadedVersion = AllegroSupport.badLibrary;

		lib.bindSymbol(cast(void**)&al_init_ttf_addon, "al_init_ttf_addon");
		lib.bindSymbol(cast(void**)&al_shutdown_ttf_addon, "al_shutdown_ttf_addon");
		lib.bindSymbol(cast(void**)&al_get_allegro_ttf_version, "al_get_allegro_ttf_version");

		lib.bindSymbol(cast(void**)&al_load_ttf_font, "al_load_ttf_font");
		lib.bindSymbol(cast(void**)&al_load_ttf_font_f, "al_load_ttf_font_f");
		lib.bindSymbol(cast(void**)&al_load_ttf_font_stretch, "al_load_ttf_font_stretch");
		lib.bindSymbol(cast(void**)&al_load_ttf_font_stretch_f, "al_load_ttf_font_stretch_f");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}
		loadedVersion = AllegroSupport.v5_2_0;

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&al_is_ttf_addon_initialized, "al_is_ttf_addon_initialized");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
			loadedVersion = AllegroSupport.v5_2_6;
		}

		return loadedVersion;
	}
}
