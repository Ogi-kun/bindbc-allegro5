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
	pragma(inline, true) extern(C) @nogc nothrow {
		extern(C) @nogc nothrow:
		uint al_get_allegro_color_version() => ptr_al_get_allegro_color_version();

		void al_color_hsv_to_rgb(float hue, float saturation, float value, float* red, float* green, float* blue) => ptr_al_color_hsv_to_rgb(hue, saturation, value, red, green, blue);
		void al_color_rgb_to_hsl(float red, float green, float blue, float* hue, float* saturation, float* lightness) => ptr_al_color_rgb_to_hsl(red, green, blue, hue, saturation, lightness);
		void al_color_rgb_to_hsv(float red, float green, float blue, float* hue, float* saturation, float* value) => ptr_al_color_rgb_to_hsv(red, green, blue, hue, saturation, value);
		void al_color_hsl_to_rgb(float hue, float saturation, float lightness, float* red, float* green, float* blue) => ptr_al_color_hsl_to_rgb(hue, saturation, lightness, red, green, blue);

		bool al_color_name_to_rgb(const(char)* name, float* r, float* g, float* b) => ptr_al_color_name_to_rgb(name, r, g, b);
		const(char)* al_color_rgb_to_name(float r, float g, float b) => ptr_al_color_rgb_to_name(r, g, b);

		void al_color_cmyk_to_rgb(float cyan, float magenta, float yellow, float key, float* red, float* green, float* blue) => ptr_al_color_cmyk_to_rgb(cyan, magenta, yellow, key, red, green, blue);
		void al_color_rgb_to_cmyk(float red, float green, float blue, float* cyan, float* magenta, float* yellow, float* key) => ptr_al_color_rgb_to_cmyk(red, green, blue, cyan, magenta, yellow, key);
		void al_color_yuv_to_rgb(float y, float u, float v, float* red, float* green, float* blue) => ptr_al_color_yuv_to_rgb(y, u, v, red, green, blue);
		void al_color_rgb_to_yuv(float red, float green, float blue, float* y, float* u, float* v) => ptr_al_color_rgb_to_yuv(red, green, blue, y, u, v);
		void al_color_rgb_to_html(float red, float green, float blue, char* string) => ptr_al_color_rgb_to_html(red, green, blue, string);
		bool al_color_html_to_rgb(const(char)* string, float* red, float* green, float* blue) => ptr_al_color_html_to_rgb(string, red, green, blue);

		ALLEGRO_COLOR al_color_yuv(float y, float u, float v) => ptr_al_color_yuv(y, u, v);
		ALLEGRO_COLOR al_color_cmyk(float c, float m, float y, float k) => ptr_al_color_cmyk(c, m, y, k);
		ALLEGRO_COLOR al_color_hsl(float h, float s, float l) => ptr_al_color_hsl(h, s, l);
		ALLEGRO_COLOR al_color_hsv(float h, float s, float v) => ptr_al_color_hsv(h, s, v);
		ALLEGRO_COLOR al_color_name(const(char)* name) => ptr_al_color_name(name);
		ALLEGRO_COLOR al_color_html(const(char)* string) => ptr_al_color_html(string);

		static if (allegroSupport >= AllegroSupport.v5_2_3) {
			void al_color_xyz_to_rgb(float x, float y, float z, float* red, float* green, float* blue) => ptr_al_color_xyz_to_rgb(x, y, z, red, green, blue);
			void al_color_rgb_to_xyz(float red, float green, float blue, float* x, float* y, float* z) => ptr_al_color_rgb_to_xyz(red, green, blue, x, y, z);
			ALLEGRO_COLOR al_color_xyz(float x, float y, float z) => ptr_al_color_xyz(x, y, z);

			void al_color_xyy_to_rgb(float x, float y, float y2, float* red, float* green, float* blue) => ptr_al_color_xyy_to_rgb(x, y, y2, red, green, blue);
			void al_color_rgb_to_xyy(float red, float green, float blue, float* x, float* y, float* y2) => ptr_al_color_rgb_to_xyy(red, green, blue, x, y, y2);
			ALLEGRO_COLOR al_color_xyy(float x, float y, float y2) => ptr_al_color_xyy(x, y, y2);

			void al_color_lab_to_rgb(float l, float a, float b, float* red, float* green, float* blue) => ptr_al_color_lab_to_rgb(l, a, b, red, green, blue);
			void al_color_rgb_to_lab(float red, float green, float blue, float* l, float* a, float* b) => ptr_al_color_rgb_to_lab(red, green, blue, l, a, b);
			ALLEGRO_COLOR al_color_lab(float l, float a, float b) => ptr_al_color_lab(l, a, b);

			void al_color_lch_to_rgb(float l, float c, float h, float* red, float* green, float* blue) => ptr_al_color_lch_to_rgb(l, c, h, red, green, blue);
			void al_color_rgb_to_lch(float red, float green, float blue, float* l, float* c, float* h) => ptr_al_color_rgb_to_lch(red, green, blue, l, c, h);
			ALLEGRO_COLOR al_color_lch(float l, float c, float h) => ptr_al_color_lch(l, c, h);

			double al_color_distance_ciede2000(ALLEGRO_COLOR c1, ALLEGRO_COLOR c2) => ptr_al_color_distance_ciede2000(c1, c2);

			bool al_is_color_valid(ALLEGRO_COLOR color) => ptr_al_is_color_valid(color);
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			void al_color_oklab_to_rgb(float l, float a, float b, float* red, float* green, float* blue) => ptr_al_color_oklab_to_rgb(l, a, b, red, green, blue);
			void al_color_rgb_to_oklab(float red, float green, float blue, float* l, float* a, float* b) => ptr_al_color_rgb_to_oklab(red, green, blue, l, a, b);
			ALLEGRO_COLOR al_color_oklab(float l, float a, float b) => ptr_al_color_oklab(l, a, b);

			void al_color_linear_to_rgb(float x, float y, float z, float* red, float* green, float* blue) => ptr_al_color_linear_to_rgb(x, y, z, red, green, blue);
			void al_color_rgb_to_linear(float red, float green, float blue, float* x, float* y, float* z) => ptr_al_color_rgb_to_linear(red, green, blue, x, y, z);
			ALLEGRO_COLOR al_color_linear(float r, float g, float b) => ptr_al_color_linear(r, g, b);
		}
	}

	private __gshared {
		typeof(&al_get_allegro_color_version) ptr_al_get_allegro_color_version;

		typeof(&al_color_hsv_to_rgb) ptr_al_color_hsv_to_rgb;
		typeof(&al_color_rgb_to_hsl) ptr_al_color_rgb_to_hsl;
		typeof(&al_color_rgb_to_hsv) ptr_al_color_rgb_to_hsv;
		typeof(&al_color_hsl_to_rgb) ptr_al_color_hsl_to_rgb;

		typeof(&al_color_name_to_rgb) ptr_al_color_name_to_rgb;
		typeof(&al_color_rgb_to_name) ptr_al_color_rgb_to_name;

		typeof(&al_color_cmyk_to_rgb) ptr_al_color_cmyk_to_rgb;
		typeof(&al_color_rgb_to_cmyk) ptr_al_color_rgb_to_cmyk;
		typeof(&al_color_yuv_to_rgb) ptr_al_color_yuv_to_rgb;
		typeof(&al_color_rgb_to_yuv) ptr_al_color_rgb_to_yuv;
		typeof(&al_color_rgb_to_html) ptr_al_color_rgb_to_html;
		typeof(&al_color_html_to_rgb) ptr_al_color_html_to_rgb;

		typeof(&al_color_yuv) ptr_al_color_yuv;
		typeof(&al_color_cmyk) ptr_al_color_cmyk;
		typeof(&al_color_hsl) ptr_al_color_hsl;
		typeof(&al_color_hsv) ptr_al_color_hsv;
		typeof(&al_color_name) ptr_al_color_name;
		typeof(&al_color_html) ptr_al_color_html;

		static if (allegroSupport >= AllegroSupport.v5_2_3) {
			typeof(&al_color_xyz_to_rgb) ptr_al_color_xyz_to_rgb;
			typeof(&al_color_rgb_to_xyz) ptr_al_color_rgb_to_xyz;
			typeof(&al_color_xyz) ptr_al_color_xyz;

			typeof(&al_color_xyy_to_rgb) ptr_al_color_xyy_to_rgb;
			typeof(&al_color_rgb_to_xyy) ptr_al_color_rgb_to_xyy;
			typeof(&al_color_xyy) ptr_al_color_xyy;

			typeof(&al_color_lab_to_rgb) ptr_al_color_lab_to_rgb;
			typeof(&al_color_rgb_to_lab) ptr_al_color_rgb_to_lab;
			typeof(&al_color_lab) ptr_al_color_lab;

			typeof(&al_color_lch_to_rgb) ptr_al_color_lch_to_rgb;
			typeof(&al_color_rgb_to_lch) ptr_al_color_rgb_to_lch;
			typeof(&al_color_lch) ptr_al_color_lch;

			typeof(&al_color_distance_ciede2000) ptr_al_color_distance_ciede2000;

			typeof(&al_is_color_valid) ptr_al_is_color_valid;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			typeof(&al_color_oklab_to_rgb) ptr_al_color_oklab_to_rgb;
			typeof(&al_color_rgb_to_oklab) ptr_al_color_rgb_to_oklab;
			typeof(&al_color_oklab) ptr_al_color_oklab;

			typeof(&al_color_linear_to_rgb) ptr_al_color_linear_to_rgb;
			typeof(&al_color_rgb_to_linear) ptr_al_color_rgb_to_linear;
			typeof(&al_color_linear) ptr_al_color_linear;
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

		lib.bindSymbol(cast(void**)&ptr_al_get_allegro_color_version, "al_get_allegro_color_version");

		lib.bindSymbol(cast(void**)&ptr_al_color_hsv_to_rgb, "al_color_hsv_to_rgb");
		lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_hsl, "al_color_rgb_to_hsl");
		lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_hsv, "al_color_rgb_to_hsv");
		lib.bindSymbol(cast(void**)&ptr_al_color_hsl_to_rgb, "al_color_hsl_to_rgb");

		lib.bindSymbol(cast(void**)&ptr_al_color_name_to_rgb, "al_color_name_to_rgb");
		lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_name, "al_color_rgb_to_name");

		lib.bindSymbol(cast(void**)&ptr_al_color_cmyk_to_rgb, "al_color_cmyk_to_rgb");
		lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_cmyk, "al_color_rgb_to_cmyk");
		lib.bindSymbol(cast(void**)&ptr_al_color_yuv_to_rgb, "al_color_yuv_to_rgb");
		lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_yuv, "al_color_rgb_to_yuv");
		lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_html, "al_color_rgb_to_html");
		lib.bindSymbol(cast(void**)&ptr_al_color_html_to_rgb, "al_color_html_to_rgb");

		lib.bindSymbol(cast(void**)&ptr_al_color_yuv, "al_color_yuv");
		lib.bindSymbol(cast(void**)&ptr_al_color_cmyk, "al_color_cmyk");
		lib.bindSymbol(cast(void**)&ptr_al_color_hsl, "al_color_hsl");
		lib.bindSymbol(cast(void**)&ptr_al_color_hsv, "al_color_hsv");
		lib.bindSymbol(cast(void**)&ptr_al_color_name, "al_color_name");
		lib.bindSymbol(cast(void**)&ptr_al_color_html, "al_color_html");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_3) {
			lib.bindSymbol(cast(void**)&ptr_al_color_xyz_to_rgb, "al_color_xyz_to_rgb");
			lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_xyz, "al_color_rgb_to_xyz");
			lib.bindSymbol(cast(void**)&ptr_al_color_xyz, "al_color_xyz");

			lib.bindSymbol(cast(void**)&ptr_al_color_xyy_to_rgb, "al_color_xyy_to_rgb");
			lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_xyy, "al_color_rgb_to_xyy");
			lib.bindSymbol(cast(void**)&ptr_al_color_xyy, "al_color_xyy");

			lib.bindSymbol(cast(void**)&ptr_al_color_lab_to_rgb, "al_color_lab_to_rgb");
			lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_lab, "al_color_rgb_to_lab");
			lib.bindSymbol(cast(void**)&ptr_al_color_lab, "al_color_lab");

			lib.bindSymbol(cast(void**)&ptr_al_color_lch_to_rgb, "al_color_lch_to_rgb");
			lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_lch, "al_color_rgb_to_lch");
			lib.bindSymbol(cast(void**)&ptr_al_color_lch, "al_color_lch");

			lib.bindSymbol(cast(void**)&ptr_al_color_distance_ciede2000, "al_color_distance_ciede2000");

			lib.bindSymbol(cast(void**)&ptr_al_is_color_valid, "al_is_color_valid");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_2;
			}
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			lib.bindSymbol(cast(void**)&ptr_al_color_oklab_to_rgb, "al_color_oklab_to_rgb");
			lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_oklab, "al_color_rgb_to_oklab");
			lib.bindSymbol(cast(void**)&ptr_al_color_oklab, "al_color_oklab");

			lib.bindSymbol(cast(void**)&ptr_al_color_linear_to_rgb, "al_color_linear_to_rgb");
			lib.bindSymbol(cast(void**)&ptr_al_color_rgb_to_linear, "al_color_rgb_to_linear");
			lib.bindSymbol(cast(void**)&ptr_al_color_linear, "al_color_linear");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_7;
			}
		}

		return allegroSupport;
	}
}
