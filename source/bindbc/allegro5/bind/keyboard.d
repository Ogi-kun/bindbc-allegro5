module bindbc.allegro5.bind.keyboard;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.keycodes;
import bindbc.allegro5.bind.events : ALLEGRO_EVENT_SOURCE;
import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;

struct ALLEGRO_KEYBOARD;

struct ALLEGRO_KEYBOARD_STATE {
	ALLEGRO_DISPLAY *display;
	uint[(ALLEGRO_KEY_MAX + 31) / 32] __key_down__internal__;
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	bool al_is_keyboard_installed();
	bool al_install_keyboard();
	void al_uninstall_keyboard();
	bool al_set_keyboard_leds(int leds);
	const(char)* al_keycode_to_name(int keycode);
	void al_get_keyboard_state(ALLEGRO_KEYBOARD_STATE* ret_state);
	bool al_key_down(const(ALLEGRO_KEYBOARD_STATE)* state, int keycode);
	ALLEGRO_EVENT_SOURCE* al_get_keyboard_event_source();

	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
		void al_clear_keyboard_state(ALLEGRO_DISPLAY* display);
	}
	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		bool al_can_set_keyboard_leds();
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	bool al_is_keyboard_installed() => ptr_al_is_keyboard_installed();
	bool al_install_keyboard() => ptr_al_install_keyboard();
	void al_uninstall_keyboard() => ptr_al_uninstall_keyboard();
	bool al_set_keyboard_leds(int leds) => ptr_al_set_keyboard_leds(leds);
	const(char)* al_keycode_to_name(int keycode) => ptr_al_keycode_to_name(keycode);
	void al_get_keyboard_state(ALLEGRO_KEYBOARD_STATE* ret_state) => ptr_al_get_keyboard_state(ret_state);
	bool al_key_down(const(ALLEGRO_KEYBOARD_STATE)* state, int keycode) => ptr_al_key_down(state, keycode);
	ALLEGRO_EVENT_SOURCE* al_get_keyboard_event_source() => ptr_al_get_keyboard_event_source();

	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
		void al_clear_keyboard_state(ALLEGRO_DISPLAY* display) => ptr_al_clear_keyboard_state(display);
	}
	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		bool al_can_set_keyboard_leds() => ptr_al_can_set_keyboard_leds();
	}

	package(bindbc.allegro5) __gshared {
		typeof(&al_is_keyboard_installed) ptr_al_is_keyboard_installed;
		typeof(&al_install_keyboard) ptr_al_install_keyboard;
		typeof(&al_uninstall_keyboard) ptr_al_uninstall_keyboard;
		typeof(&al_set_keyboard_leds) ptr_al_set_keyboard_leds;
		typeof(&al_keycode_to_name) ptr_al_keycode_to_name;
		typeof(&al_get_keyboard_state) ptr_al_get_keyboard_state;
		typeof(&al_key_down) ptr_al_key_down;
		typeof(&al_get_keyboard_event_source) ptr_al_get_keyboard_event_source;

		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
			typeof(&al_clear_keyboard_state) ptr_al_clear_keyboard_state;
		}
		static if (allegroSupport >= AllegroSupport.v5_2_9) {
			typeof(&al_can_set_keyboard_leds) ptr_al_can_set_keyboard_leds;
		}
	}
}
