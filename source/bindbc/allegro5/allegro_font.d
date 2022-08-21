module bindbc.allegro5.allegro_font;

import bindbc.allegro5.config;

static if (allegroFont):

import bindbc.allegro5.bind.color : ALLEGRO_COLOR;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import bindbc.allegro5.bind.utf8 : ALLEGRO_USTR;

struct ALLEGRO_FONT;

version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_1) {
	struct ALLEGRO_GLYPH {
		ALLEGRO_BITMAP* bitmap;
		int x;
		int y;
		int w;
		int h;
		int kerning;
		int offset_x;
		int offset_y;
		int advance;
	}
}

enum {
	ALLEGRO_NO_KERNING       = -1,
	ALLEGRO_ALIGN_LEFT       = 0,
	ALLEGRO_ALIGN_CENTRE     = 1,
	ALLEGRO_ALIGN_CENTER     = 1,
	ALLEGRO_ALIGN_RIGHT      = 2,
	ALLEGRO_ALIGN_INTEGER    = 4,
}

static if (staticBinding) {
	extern(C) @nogc nothrow:

	bool al_init_font_addon();
	void al_shutdown_font_addon();
	uint al_get_allegro_font_version();

	ALLEGRO_FONT* al_load_bitmap_font(const(char)* filename);
	ALLEGRO_FONT* al_load_bitmap_font_flags(const(char)* filename, int flags);
	ALLEGRO_FONT* al_load_font(const(char)* filename, int size, int flags);
	ALLEGRO_FONT* al_grab_font_from_bitmap(ALLEGRO_BITMAP* bmp, int n, const(int)* ranges);
	ALLEGRO_FONT* al_create_builtin_font();
	bool al_register_font_loader(const(char)* ext, ALLEGRO_FONT* function(const(char)* filename, int size, int flags) load);
	void al_destroy_font(ALLEGRO_FONT* f);

	void al_set_fallback_font(ALLEGRO_FONT* font, ALLEGRO_FONT* fallback);
	ALLEGRO_FONT* al_get_fallback_font(ALLEGRO_FONT* font);

	void al_draw_ustr(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(ALLEGRO_USTR)* ustr);
	void al_draw_text(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(char)* text);
	void al_draw_justified_text(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(char)* text);
	void al_draw_justified_ustr(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(ALLEGRO_USTR)* text);
	void al_draw_textf(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(char)* format, ...);
	void al_draw_justified_textf(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(char)* format, ...);
	
	int al_get_font_line_height(const(ALLEGRO_FONT)* f);
	int al_get_font_ascent(const(ALLEGRO_FONT)* f);
	int al_get_font_descent(const(ALLEGRO_FONT)* f);
	int al_get_font_ranges(ALLEGRO_FONT* font, int ranges_count, int* ranges);

	int al_get_text_width(const(ALLEGRO_FONT)* f, const(char)* str);
	int al_get_ustr_width(const(ALLEGRO_FONT)* f, const(ALLEGRO_USTR)* ustr);
	void al_get_ustr_dimensions(const(ALLEGRO_FONT)* f, const(ALLEGRO_USTR)* text, int* bbx, int* bby, int* bbw, int* bbh);
	void al_get_text_dimensions(const(ALLEGRO_FONT)* f, const(char)* text, int* bbx, int* bby, int* bbw, int* bbh);
	
	int al_get_glyph_width(const(ALLEGRO_FONT)* f, int codepoint);
	bool al_get_glyph_dimensions(const(ALLEGRO_FONT)* f, int codepoint, int* bbx, int* bby, int* bbw, int* bbh);
	int al_get_glyph_advance(const(ALLEGRO_FONT)* f, int codepoint1, int codepoint2);
	
	void al_draw_glyph(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int codepoint);
	void al_draw_multiline_text(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, float max_width, float line_height, int flags, const(char)* text);
	void al_draw_multiline_textf(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, float max_width, float line_height, int flags, const(char)* format, ...);
	void al_draw_multiline_ustr(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, float max_width, float line_height, int flags, const(ALLEGRO_USTR)* text);

	void al_do_multiline_text(const(ALLEGRO_FONT)* font, float max_width, const(char)* text, bool function(int line_num, const(char)* line, int size, void* extra) cb, void* extra);
	void al_do_multiline_ustr(const(ALLEGRO_FONT)* font, float max_width, const(ALLEGRO_USTR)* ustr, bool function(int line_num, const(ALLEGRO_USTR)* line, void* extra) cb, void* extra);

	static if (allegroSupport >= AllegroSupport.v5_2_1) {
		version (ALLEGRO_UNSTABLE) {
			bool al_get_glyph(const(ALLEGRO_FONT)* f, int prev_codepoint, int codepoint, ALLEGRO_GLYPH* glyph);
		}
	}

	static if (allegroSupport >= AllegroSupport.v5_2_6) {
		bool al_is_font_addon_initialized();
	}
}
else {
	extern(C) @nogc nothrow {
	
		alias pal_init_font_addon = bool function();
		alias pal_shutdown_font_addon = void function();
		alias pal_get_allegro_font_version = uint function();
	
		alias pal_load_bitmap_font = ALLEGRO_FONT* function(const(char)* filename);
		alias pal_load_bitmap_font_flags = ALLEGRO_FONT* function(const(char)* filename, int flags);
		alias pal_load_font = ALLEGRO_FONT* function(const(char)* filename, int size, int flags);
		alias pal_grab_font_from_bitmap = ALLEGRO_FONT* function(ALLEGRO_BITMAP* bmp, int n, const(int)* ranges);
		alias pal_create_builtin_font = ALLEGRO_FONT* function();
		alias pal_register_font_loader = bool function(const(char)* ext, ALLEGRO_FONT* function(const(char)* filename, int size, int flags) load);
		alias pal_destroy_font = void function(ALLEGRO_FONT* f);
	
		alias pal_set_fallback_font = void function(ALLEGRO_FONT* font, ALLEGRO_FONT* fallback);
		alias pal_get_fallback_font = ALLEGRO_FONT* function(ALLEGRO_FONT* font);
	
		alias pal_draw_ustr = void function(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(ALLEGRO_USTR)* ustr);
		alias pal_draw_text = void function(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(char)* text);
		alias pal_draw_justified_text = void function(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(char)* text);
		alias pal_draw_justified_ustr = void function(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(ALLEGRO_USTR)* text);
		alias pal_draw_textf = void function(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(char)* format, ...);
		alias pal_draw_justified_textf = void function(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(char)* format, ...);
		
		alias pal_get_font_line_height = int function(const(ALLEGRO_FONT)* f);
		alias pal_get_font_ascent = int function(const(ALLEGRO_FONT)* f);
		alias pal_get_font_descent = int function(const(ALLEGRO_FONT)* f);
		alias pal_get_font_ranges = int function(ALLEGRO_FONT* font, int ranges_count, int* ranges);
	
		alias pal_get_text_width = int function(const(ALLEGRO_FONT)* f, const(char)* str);
		alias pal_get_ustr_width = int function(const(ALLEGRO_FONT)* f, const(ALLEGRO_USTR)* ustr);
		alias pal_get_ustr_dimensions = void function(const(ALLEGRO_FONT)* f, const(ALLEGRO_USTR)* text, int* bbx, int* bby, int* bbw, int* bbh);
		alias pal_get_text_dimensions = void function(const(ALLEGRO_FONT)* f, const(char)* text, int* bbx, int* bby, int* bbw, int* bbh);
		
		alias pal_get_glyph_width = int function(const(ALLEGRO_FONT)* f, int codepoint);
		alias pal_get_glyph_dimensions = bool function(const(ALLEGRO_FONT)* f, int codepoint, int* bbx, int* bby, int* bbw, int* bbh);
		alias pal_get_glyph_advance = int function(const(ALLEGRO_FONT)* f, int codepoint1, int codepoint2);
		
		alias pal_draw_glyph = void function(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int codepoint);
		alias pal_draw_multiline_text = void function(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, float max_width, float line_height, int flags, const(char)* text);
		alias pal_draw_multiline_textf = void function(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, float max_width, float line_height, int flags, const(char)* format, ...);
		alias pal_draw_multiline_ustr = void function(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, float max_width, float line_height, int flags, const(ALLEGRO_USTR)* text);
	
		alias pal_do_multiline_text = void function(const(ALLEGRO_FONT)* font, float max_width, const(char)* text, bool function(int line_num, const(char)* line, int size, void* extra) cb, void* extra);
		alias pal_do_multiline_ustr = void function(const(ALLEGRO_FONT)* font, float max_width, const(ALLEGRO_USTR)* ustr, bool function(int line_num, const(ALLEGRO_USTR)* line, void* extra) cb, void* extra);
	
		static if (allegroSupport >= AllegroSupport.v5_2_1) {
			version (ALLEGRO_UNSTABLE) {
				alias pal_get_glyph = bool function(const(ALLEGRO_FONT)* f, int prev_codepoint, int codepoint, ALLEGRO_GLYPH* glyph);
			}
		}
		
		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			alias pal_is_font_addon_initialized = bool function();
		}
	}

	__gshared {
		pal_init_font_addon al_init_font_addon;
		pal_shutdown_font_addon al_shutdown_font_addon;
		pal_get_allegro_font_version al_get_allegro_font_version;

		pal_load_bitmap_font al_load_bitmap_font;
		pal_load_bitmap_font_flags al_load_bitmap_font_flags;
		pal_load_font al_load_font;
		pal_grab_font_from_bitmap al_grab_font_from_bitmap;
		pal_create_builtin_font al_create_builtin_font;
		pal_register_font_loader al_register_font_loader;
		pal_destroy_font al_destroy_font;

		pal_set_fallback_font al_set_fallback_font;
		pal_get_fallback_font al_get_fallback_font;

		pal_draw_ustr al_draw_ustr;
		pal_draw_text al_draw_text;
		pal_draw_justified_text al_draw_justified_text;
		pal_draw_justified_ustr al_draw_justified_ustr;
		pal_draw_textf al_draw_textf;
		pal_draw_justified_textf al_draw_justified_textf;
		
		pal_get_font_line_height al_get_font_line_height;
		pal_get_font_ascent al_get_font_ascent;
		pal_get_font_descent al_get_font_descent;
		pal_get_font_ranges al_get_font_ranges;

		pal_get_text_width al_get_text_width;
		pal_get_ustr_width al_get_ustr_width;
		pal_get_ustr_dimensions al_get_ustr_dimensions;
		pal_get_text_dimensions al_get_text_dimensions;
		
		pal_get_glyph_width al_get_glyph_width;
		pal_get_glyph_dimensions al_get_glyph_dimensions;
		pal_get_glyph_advance al_get_glyph_advance;
		
		pal_draw_glyph al_draw_glyph;
		pal_draw_multiline_text al_draw_multiline_text;
		pal_draw_multiline_textf al_draw_multiline_textf;
		pal_draw_multiline_ustr al_draw_multiline_ustr;

		pal_do_multiline_text al_do_multiline_text;
		pal_do_multiline_ustr al_do_multiline_ustr;

		static if (allegroSupport >= AllegroSupport.v5_2_1) {
			version (ALLEGRO_UNSTABLE) {
				pal_get_glyph al_get_glyph;
			}
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			pal_is_font_addon_initialized al_is_font_addon_initialized;
		}
	}

	import bindbc.loader;

	private {
		__gshared SharedLib lib;
		__gshared AllegroSupport loadedVersion;
	}

	@nogc nothrow:

	void unloadAllegroFont() {
		if (lib != invalidHandle) {
			lib.unload();
		}
	}

	AllegroSupport loadedAllegroFontVersion() {
		return loadedVersion; 
	}

	bool isAllegroFontLoaded() {
		return lib != invalidHandle;
	}

	AllegroSupport loadAllegroFont() {
		// FIXME: add OSX & POSIX
		version (Windows) {
			version (ALLEGRO_DEBUG) {
				const(char)[][1] libNames = [
					"allegro_font-debug-5.2.dll",
				];
			}
			else {
				const(char)[][1] libNames = [
					"allegro_font-5.2.dll",
				];
			}
		}
		else static assert(0, "bindbc-allegro5 is not yet supported on this platform.");

		typeof(return) result;
		foreach (i; 0..libNames.length) {
			result = loadAllegroFont(libNames[i].ptr);
			if (result != AllegroSupport.noLibrary) {
				break;
			}
		}
		return result;
	}

	AllegroSupport loadAllegroFont(const(char)* libName) {
		lib = load(libName);
		if (lib == invalidHandle) {
			return AllegroSupport.noLibrary;
		}

		auto lastErrorCount = errorCount();
		loadedVersion = AllegroSupport.badLibrary;

		lib.bindSymbol(cast(void**)&al_init_font_addon, "al_init_font_addon");
		lib.bindSymbol(cast(void**)&al_shutdown_font_addon, "al_shutdown_font_addon");
		lib.bindSymbol(cast(void**)&al_get_allegro_font_version, "al_get_allegro_font_version");

		lib.bindSymbol(cast(void**)&al_load_bitmap_font, "al_load_bitmap_font");
		lib.bindSymbol(cast(void**)&al_load_bitmap_font_flags, "al_load_bitmap_font_flags");
		lib.bindSymbol(cast(void**)&al_load_font, "al_load_font");
		lib.bindSymbol(cast(void**)&al_grab_font_from_bitmap, "al_grab_font_from_bitmap");
		lib.bindSymbol(cast(void**)&al_create_builtin_font, "al_create_builtin_font");
		lib.bindSymbol(cast(void**)&al_register_font_loader, "al_register_font_loader");
		lib.bindSymbol(cast(void**)&al_destroy_font, "al_destroy_font");

		lib.bindSymbol(cast(void**)&al_set_fallback_font, "al_set_fallback_font");
		lib.bindSymbol(cast(void**)&al_get_fallback_font, "al_get_fallback_font");

		lib.bindSymbol(cast(void**)&al_draw_ustr, "al_draw_ustr");
		lib.bindSymbol(cast(void**)&al_draw_text, "al_draw_text");
		lib.bindSymbol(cast(void**)&al_draw_justified_text, "al_draw_justified_text");
		lib.bindSymbol(cast(void**)&al_draw_justified_ustr, "al_draw_justified_ustr");
		lib.bindSymbol(cast(void**)&al_draw_textf, "al_draw_textf");
		lib.bindSymbol(cast(void**)&al_draw_justified_textf, "al_draw_justified_textf");
		
		lib.bindSymbol(cast(void**)&al_get_font_line_height, "al_get_font_line_height");
		lib.bindSymbol(cast(void**)&al_get_font_ascent, "al_get_font_ascent");
		lib.bindSymbol(cast(void**)&al_get_font_descent, "al_get_font_descent");
		lib.bindSymbol(cast(void**)&al_get_font_ranges, "al_get_font_ranges");

		lib.bindSymbol(cast(void**)&al_get_text_width, "al_get_text_width");
		lib.bindSymbol(cast(void**)&al_get_ustr_width, "al_get_ustr_width");
		lib.bindSymbol(cast(void**)&al_get_ustr_dimensions, "al_get_ustr_dimensions");
		lib.bindSymbol(cast(void**)&al_get_text_dimensions, "al_get_text_dimensions");
		
		lib.bindSymbol(cast(void**)&al_get_glyph_width, "al_get_glyph_width");
		lib.bindSymbol(cast(void**)&al_get_glyph_dimensions, "al_get_glyph_dimensions");
		lib.bindSymbol(cast(void**)&al_get_glyph_advance, "al_get_glyph_advance");
		
		lib.bindSymbol(cast(void**)&al_draw_glyph, "al_draw_glyph");
		lib.bindSymbol(cast(void**)&al_draw_multiline_text, "al_draw_multiline_text");
		lib.bindSymbol(cast(void**)&al_draw_multiline_textf, "al_draw_multiline_textf");
		lib.bindSymbol(cast(void**)&al_draw_multiline_ustr, "al_draw_multiline_ustr");

		lib.bindSymbol(cast(void**)&al_do_multiline_text, "al_do_multiline_text");
		lib.bindSymbol(cast(void**)&al_do_multiline_ustr, "al_do_multiline_ustr");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}
		loadedVersion = AllegroSupport.v5_2_0;

		static if (allegroSupport >= AllegroSupport.v5_2_1) {
			version (ALLEGRO_UNSTABLE) {
				lib.bindSymbol(cast(void**)&al_get_glyph, "al_get_glyph");
			}
			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
			loadedVersion = AllegroSupport.v5_2_1;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&al_is_font_addon_initialized, "al_is_font_addon_initialized");
			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
			loadedVersion = AllegroSupport.v5_2_6;
		}

		return loadedVersion;
	}
}
