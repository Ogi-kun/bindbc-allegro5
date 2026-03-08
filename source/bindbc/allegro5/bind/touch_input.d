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
	pragma(inline, true) extern(C) @nogc nothrow:

	bool al_is_touch_input_installed() => ptr_al_is_touch_input_installed();
	bool al_install_touch_input() => ptr_al_install_touch_input();
	void al_uninstall_touch_input() => ptr_al_uninstall_touch_input();
	void al_get_touch_input_state(ALLEGRO_TOUCH_INPUT_STATE* ret_state) => ptr_al_get_touch_input_state(ret_state);
	ALLEGRO_EVENT_SOURCE * al_get_touch_input_event_source() => ptr_al_get_touch_input_event_source();

	version (ALLEGRO_UNSTABLE) {
		void al_set_mouse_emulation_mode(int mode) => ptr_al_set_mouse_emulation_mode(mode);
		int al_get_mouse_emulation_mode() => ptr_al_get_mouse_emulation_mode();
		ALLEGRO_EVENT_SOURCE* al_get_touch_input_mouse_emulation_event_source() => ptr_al_get_touch_input_mouse_emulation_event_source();
	}

	package(bindbc.allegro5)__gshared {
		typeof(&al_is_touch_input_installed) ptr_al_is_touch_input_installed;
		typeof(&al_install_touch_input) ptr_al_install_touch_input;
		typeof(&al_uninstall_touch_input) ptr_al_uninstall_touch_input;
		typeof(&al_get_touch_input_state) ptr_al_get_touch_input_state;
		typeof(&al_get_touch_input_event_source) ptr_al_get_touch_input_event_source;

		version (ALLEGRO_UNSTABLE) {
			typeof(&al_set_mouse_emulation_mode) ptr_al_set_mouse_emulation_mode;
			typeof(&al_get_mouse_emulation_mode) ptr_al_get_mouse_emulation_mode;
			typeof(&al_get_touch_input_mouse_emulation_event_source) ptr_al_get_touch_input_mouse_emulation_event_source;
		}
	}
}
