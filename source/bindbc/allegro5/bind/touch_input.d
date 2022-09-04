module bindbc.allegro5.bind.touch_input;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.events : ALLEGRO_EVENT_SOURCE;
import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;

enum ALLEGRO_TOUCH_INPUT_MAX_TOUCH_COUNT = 16;

struct ALLEGRO_TOUCH_INPUT;

struct ALLEGRO_TOUCH_STATE {
	int id;
	float x, y;
	float dx, dy;
	bool primary;
	ALLEGRO_DISPLAY* display;
}

struct ALLEGRO_TOUCH_INPUT_STATE {
	ALLEGRO_TOUCH_STATE[ALLEGRO_TOUCH_INPUT_MAX_TOUCH_COUNT] touches;
}

version (ALLEGRO_UNSTABLE) {
	enum ALLEGRO_MOUSE_EMULATION_MODE : int {
		ALLEGRO_MOUSE_EMULATION_NONE,
		ALLEGRO_MOUSE_EMULATION_TRANSPARENT,
		ALLEGRO_MOUSE_EMULATION_INCLUSIVE,
		ALLEGRO_MOUSE_EMULATION_EXCLUSIVE,
		ALLEGRO_MOUSE_EMULATION_5_0_x,
	}
	mixin ExpandEnum!ALLEGRO_MOUSE_EMULATION_MODE;
}


static if (staticBinding) {
	extern(C) @nogc nothrow:
	bool al_is_touch_input_installed();
	bool al_install_touch_input();
	void al_uninstall_touch_input();
	void al_get_touch_input_state(ALLEGRO_TOUCH_INPUT_STATE* ret_state);
	ALLEGRO_EVENT_SOURCE * al_get_touch_input_event_source();

	version (ALLEGRO_UNSTABLE) {
		void al_set_mouse_emulation_mode(int mode);
		int al_get_mouse_emulation_mode();
		ALLEGRO_EVENT_SOURCE* al_get_touch_input_mouse_emulation_event_source();
	}
}
else {
	extern(C) @nogc nothrow {
		alias pal_is_touch_input_installed = bool function();
		alias pal_install_touch_input = bool function();
		alias pal_uninstall_touch_input = void function();
		alias pal_get_touch_input_state = void function(ALLEGRO_TOUCH_INPUT_STATE* ret_state);
		alias pal_get_touch_input_event_source = ALLEGRO_EVENT_SOURCE* function();
	}
	__gshared {
		pal_is_touch_input_installed al_is_touch_input_installed;
		pal_install_touch_input al_install_touch_input;
		pal_uninstall_touch_input al_uninstall_touch_input;
		pal_get_touch_input_state al_get_touch_input_state;
		pal_get_touch_input_event_source al_get_touch_input_event_source;
	}
	
	version (ALLEGRO_UNSTABLE) {
		extern(C) @nogc nothrow {
			alias pal_set_mouse_emulation_mode = void function(int mode);
			alias pal_get_mouse_emulation_mode = int function();
			alias pal_get_touch_input_mouse_emulation_event_source = ALLEGRO_EVENT_SOURCE* function();
		}
		__gshared {
			pal_set_mouse_emulation_mode al_set_mouse_emulation_mode;
			pal_get_mouse_emulation_mode al_get_mouse_emulation_mode;
			pal_get_touch_input_mouse_emulation_event_source al_get_touch_input_mouse_emulation_event_source;
		}
	}
}
