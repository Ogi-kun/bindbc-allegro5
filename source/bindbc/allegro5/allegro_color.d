module bindbc.allegro5.allegro_color;

import bindbc.allegro5.config;

static if (allegroColor):

import bindbc.allegro5.bind.color : ALLEGRO_COLOR;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	uint al_get_allegro_color_version();

	void al_color_hsv_to_rgb(float hue, float saturation, float value, float* red, float* green, float* blue);
	void al_color_rgb_to_hsl(float red, float green, float blue, float* hue, float* saturation, float* lightness);
	void al_color_rgb_to_hsv(float red, float green, float blue, float* hue, float* saturation, float* value);
	void al_color_hsl_to_rgb(float hue, float saturation, float lightness, float* red, float* green, float* blue);

	bool al_color_name_to_rgb(const(char)* name, float* r, float* g, float* b);
	const(char)* al_color_rgb_to_name(float r, float g, float b);

	void al_color_cmyk_to_rgb(float cyan, float magenta, float yellow, float key, float* red, float* green, float* blue);
	void al_color_rgb_to_cmyk(float red, float green, float blue, float* cyan, float* magenta, float* yellow, float* key);
	void al_color_yuv_to_rgb(float y, float u, float v, float* red, float* green, float* blue);
	void al_color_rgb_to_yuv(float red, float green, float blue, float* y, float* u, float* v);
	void al_color_rgb_to_html(float red, float green, float blue, char* string);
	bool al_color_html_to_rgb(const(char)* string, float* red, float* green, float* blue);

	ALLEGRO_COLOR al_color_yuv(float y, float u, float v);
	ALLEGRO_COLOR al_color_cmyk(float c, float m, float y, float k);
	ALLEGRO_COLOR al_color_hsl(float h, float s, float l);
	ALLEGRO_COLOR al_color_hsv(float h, float s, float v);
	ALLEGRO_COLOR al_color_name(const(char)* name);
	ALLEGRO_COLOR al_color_html(const(char)* string);

	static if (allegroSupport >= AllegroSupport.v5_2_3) {
		void al_color_xyz_to_rgb(float x, float y, float z, float* red, float* green, float* blue);
		void al_color_rgb_to_xyz(float red, float green, float blue, float* x, float* y, float* z);
		ALLEGRO_COLOR al_color_xyz(float x, float y, float z);

		void al_color_xyy_to_rgb(float x, float y, float y2, float* red, float* green, float* blue);
		void al_color_rgb_to_xyy(float red, float green, float blue, float* x, float* y, float* y2);
		ALLEGRO_COLOR al_color_xyy(float x, float y, float y2);

		void al_color_lab_to_rgb(float l, float a, float b, float* red, float* green, float* blue);
		void al_color_rgb_to_lab(float red, float green, float blue, float* l, float* a, float* b);
		ALLEGRO_COLOR al_color_lab(float l, float a, float b);

		void al_color_lch_to_rgb(float l, float c, float h, float* red, float* green, float* blue);
		void al_color_rgb_to_lch(float red, float green, float blue, float* l, float* c, float* h);
		ALLEGRO_COLOR al_color_lch(float l, float c, float h);

		double al_color_distance_ciede2000(ALLEGRO_COLOR c1, ALLEGRO_COLOR c2);

		bool al_is_color_valid(ALLEGRO_COLOR color);
	}

	static if (allegroSupport >= AllegroSupport.v5_2_8) {
		void al_color_oklab_to_rgb(float l, float a, float b, float* red, float* green, float* blue);
		void al_color_rgb_to_oklab(float red, float green, float blue, float* l, float* a, float* b);
		ALLEGRO_COLOR al_color_oklab(float l, float a, float b);

		void al_color_linear_to_rgb(float x, float y, float z, float* red, float* green, float* blue);
		void al_color_rgb_to_linear(float red, float green, float blue, float* x, float* y, float* z);
		ALLEGRO_COLOR al_color_linear(float r, float g, float b);
	}
}
else {
	extern(C) @nogc nothrow {
		alias pal_get_allegro_color_version = uint function();

		alias pal_color_hsv_to_rgb = void function(float hue, float saturation, float value, float* red, float* green, float* blue);
		alias pal_color_rgb_to_hsl = void function(float red, float green, float blue, float* hue, float* saturation, float* lightness);
		alias pal_color_rgb_to_hsv = void function(float red, float green, float blue, float* hue, float* saturation, float* value);
		alias pal_color_hsl_to_rgb = void function(float hue, float saturation, float lightness, float* red, float* green, float* blue);

		alias pal_color_name_to_rgb = bool function(const(char)* name, float* r, float* g, float* b);
		alias pal_color_rgb_to_name = const(char)* function(float r, float g, float b);

		alias pal_color_cmyk_to_rgb = void function(float cyan, float magenta, float yellow, float key, float* red, float* green, float* blue);
		alias pal_color_rgb_to_cmyk = void function(float red, float green, float blue, float* cyan, float* magenta, float* yellow, float* key);
		alias pal_color_yuv_to_rgb = void function(float y, float u, float v, float* red, float* green, float* blue);
		alias pal_color_rgb_to_yuv = void function(float red, float green, float blue, float* y, float* u, float* v);
		alias pal_color_rgb_to_html = void function(float red, float green, float blue, char* string);
		alias pal_color_html_to_rgb = bool function(const(char)* string, float* red, float* green, float* blue);

		alias pal_color_yuv = ALLEGRO_COLOR function(float y, float u, float v);
		alias pal_color_cmyk = ALLEGRO_COLOR function(float c, float m, float y, float k);
		alias pal_color_hsl = ALLEGRO_COLOR function(float h, float s, float l);
		alias pal_color_hsv = ALLEGRO_COLOR function(float h, float s, float v);
		alias pal_color_name = ALLEGRO_COLOR function(const(char)* name);
		alias pal_color_html = ALLEGRO_COLOR function(const(char)* string);

		static if (allegroSupport >= AllegroSupport.v5_2_3) {
			alias pal_color_xyz_to_rgb = void function(float x, float y, float z, float* red, float* green, float* blue);
			alias pal_color_rgb_to_xyz = void function(float red, float green, float blue, float* x, float* y, float* z);
			alias pal_color_xyz = ALLEGRO_COLOR function(float x, float y, float z);

			alias pal_color_xyy_to_rgb = void function(float x, float y, float y2, float* red, float* green, float* blue);
			alias pal_color_rgb_to_xyy = void function(float red, float green, float blue, float* x, float* y, float* y2);
			alias pal_color_xyy = ALLEGRO_COLOR function(float x, float y, float y2);

			alias pal_color_lab_to_rgb = void function(float l, float a, float b, float* red, float* green, float* blue);
			alias pal_color_rgb_to_lab = void function(float red, float green, float blue, float* l, float* a, float* b);
			alias pal_color_lab = ALLEGRO_COLOR function(float l, float a, float b);

			alias pal_color_lch_to_rgb = void function(float l, float c, float h, float* red, float* green, float* blue);
			alias pal_color_rgb_to_lch = void function(float red, float green, float blue, float* l, float* c, float* h);
			alias pal_color_lch = ALLEGRO_COLOR function(float l, float c, float h);

			alias pal_color_distance_ciede2000 = double function(ALLEGRO_COLOR c1, ALLEGRO_COLOR c2);

			alias pal_is_color_valid = bool function(ALLEGRO_COLOR color);
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			alias pal_color_oklab_to_rgb = void function(float l, float a, float b, float* red, float* green, float* blue);
			alias pal_color_rgb_to_oklab = void function(float red, float green, float blue, float* l, float* a, float* b);
			alias pal_color_oklab = ALLEGRO_COLOR function(float l, float a, float b);

			alias pal_color_linear_to_rgb = void function(float x, float y, float z, float* red, float* green, float* blue);
			alias pal_color_rgb_to_linear = void function(float red, float green, float blue, float* x, float* y, float* z);
			alias pal_color_linear = ALLEGRO_COLOR function(float r, float g, float b);
		}
	}

	__gshared {
		pal_get_allegro_color_version al_get_allegro_color_version;

		pal_color_hsv_to_rgb al_color_hsv_to_rgb;
		pal_color_rgb_to_hsl al_color_rgb_to_hsl;
		pal_color_rgb_to_hsv al_color_rgb_to_hsv;
		pal_color_hsl_to_rgb al_color_hsl_to_rgb;

		pal_color_name_to_rgb al_color_name_to_rgb;
		pal_color_rgb_to_name al_color_rgb_to_name;

		pal_color_cmyk_to_rgb al_color_cmyk_to_rgb;
		pal_color_rgb_to_cmyk al_color_rgb_to_cmyk;
		pal_color_yuv_to_rgb al_color_yuv_to_rgb;
		pal_color_rgb_to_yuv al_color_rgb_to_yuv;
		pal_color_rgb_to_html al_color_rgb_to_html;
		pal_color_html_to_rgb al_color_html_to_rgb;

		pal_color_yuv al_color_yuv;
		pal_color_cmyk al_color_cmyk;
		pal_color_hsl al_color_hsl;
		pal_color_hsv al_color_hsv;
		pal_color_name al_color_name;
		pal_color_html al_color_html;

		static if (allegroSupport >= AllegroSupport.v5_2_3) {
			pal_color_xyz_to_rgb al_color_xyz_to_rgb;
			pal_color_rgb_to_xyz al_color_rgb_to_xyz;
			pal_color_xyz al_color_xyz;

			pal_color_xyy_to_rgb al_color_xyy_to_rgb;
			pal_color_rgb_to_xyy al_color_rgb_to_xyy;
			pal_color_xyy al_color_xyy;

			pal_color_lab_to_rgb al_color_lab_to_rgb;
			pal_color_rgb_to_lab al_color_rgb_to_lab;
			pal_color_lab al_color_lab;

			pal_color_lch_to_rgb al_color_lch_to_rgb;
			pal_color_rgb_to_lch al_color_rgb_to_lch;
			pal_color_lch al_color_lch;

			pal_color_distance_ciede2000 al_color_distance_ciede2000;

			pal_is_color_valid al_is_color_valid;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			pal_color_oklab_to_rgb al_color_oklab_to_rgb;
			pal_color_rgb_to_oklab al_color_rgb_to_oklab;
			pal_color_oklab al_color_oklab;

			pal_color_linear_to_rgb al_color_linear_to_rgb;
			pal_color_rgb_to_linear al_color_rgb_to_linear;
			pal_color_linear al_color_linear;
		}
	}

	import bindbc.loader;

	@nogc nothrow:

	version (Allegro_Monolith) {} else {

		private {
			__gshared SharedLib lib;
			__gshared AllegroSupport loadedVersion;
		}

		void unloadAllegroColor() {
			if (lib != invalidHandle) {
				lib.unload();
			}
		}

		AllegroSupport loadedAllegroColorVersion() {
			return loadedVersion;
		}

		bool isAllegroColorLoaded() {
			return lib != invalidHandle;
		}

		AllegroSupport loadAllegroColor() {
			const(char)[][1] libNames = [
				dynlibFilename!"color",
			];

			typeof(return) result;
			foreach (i; 0..libNames.length) {
				result = loadAllegroColor(libNames[i].ptr);
				if (result != AllegroSupport.noLibrary) {
					break;
				}
			}
			return result;
		}

		AllegroSupport loadAllegroColor(const(char)* libName) {
			lib = load(libName);
			if (lib == invalidHandle) {
				return AllegroSupport.noLibrary;
			}
			loadedVersion = bindAllegroColor(lib);
			return loadedVersion == allegroSupport ? allegroSupport : AllegroSupport.badLibrary;
		}
	}

	package AllegroSupport bindAllegroColor(SharedLib lib) {

		auto lastErrorCount = errorCount();

		lib.bindSymbol(cast(void**)&al_get_allegro_color_version, "al_get_allegro_color_version");

		lib.bindSymbol(cast(void**)&al_color_hsv_to_rgb, "al_color_hsv_to_rgb");
		lib.bindSymbol(cast(void**)&al_color_rgb_to_hsl, "al_color_rgb_to_hsl");
		lib.bindSymbol(cast(void**)&al_color_rgb_to_hsv, "al_color_rgb_to_hsv");
		lib.bindSymbol(cast(void**)&al_color_hsl_to_rgb, "al_color_hsl_to_rgb");

		lib.bindSymbol(cast(void**)&al_color_name_to_rgb, "al_color_name_to_rgb");
		lib.bindSymbol(cast(void**)&al_color_rgb_to_name, "al_color_rgb_to_name");

		lib.bindSymbol(cast(void**)&al_color_cmyk_to_rgb, "al_color_cmyk_to_rgb");
		lib.bindSymbol(cast(void**)&al_color_rgb_to_cmyk, "al_color_rgb_to_cmyk");
		lib.bindSymbol(cast(void**)&al_color_yuv_to_rgb, "al_color_yuv_to_rgb");
		lib.bindSymbol(cast(void**)&al_color_rgb_to_yuv, "al_color_rgb_to_yuv");
		lib.bindSymbol(cast(void**)&al_color_rgb_to_html, "al_color_rgb_to_html");
		lib.bindSymbol(cast(void**)&al_color_html_to_rgb, "al_color_html_to_rgb");

		lib.bindSymbol(cast(void**)&al_color_yuv, "al_color_yuv");
		lib.bindSymbol(cast(void**)&al_color_cmyk, "al_color_cmyk");
		lib.bindSymbol(cast(void**)&al_color_hsl, "al_color_hsl");
		lib.bindSymbol(cast(void**)&al_color_hsv, "al_color_hsv");
		lib.bindSymbol(cast(void**)&al_color_name, "al_color_name");
		lib.bindSymbol(cast(void**)&al_color_html, "al_color_html");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_3) {
			lib.bindSymbol(cast(void**)&al_color_xyz_to_rgb, "al_color_xyz_to_rgb");
			lib.bindSymbol(cast(void**)&al_color_rgb_to_xyz, "al_color_rgb_to_xyz");
			lib.bindSymbol(cast(void**)&al_color_xyz, "al_color_xyz");

			lib.bindSymbol(cast(void**)&al_color_xyy_to_rgb, "al_color_xyy_to_rgb");
			lib.bindSymbol(cast(void**)&al_color_rgb_to_xyy, "al_color_rgb_to_xyy");
			lib.bindSymbol(cast(void**)&al_color_xyy, "al_color_xyy");

			lib.bindSymbol(cast(void**)&al_color_lab_to_rgb, "al_color_lab_to_rgb");
			lib.bindSymbol(cast(void**)&al_color_rgb_to_lab, "al_color_rgb_to_lab");
			lib.bindSymbol(cast(void**)&al_color_lab, "al_color_lab");

			lib.bindSymbol(cast(void**)&al_color_lch_to_rgb, "al_color_lch_to_rgb");
			lib.bindSymbol(cast(void**)&al_color_rgb_to_lch, "al_color_rgb_to_lch");
			lib.bindSymbol(cast(void**)&al_color_lch, "al_color_lch");

			lib.bindSymbol(cast(void**)&al_color_distance_ciede2000, "al_color_distance_ciede2000");

			lib.bindSymbol(cast(void**)&al_is_color_valid, "al_is_color_valid");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_2;
			}
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			lib.bindSymbol(cast(void**)&al_color_oklab_to_rgb, "al_color_oklab_to_rgb");
			lib.bindSymbol(cast(void**)&al_color_rgb_to_oklab, "al_color_rgb_to_oklab");
			lib.bindSymbol(cast(void**)&al_color_oklab, "al_color_oklab");

			lib.bindSymbol(cast(void**)&al_color_linear_to_rgb, "al_color_linear_to_rgb");
			lib.bindSymbol(cast(void**)&al_color_rgb_to_linear, "al_color_rgb_to_linear");
			lib.bindSymbol(cast(void**)&al_color_linear, "al_color_linear");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_7;
			}
		}

		return allegroSupport;
	}
}
