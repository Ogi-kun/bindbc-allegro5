module bindbc.allegro5.bind.color;

import bindbc.allegro5.config;

struct ALLEGRO_COLOR {
	float r, g, b, a;
}

enum ALLEGRO_PIXEL_FORMAT {
	ALLEGRO_PIXEL_FORMAT_ANY                   = 0,
	ALLEGRO_PIXEL_FORMAT_ANY_NO_ALPHA          = 1,
	ALLEGRO_PIXEL_FORMAT_ANY_WITH_ALPHA        = 2,
	ALLEGRO_PIXEL_FORMAT_ANY_15_NO_ALPHA       = 3,
	ALLEGRO_PIXEL_FORMAT_ANY_16_NO_ALPHA       = 4,
	ALLEGRO_PIXEL_FORMAT_ANY_16_WITH_ALPHA     = 5,
	ALLEGRO_PIXEL_FORMAT_ANY_24_NO_ALPHA       = 6,
	ALLEGRO_PIXEL_FORMAT_ANY_32_NO_ALPHA       = 7,
	ALLEGRO_PIXEL_FORMAT_ANY_32_WITH_ALPHA     = 8,
	ALLEGRO_PIXEL_FORMAT_ARGB_8888             = 9,
	ALLEGRO_PIXEL_FORMAT_RGBA_8888             = 10,
	ALLEGRO_PIXEL_FORMAT_ARGB_4444             = 11,
	ALLEGRO_PIXEL_FORMAT_RGB_888               = 12,
	ALLEGRO_PIXEL_FORMAT_RGB_565               = 13,
	ALLEGRO_PIXEL_FORMAT_RGB_555               = 14,
	ALLEGRO_PIXEL_FORMAT_RGBA_5551             = 15,
	ALLEGRO_PIXEL_FORMAT_ARGB_1555             = 16,
	ALLEGRO_PIXEL_FORMAT_ABGR_8888             = 17,
	ALLEGRO_PIXEL_FORMAT_XBGR_8888             = 18,
	ALLEGRO_PIXEL_FORMAT_BGR_888               = 19,
	ALLEGRO_PIXEL_FORMAT_BGR_565               = 20,
	ALLEGRO_PIXEL_FORMAT_BGR_555               = 21,
	ALLEGRO_PIXEL_FORMAT_RGBX_8888             = 22,
	ALLEGRO_PIXEL_FORMAT_XRGB_8888             = 23,
	ALLEGRO_PIXEL_FORMAT_ABGR_F32              = 24,
	ALLEGRO_PIXEL_FORMAT_ABGR_8888_LE          = 25,
	ALLEGRO_PIXEL_FORMAT_RGBA_4444             = 26,
	ALLEGRO_PIXEL_FORMAT_SINGLE_CHANNEL_8      = 27,
	ALLEGRO_PIXEL_FORMAT_COMPRESSED_RGBA_DXT1  = 28,
	ALLEGRO_PIXEL_FORMAT_COMPRESSED_RGBA_DXT3  = 29,
	ALLEGRO_PIXEL_FORMAT_COMPRESSED_RGBA_DXT5  = 30,
	ALLEGRO_NUM_PIXEL_FORMATS
}
mixin ExpandEnum!ALLEGRO_PIXEL_FORMAT;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_COLOR al_map_rgb(ubyte r, ubyte g, ubyte b);
	ALLEGRO_COLOR al_map_rgba(ubyte r, ubyte g, ubyte b, ubyte a);
	ALLEGRO_COLOR al_map_rgb_f(float r, float g, float b);
	ALLEGRO_COLOR al_map_rgba_f(float r, float g, float b, float a);
	ALLEGRO_COLOR al_premul_rgba(ubyte r, ubyte g, ubyte b, ubyte a);
	ALLEGRO_COLOR al_premul_rgba_f(float r, float g, float b, float a);

	void al_unmap_rgb(ALLEGRO_COLOR color, ubyte* r, ubyte* g, ubyte* b);
	void al_unmap_rgba(ALLEGRO_COLOR color, ubyte* r, ubyte* g, ubyte* b, ubyte* a);
	void al_unmap_rgb_f(ALLEGRO_COLOR color, float* r, float* g, float* b);
	void al_unmap_rgba_f(ALLEGRO_COLOR color, float* r, float* g, float* b, float* a);

	int al_get_pixel_size(int format);
	int al_get_pixel_format_bits(int format);
	int al_get_pixel_block_size(int format);
	int al_get_pixel_block_width(int format);
	int al_get_pixel_block_height(int format);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	ALLEGRO_COLOR al_map_rgb(ubyte r, ubyte g, ubyte b) => ptr_al_map_rgb(r, g, b);
	ALLEGRO_COLOR al_map_rgba(ubyte r, ubyte g, ubyte b, ubyte a) => ptr_al_map_rgba(r, g, b, a);
	ALLEGRO_COLOR al_map_rgb_f(float r, float g, float b) => ptr_al_map_rgb_f(r, g, b);
	ALLEGRO_COLOR al_map_rgba_f(float r, float g, float b, float a) => ptr_al_map_rgba_f(r, g, b, a);
	ALLEGRO_COLOR al_premul_rgba(ubyte r, ubyte g, ubyte b, ubyte a) => ptr_al_premul_rgba(r, g, b, a);
	ALLEGRO_COLOR al_premul_rgba_f(float r, float g, float b, float a) => ptr_al_premul_rgba_f(r, g, b, a);

	void al_unmap_rgb(ALLEGRO_COLOR color, ubyte* r, ubyte* g, ubyte* b) => ptr_al_unmap_rgb(color, r, g, b);
	void al_unmap_rgba(ALLEGRO_COLOR color, ubyte* r, ubyte* g, ubyte* b, ubyte* a) => ptr_al_unmap_rgba(color, r, g, b, a);
	void al_unmap_rgb_f(ALLEGRO_COLOR color, float* r, float* g, float* b) => ptr_al_unmap_rgb_f(color, r, g, b);
	void al_unmap_rgba_f(ALLEGRO_COLOR color, float* r, float* g, float* b, float* a) => ptr_al_unmap_rgba_f(color, r, g, b, a);

	int al_get_pixel_size(int format) => ptr_al_get_pixel_size(format);
	int al_get_pixel_format_bits(int format) => ptr_al_get_pixel_format_bits(format);
	int al_get_pixel_block_size(int format) => ptr_al_get_pixel_block_size(format);
	int al_get_pixel_block_width(int format) => ptr_al_get_pixel_block_width(format);
	int al_get_pixel_block_height(int format) => ptr_al_get_pixel_block_height(format);

	package(bindbc.allegro5) __gshared {
		typeof(&al_map_rgb) ptr_al_map_rgb;
		typeof(&al_map_rgba) ptr_al_map_rgba;
		typeof(&al_map_rgb_f) ptr_al_map_rgb_f;
		typeof(&al_map_rgba_f) ptr_al_map_rgba_f;
		typeof(&al_premul_rgba) ptr_al_premul_rgba;
		typeof(&al_premul_rgba_f) ptr_al_premul_rgba_f;

		typeof(&al_unmap_rgb) ptr_al_unmap_rgb;
		typeof(&al_unmap_rgba) ptr_al_unmap_rgba;
		typeof(&al_unmap_rgb_f) ptr_al_unmap_rgb_f;
		typeof(&al_unmap_rgba_f) ptr_al_unmap_rgba_f;

		typeof(&al_get_pixel_size) ptr_al_get_pixel_size;
		typeof(&al_get_pixel_format_bits) ptr_al_get_pixel_format_bits;
		typeof(&al_get_pixel_block_size) ptr_al_get_pixel_block_size;
		typeof(&al_get_pixel_block_width) ptr_al_get_pixel_block_width;
		typeof(&al_get_pixel_block_height) ptr_al_get_pixel_block_height;
	}
}
