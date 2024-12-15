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
	extern(C) @nogc nothrow {
		alias pal_map_rgb = ALLEGRO_COLOR function(ubyte r, ubyte g, ubyte b);
		alias pal_map_rgba = ALLEGRO_COLOR function(ubyte r, ubyte g, ubyte b, ubyte a);
		alias pal_map_rgb_f = ALLEGRO_COLOR function(float r, float g, float b);
		alias pal_map_rgba_f = ALLEGRO_COLOR function(float r, float g, float b, float a);
		alias pal_premul_rgba = ALLEGRO_COLOR function(ubyte r, ubyte g, ubyte b, ubyte a);
		alias pal_premul_rgba_f = ALLEGRO_COLOR function(float r, float g, float b, float a);

		alias pal_unmap_rgb = void function(ALLEGRO_COLOR color, ubyte* r, ubyte* g, ubyte* b);
		alias pal_unmap_rgba = void function(ALLEGRO_COLOR color, ubyte* r, ubyte* g, ubyte* b, ubyte* a);
		alias pal_unmap_rgb_f = void function(ALLEGRO_COLOR color, float* r, float* g, float* b);
		alias pal_unmap_rgba_f = void function(ALLEGRO_COLOR color, float* r, float* g, float* b, float* a);

		alias pal_get_pixel_size = int function(int format);
		alias pal_get_pixel_format_bits = int function(int format);
		alias pal_get_pixel_block_size = int function(int format);
		alias pal_get_pixel_block_width = int function(int format);
		alias pal_get_pixel_block_height = int function(int format);
	}
	__gshared {
		pal_map_rgb al_map_rgb;
		pal_map_rgba al_map_rgba;
		pal_map_rgb_f al_map_rgb_f;
		pal_map_rgba_f al_map_rgba_f;
		pal_premul_rgba al_premul_rgba;
		pal_premul_rgba_f al_premul_rgba_f;

		pal_unmap_rgb al_unmap_rgb;
		pal_unmap_rgba al_unmap_rgba;
		pal_unmap_rgb_f al_unmap_rgb_f;
		pal_unmap_rgba_f al_unmap_rgba_f;

		pal_get_pixel_size al_get_pixel_size;
		pal_get_pixel_format_bits al_get_pixel_format_bits;
		pal_get_pixel_block_size al_get_pixel_block_size;
		pal_get_pixel_block_width al_get_pixel_block_width;
		pal_get_pixel_block_height al_get_pixel_block_height;
	}
}
