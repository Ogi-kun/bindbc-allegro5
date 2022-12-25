module bindbc.allegro5.bind.allegro_direct3d;

import bindbc.allegro5.config;

version (Windows):

import bindbc.allegro5.bind.display : ALLEGRO_DIRECT3D_INTERNAL, ALLEGRO_DISPLAY;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;

enum ALLEGRO_DIRECT3D = ALLEGRO_DIRECT3D_INTERNAL;

alias LPDIRECT3DDEVICE9 = void*;
alias LPDIRECT3DTEXTURE9 = void*;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	LPDIRECT3DDEVICE9 al_get_d3d_device(ALLEGRO_DISPLAY*);
	LPDIRECT3DTEXTURE9 al_get_d3d_system_texture(ALLEGRO_BITMAP*);
	LPDIRECT3DTEXTURE9 al_get_d3d_video_texture(ALLEGRO_BITMAP*);
	bool al_have_d3d_non_pow2_texture_support();
	bool al_have_d3d_non_square_texture_support();
	void al_get_d3d_texture_position(ALLEGRO_BITMAP* bitmap, int* u, int* v);
	bool al_get_d3d_texture_size(ALLEGRO_BITMAP* bitmap, int* width, int* height);
	bool al_is_d3d_device_lost(ALLEGRO_DISPLAY* display);
	void al_set_d3d_device_release_callback(void function(ALLEGRO_DISPLAY* display) callback);
	void al_set_d3d_device_restore_callback(void function(ALLEGRO_DISPLAY* display) callback);
}
else {
	extern(C) @nogc nothrow {
		alias pal_get_d3d_device = LPDIRECT3DDEVICE9 function(ALLEGRO_DISPLAY*);
		alias pal_get_d3d_system_texture = LPDIRECT3DTEXTURE9 function(ALLEGRO_BITMAP*);
		alias pal_get_d3d_video_texture = LPDIRECT3DTEXTURE9 function(ALLEGRO_BITMAP*);
		alias pal_have_d3d_non_pow2_texture_support = bool function();
		alias pal_have_d3d_non_square_texture_support = bool function();
		alias pal_get_d3d_texture_position = void function(ALLEGRO_BITMAP* bitmap, int* u, int* v);
		alias pal_get_d3d_texture_size = bool function(ALLEGRO_BITMAP* bitmap, int* width, int* height);
		alias pal_is_d3d_device_lost = bool function(ALLEGRO_DISPLAY* display);
		alias pal_set_d3d_device_release_callback = void function(void function(ALLEGRO_DISPLAY* display) callback);
		alias pal_set_d3d_device_restore_callback = void function(void function(ALLEGRO_DISPLAY* display) callback);
	}

	__gshared {
		pal_get_d3d_device al_get_d3d_device;
		pal_get_d3d_system_texture al_get_d3d_system_texture;
		pal_get_d3d_video_texture al_get_d3d_video_texture;
		pal_have_d3d_non_pow2_texture_support al_have_d3d_non_pow2_texture_support;
		pal_have_d3d_non_square_texture_support al_have_d3d_non_square_texture_support;
		pal_get_d3d_texture_position al_get_d3d_texture_position;
		pal_get_d3d_texture_size al_get_d3d_texture_size;
		pal_is_d3d_device_lost al_is_d3d_device_lost;
		pal_set_d3d_device_release_callback al_set_d3d_device_release_callback;
		pal_set_d3d_device_restore_callback al_set_d3d_device_restore_callback;
	}
}
