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

extern(C) @nogc nothrow {
	alias al_font_loader = ALLEGRO_FONT* function(const(char)* filename, int size, int flags);
	alias al_multiline_text_callback = bool function(int line_num, const(char)* line, int size, void* extra);
	alias al_multiline_ustr_callback = bool function(int line_num, const(ALLEGRO_USTR)* line, void* extra);
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
	bool al_register_font_loader(const(char)* ext, al_font_loader load);
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

	void al_do_multiline_text(const(ALLEGRO_FONT)* font, float max_width, const(char)* text, al_multiline_text_callback cb, void* extra);
	void al_do_multiline_ustr(const(ALLEGRO_FONT)* font, float max_width, const(ALLEGRO_USTR)* ustr, al_multiline_ustr_callback cb, void* extra);

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
	pragma(inline, true) extern(C) @nogc nothrow {
		bool al_init_font_addon() => ptr_al_init_font_addon();
		void al_shutdown_font_addon() => ptr_al_shutdown_font_addon();
		uint al_get_allegro_font_version() => ptr_al_get_allegro_font_version();

		ALLEGRO_FONT* al_load_bitmap_font(const(char)* filename) => ptr_al_load_bitmap_font(filename);
		ALLEGRO_FONT* al_load_bitmap_font_flags(const(char)* filename, int flags) => ptr_al_load_bitmap_font_flags(filename, flags);
		ALLEGRO_FONT* al_load_font(const(char)* filename, int size, int flags) => ptr_al_load_font(filename, size, flags);
		ALLEGRO_FONT* al_grab_font_from_bitmap(ALLEGRO_BITMAP* bmp, int n, const(int)* ranges) => ptr_al_grab_font_from_bitmap(bmp, n, ranges);
		ALLEGRO_FONT* al_create_builtin_font() => ptr_al_create_builtin_font();
		bool al_register_font_loader(const(char)* ext, al_font_loader load) => ptr_al_register_font_loader(ext, load);
		void al_destroy_font(ALLEGRO_FONT* f) => ptr_al_destroy_font(f);

		void al_set_fallback_font(ALLEGRO_FONT* font, ALLEGRO_FONT* fallback) => ptr_al_set_fallback_font(font, fallback);
		ALLEGRO_FONT* al_get_fallback_font(ALLEGRO_FONT* font) => ptr_al_get_fallback_font(font);

		void al_draw_ustr(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(ALLEGRO_USTR)* ustr) => ptr_al_draw_ustr(font, color, x, y, flags, ustr);
		void al_draw_text(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(char)* text) => ptr_al_draw_text(font, color, x, y, flags, text);
		void al_draw_justified_text(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(char)* text) => ptr_al_draw_justified_text(font, color, x1, x2, y, diff, flags, text);
		void al_draw_justified_ustr(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(ALLEGRO_USTR)* text) => ptr_al_draw_justified_ustr(font, color, x1, x2, y, diff, flags, text);
		void al_draw_textf(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(char)* format, ...) => ptr_al_draw_textf(__traits(parameters));
		void al_draw_justified_textf(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(char)* format, ...) => ptr_al_draw_justified_textf(__traits(parameters));

		int al_get_font_line_height(const(ALLEGRO_FONT)* f) => ptr_al_get_font_line_height(f);
		int al_get_font_ascent(const(ALLEGRO_FONT)* f) => ptr_al_get_font_ascent(f);
		int al_get_font_descent(const(ALLEGRO_FONT)* f) => ptr_al_get_font_descent(f);
		int al_get_font_ranges(ALLEGRO_FONT* font, int ranges_count, int* ranges) => ptr_al_get_font_ranges(font, ranges_count, ranges);

		int al_get_text_width(const(ALLEGRO_FONT)* f, const(char)* str) => ptr_al_get_text_width(f, str);
		int al_get_ustr_width(const(ALLEGRO_FONT)* f, const(ALLEGRO_USTR)* ustr) => ptr_al_get_ustr_width(f,  ustr);
		void al_get_ustr_dimensions(const(ALLEGRO_FONT)* f, const(ALLEGRO_USTR)* text, int* bbx, int* bby, int* bbw, int* bbh) => ptr_al_get_ustr_dimensions(f, text, bbx, bby, bbw, bbh);
		void al_get_text_dimensions(const(ALLEGRO_FONT)* f, const(char)* text, int* bbx, int* bby, int* bbw, int* bbh) => ptr_al_get_text_dimensions(f, text, bbx, bby, bbw, bbh);

		int al_get_glyph_width(const(ALLEGRO_FONT)* f, int codepoint) => ptr_al_get_glyph_width(f, codepoint);
		bool al_get_glyph_dimensions(const(ALLEGRO_FONT)* f, int codepoint, int* bbx, int* bby, int* bbw, int* bbh) => ptr_al_get_glyph_dimensions(f, codepoint, bbx, bby, bbw, bbh);
		int al_get_glyph_advance(const(ALLEGRO_FONT)* f, int codepoint1, int codepoint2) => ptr_al_get_glyph_advance(f, codepoint1, codepoint2);

		void al_draw_glyph(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int codepoint) => ptr_al_draw_glyph(font, color, x, y, codepoint);
		void al_draw_multiline_text(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, float max_width, float line_height, int flags, const(char)* text) => ptr_al_draw_multiline_text(font, color, x, y, max_width, line_height, flags, text);
		void al_draw_multiline_textf(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, float max_width, float line_height, int flags, const(char)* format, ...) => ptr_al_draw_multiline_textf(__traits(parameters));
		void al_draw_multiline_ustr(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, float max_width, float line_height, int flags, const(ALLEGRO_USTR)* text) => ptr_al_draw_multiline_ustr(font, color, x, y, max_width, line_height, flags, text);

		void al_do_multiline_text(const(ALLEGRO_FONT)* font, float max_width, const(char)* text, al_multiline_text_callback cb, void* extra) => ptr_al_do_multiline_text(font, max_width, text, cb, extra);
		void al_do_multiline_ustr(const(ALLEGRO_FONT)* font, float max_width, const(ALLEGRO_USTR)* ustr, al_multiline_ustr_callback cb, void* extra) => ptr_al_do_multiline_ustr(font, max_width, ustr, cb, extra);

		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_1) {
			bool al_get_glyph(const(ALLEGRO_FONT)* f, int prev_codepoint, int codepoint, ALLEGRO_GLYPH* glyph) => ptr_al_get_glyph(f, prev_codepoint, codepoint, glyph);
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			bool al_is_font_addon_initialized() => ptr_al_is_font_addon_initialized();
		}
	}

	private __gshared {
		typeof(&al_init_font_addon) ptr_al_init_font_addon;
		typeof(&al_shutdown_font_addon) ptr_al_shutdown_font_addon;
		typeof(&al_get_allegro_font_version) ptr_al_get_allegro_font_version;

		typeof(&al_load_bitmap_font) ptr_al_load_bitmap_font;
		typeof(&al_load_bitmap_font_flags) ptr_al_load_bitmap_font_flags;
		typeof(&al_load_font) ptr_al_load_font;
		typeof(&al_grab_font_from_bitmap) ptr_al_grab_font_from_bitmap;
		typeof(&al_create_builtin_font) ptr_al_create_builtin_font;
		typeof(&al_register_font_loader) ptr_al_register_font_loader;
		typeof(&al_destroy_font) ptr_al_destroy_font;

		typeof(&al_set_fallback_font) ptr_al_set_fallback_font;
		typeof(&al_get_fallback_font) ptr_al_get_fallback_font;

		typeof(&al_draw_ustr) ptr_al_draw_ustr;
		typeof(&al_draw_text) ptr_al_draw_text;
		typeof(&al_draw_justified_text) ptr_al_draw_justified_text;
		typeof(&al_draw_justified_ustr) ptr_al_draw_justified_ustr;
		typeof(&al_draw_textf) ptr_al_draw_textf;
		typeof(&al_draw_justified_textf) ptr_al_draw_justified_textf;

		typeof(&al_get_font_line_height) ptr_al_get_font_line_height;
		typeof(&al_get_font_ascent) ptr_al_get_font_ascent;
		typeof(&al_get_font_descent) ptr_al_get_font_descent;
		typeof(&al_get_font_ranges) ptr_al_get_font_ranges;

		typeof(&al_get_text_width) ptr_al_get_text_width;
		typeof(&al_get_ustr_width) ptr_al_get_ustr_width;
		typeof(&al_get_ustr_dimensions) ptr_al_get_ustr_dimensions;
		typeof(&al_get_text_dimensions) ptr_al_get_text_dimensions;

		typeof(&al_get_glyph_width) ptr_al_get_glyph_width;
		typeof(&al_get_glyph_dimensions) ptr_al_get_glyph_dimensions;
		typeof(&al_get_glyph_advance) ptr_al_get_glyph_advance;

		typeof(&al_draw_glyph) ptr_al_draw_glyph;
		typeof(&al_draw_multiline_text) ptr_al_draw_multiline_text;
		typeof(&al_draw_multiline_textf) ptr_al_draw_multiline_textf;
		typeof(&al_draw_multiline_ustr) ptr_al_draw_multiline_ustr;

		typeof(&al_do_multiline_text) ptr_al_do_multiline_text;
		typeof(&al_do_multiline_ustr) ptr_al_do_multiline_ustr;

		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_1) {
			typeof(&al_get_glyph) ptr_al_get_glyph;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			typeof(&al_is_font_addon_initialized) ptr_al_is_font_addon_initialized;
		}
	}

	import bindbc.loader;

	@nogc nothrow:

	version (Allegro_Monolith) {} else {

		private {
			__gshared SharedLib lib;
			__gshared AllegroSupport loadedVersion;
		}

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
			const(char)[][1] libNames = [
				dynlibFilename!"font",
			];

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
			loadedVersion = bindAllegroFont(lib);
			return loadedVersion == allegroSupport ? allegroSupport : AllegroSupport.badLibrary;
		}
	}

	package AllegroSupport bindAllegroFont(SharedLib lib) {

		auto lastErrorCount = errorCount();

		lib.bindSymbol(cast(void**)&ptr_al_init_font_addon, "al_init_font_addon");
		lib.bindSymbol(cast(void**)&ptr_al_shutdown_font_addon, "al_shutdown_font_addon");
		lib.bindSymbol(cast(void**)&ptr_al_get_allegro_font_version, "al_get_allegro_font_version");

		lib.bindSymbol(cast(void**)&ptr_al_load_bitmap_font, "al_load_bitmap_font");
		lib.bindSymbol(cast(void**)&ptr_al_load_bitmap_font_flags, "al_load_bitmap_font_flags");
		lib.bindSymbol(cast(void**)&ptr_al_load_font, "al_load_font");
		lib.bindSymbol(cast(void**)&ptr_al_grab_font_from_bitmap, "al_grab_font_from_bitmap");
		lib.bindSymbol(cast(void**)&ptr_al_create_builtin_font, "al_create_builtin_font");
		lib.bindSymbol(cast(void**)&ptr_al_register_font_loader, "al_register_font_loader");
		lib.bindSymbol(cast(void**)&ptr_al_destroy_font, "al_destroy_font");

		lib.bindSymbol(cast(void**)&ptr_al_set_fallback_font, "al_set_fallback_font");
		lib.bindSymbol(cast(void**)&ptr_al_get_fallback_font, "al_get_fallback_font");

		lib.bindSymbol(cast(void**)&ptr_al_draw_ustr, "al_draw_ustr");
		lib.bindSymbol(cast(void**)&ptr_al_draw_text, "al_draw_text");
		lib.bindSymbol(cast(void**)&ptr_al_draw_justified_text, "al_draw_justified_text");
		lib.bindSymbol(cast(void**)&ptr_al_draw_justified_ustr, "al_draw_justified_ustr");
		lib.bindSymbol(cast(void**)&ptr_al_draw_textf, "al_draw_textf");
		lib.bindSymbol(cast(void**)&ptr_al_draw_justified_textf, "al_draw_justified_textf");

		lib.bindSymbol(cast(void**)&ptr_al_get_font_line_height, "al_get_font_line_height");
		lib.bindSymbol(cast(void**)&ptr_al_get_font_ascent, "al_get_font_ascent");
		lib.bindSymbol(cast(void**)&ptr_al_get_font_descent, "al_get_font_descent");
		lib.bindSymbol(cast(void**)&ptr_al_get_font_ranges, "al_get_font_ranges");

		lib.bindSymbol(cast(void**)&ptr_al_get_text_width, "al_get_text_width");
		lib.bindSymbol(cast(void**)&ptr_al_get_ustr_width, "al_get_ustr_width");
		lib.bindSymbol(cast(void**)&ptr_al_get_ustr_dimensions, "al_get_ustr_dimensions");
		lib.bindSymbol(cast(void**)&ptr_al_get_text_dimensions, "al_get_text_dimensions");

		lib.bindSymbol(cast(void**)&ptr_al_get_glyph_width, "al_get_glyph_width");
		lib.bindSymbol(cast(void**)&ptr_al_get_glyph_dimensions, "al_get_glyph_dimensions");
		lib.bindSymbol(cast(void**)&ptr_al_get_glyph_advance, "al_get_glyph_advance");

		lib.bindSymbol(cast(void**)&ptr_al_draw_glyph, "al_draw_glyph");
		lib.bindSymbol(cast(void**)&ptr_al_draw_multiline_text, "al_draw_multiline_text");
		lib.bindSymbol(cast(void**)&ptr_al_draw_multiline_textf, "al_draw_multiline_textf");
		lib.bindSymbol(cast(void**)&ptr_al_draw_multiline_ustr, "al_draw_multiline_ustr");

		lib.bindSymbol(cast(void**)&ptr_al_do_multiline_text, "al_do_multiline_text");
		lib.bindSymbol(cast(void**)&ptr_al_do_multiline_ustr, "al_do_multiline_ustr");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_1) {
			version (ALLEGRO_UNSTABLE) {
				lib.bindSymbol(cast(void**)&ptr_al_get_glyph, "al_get_glyph");
			}
			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_0;
			}
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&ptr_al_is_font_addon_initialized, "al_is_font_addon_initialized");
			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_5;
			}
		}

		return allegroSupport;
	}
}
