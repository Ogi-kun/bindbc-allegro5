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
	extern(C) @nogc nothrow {
		alias pal_get_num_display_modes = int function();
		alias pal_get_display_mode = ALLEGRO_DISPLAY_MODE* function(int index,  ALLEGRO_DISPLAY_MODE* mode);
	}
	__gshared {
		pal_get_num_display_modes al_get_num_display_modes;
		pal_get_display_mode al_get_display_mode;
	}
}
