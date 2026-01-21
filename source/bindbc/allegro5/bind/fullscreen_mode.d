module bindbc.allegro5.bind.fullscreen_mode;

import bindbc.allegro5.config;

struct ALLEGRO_DISPLAY_MODE {
	int width;
	int height;
	int format;
	int refresh_rate;
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	int al_get_num_display_modes();
	ALLEGRO_DISPLAY_MODE* al_get_display_mode(int index,  ALLEGRO_DISPLAY_MODE* mode);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	int al_get_num_display_modes() => ptr_al_get_num_display_modes();
	ALLEGRO_DISPLAY_MODE* al_get_display_mode(int index,  ALLEGRO_DISPLAY_MODE* mode) => ptr_al_get_display_mode(index, mode);
	package(bindbc.allegro5) __gshared {
		typeof(&al_get_num_display_modes) ptr_al_get_num_display_modes;
		typeof(&al_get_display_mode) ptr_al_get_display_mode;
	}
}
