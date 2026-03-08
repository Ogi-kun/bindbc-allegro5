module bindbc.allegro5.bind.allegro_direct3d;

import bindbc.allegro5.config;

version (Windows):

import bindbc.allegro5.bind.display : ALLEGRO_DIRECT3D_INTERNAL, ALLEGRO_DISPLAY;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;

enum ALLEGRO_DIRECT3D = ALLEGRO_DIRECT3D_INTERNAL;

alias LPDIRECT3DDEVICE9 = void*;
alias LPDIRECT3DTEXTURE9 = void*;

extern(C) @nogc nothrow {
	alias al_d3d_device_callback = void function(ALLEGRO_DISPLAY* display);
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	LPDIRECT3DDEVICE9 al_get_d3d_device(ALLEGRO_DISPLAY* display);
	LPDIRECT3DTEXTURE9 al_get_d3d_system_texture(ALLEGRO_BITMAP* bitmap);
	LPDIRECT3DTEXTURE9 al_get_d3d_video_texture(ALLEGRO_BITMAP* bitmap);
	bool al_have_d3d_non_pow2_texture_support();
	bool al_have_d3d_non_square_texture_support();
	void al_get_d3d_texture_position(ALLEGRO_BITMAP* bitmap, int* u, int* v);
	bool al_get_d3d_texture_size(ALLEGRO_BITMAP* bitmap, int* width, int* height);
	bool al_is_d3d_device_lost(ALLEGRO_DISPLAY* display);
	void al_set_d3d_device_release_callback(al_d3d_device_callback callback);
	void al_set_d3d_device_restore_callback(al_d3d_device_callback callback);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	LPDIRECT3DDEVICE9 al_get_d3d_device(ALLEGRO_DISPLAY* display) => ptr_al_get_d3d_device(display);
	LPDIRECT3DTEXTURE9 al_get_d3d_system_texture(ALLEGRO_BITMAP* bitmap) => ptr_al_get_d3d_system_texture(bitmap);
	LPDIRECT3DTEXTURE9 al_get_d3d_video_texture(ALLEGRO_BITMAP* bitmap) => ptr_al_get_d3d_video_texture(bitmap);
	bool al_have_d3d_non_pow2_texture_support() => ptr_al_have_d3d_non_pow2_texture_support();
	bool al_have_d3d_non_square_texture_support() => ptr_al_have_d3d_non_square_texture_support();
	void al_get_d3d_texture_position(ALLEGRO_BITMAP* bitmap, int* u, int* v) => ptr_al_get_d3d_texture_position(bitmap, u, v);
	bool al_get_d3d_texture_size(ALLEGRO_BITMAP* bitmap, int* width, int* height) => ptr_al_get_d3d_texture_size(bitmap, width, height);
	bool al_is_d3d_device_lost(ALLEGRO_DISPLAY* display) => ptr_al_is_d3d_device_lost(display);
	void al_set_d3d_device_release_callback(al_d3d_device_callback callback) => ptr_al_set_d3d_device_release_callback(callback);
	void al_set_d3d_device_restore_callback(al_d3d_device_callback callback) => ptr_al_set_d3d_device_restore_callback(callback);
	package(bindbc.allegro5) __gshared {
		typeof(&al_get_d3d_device) ptr_al_get_d3d_device;
		typeof(&al_get_d3d_system_texture) ptr_al_get_d3d_system_texture;
		typeof(&al_get_d3d_video_texture) ptr_al_get_d3d_video_texture;
		typeof(&al_have_d3d_non_pow2_texture_support) ptr_al_have_d3d_non_pow2_texture_support;
		typeof(&al_have_d3d_non_square_texture_support) ptr_al_have_d3d_non_square_texture_support;
		typeof(&al_get_d3d_texture_position) ptr_al_get_d3d_texture_position;
		typeof(&al_get_d3d_texture_size) ptr_al_get_d3d_texture_size;
		typeof(&al_is_d3d_device_lost) ptr_al_is_d3d_device_lost;
		typeof(&al_set_d3d_device_release_callback) ptr_al_set_d3d_device_release_callback;
		typeof(&al_set_d3d_device_restore_callback) ptr_al_set_d3d_device_restore_callback;
	}
}
