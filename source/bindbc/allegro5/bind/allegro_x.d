module bindbc.allegro5.bind.allegro_x;

import core.stdc.config : c_ulong;
import bindbc.allegro5.config;
import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;

version (ALLEGRO_X11):

alias XID = c_ulong;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	XID al_get_x_window_id(ALLEGRO_DISPLAY* display);
	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
		bool al_x_set_initial_icon(ALLEGRO_BITMAP* bitmap);
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	XID al_get_x_window_id(ALLEGRO_DISPLAY* display) => ptr_al_get_x_window_id(display);
	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
		bool al_x_set_initial_icon(ALLEGRO_BITMAP* bitmap) => ptr_al_x_set_initial_icon(bitmap);
	}
	package(bindbc.allegro5) __gshared {
		typeof(&al_get_x_window_id) ptr_al_get_x_window_id;
		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
			typeof(&al_x_set_initial_icon) ptr_al_x_set_initial_icon;
		}
	}
}
