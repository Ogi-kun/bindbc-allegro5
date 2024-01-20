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
	bool al_key_down(const(ALLEGRO_KEYBOARD_STATE)*, int keycode);
	ALLEGRO_EVENT_SOURCE* al_get_keyboard_event_source();

	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
		void al_clear_keyboard_state(ALLEGRO_DISPLAY* display);
	}
	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		bool al_can_set_keyboard_leds();
	}
}
else {
	extern(C) @nogc nothrow {
		alias pal_is_keyboard_installed = bool function();
		alias pal_install_keyboard = bool function();
		alias pal_uninstall_keyboard = void function();
		alias pal_set_keyboard_leds = bool function(int leds);
		alias pal_keycode_to_name = const(char)* function(int keycode);
		alias pal_get_keyboard_state = void function(ALLEGRO_KEYBOARD_STATE* ret_state);
		alias pal_key_down = bool function(const(ALLEGRO_KEYBOARD_STATE)*, int keycode);
		alias pal_get_keyboard_event_source = ALLEGRO_EVENT_SOURCE* function();
	}
	__gshared {
		pal_is_keyboard_installed al_is_keyboard_installed;
		pal_install_keyboard al_install_keyboard;
		pal_uninstall_keyboard al_uninstall_keyboard;
		pal_set_keyboard_leds al_set_keyboard_leds;
		pal_keycode_to_name al_keycode_to_name;
		pal_get_keyboard_state al_get_keyboard_state;
		pal_key_down al_key_down;
		pal_get_keyboard_event_source al_get_keyboard_event_source;
	}
	
	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
		alias pal_clear_keyboard_state = extern(C) void function(ALLEGRO_DISPLAY* display) @nogc nothrow;
		__gshared pal_clear_keyboard_state al_clear_keyboard_state;
	}
	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		extern(C) @nogc nothrow {
			alias pal_can_set_keyboard_leds = bool function();
		}
		__gshared {
			pal_can_set_keyboard_leds al_can_set_keyboard_leds;
		}
	}
	
}
