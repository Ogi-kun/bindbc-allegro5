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
	extern(C) @nogc nothrow {
		alias pal_get_x_window_id = XID function(ALLEGRO_DISPLAY* display);
		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
			alias pal_x_set_initial_icon = bool function(ALLEGRO_BITMAP* bitmap);
		}
	}
	
	__gshared {
		pal_get_x_window_id al_get_x_window_id;
		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
			pal_x_set_initial_icon al_x_set_initial_icon;
		}
	}
}
