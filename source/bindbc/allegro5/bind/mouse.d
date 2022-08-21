module bindbc.allegro5.bind.mouse;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;
import bindbc.allegro5.bind.events : ALLEGRO_EVENT_SOURCE;

enum ALLEGRO_MOUSE_MAX_EXTRA_AXES = 4;

struct ALLEGRO_MOUSE;

struct ALLEGRO_MOUSE_STATE {
   int x;
   int y;
   int z;
   int w;
   int[ALLEGRO_MOUSE_MAX_EXTRA_AXES] more_axes;
   int buttons;
   float pressure;
   ALLEGRO_DISPLAY* display;
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	bool al_is_mouse_installed();
	bool al_install_mouse();
	void al_uninstall_mouse();
	uint al_get_mouse_num_buttons();
	uint al_get_mouse_num_axes();
	bool al_set_mouse_xy(ALLEGRO_DISPLAY* display, int x, int y);
	bool al_set_mouse_z(int z);
	bool al_set_mouse_w(int w);
	bool al_set_mouse_axis(int axis, int value);
	void al_get_mouse_state(ALLEGRO_MOUSE_STATE* ret_state);
	bool al_mouse_button_down(const(ALLEGRO_MOUSE_STATE)* state, int button);
	int al_get_mouse_state_axis(const(ALLEGRO_MOUSE_STATE)* state, int axis);
	bool al_get_mouse_cursor_position(int* ret_x, int* ret_y);
	bool al_grab_mouse(ALLEGRO_DISPLAY* display);
	bool al_ungrab_mouse();
	void al_set_mouse_wheel_precision(int precision);
	int al_get_mouse_wheel_precision();
	ALLEGRO_EVENT_SOURCE* al_get_mouse_event_source();
}
else {
	extern(C) @nogc nothrow {
		alias pal_is_mouse_installed = bool function();
		alias pal_install_mouse = bool function();
		alias pal_uninstall_mouse = void function();
		alias pal_get_mouse_num_buttons = uint function();
		alias pal_get_mouse_num_axes = uint function();
		alias pal_set_mouse_xy = bool function(ALLEGRO_DISPLAY* display, int x, int y);
		alias pal_set_mouse_z = bool function(int z);
		alias pal_set_mouse_w = bool function(int w);
		alias pal_set_mouse_axis = bool function(int axis, int value);
		alias pal_get_mouse_state = void function(ALLEGRO_MOUSE_STATE* ret_state);
		alias pal_mouse_button_down = bool function(const(ALLEGRO_MOUSE_STATE)* state, int button);
		alias pal_get_mouse_state_axis = int function(const(ALLEGRO_MOUSE_STATE)* state, int axis);
		alias pal_get_mouse_cursor_position = bool function(int* ret_x, int* ret_y);
		alias pal_grab_mouse = bool function(ALLEGRO_DISPLAY* display);
		alias pal_ungrab_mouse = bool function();
		alias pal_set_mouse_wheel_precision = void function(int precision);
		alias pal_get_mouse_wheel_precision = int function();
		alias pal_get_mouse_event_source = ALLEGRO_EVENT_SOURCE* function();
	}
	__gshared {
		pal_is_mouse_installed al_is_mouse_installed;
		pal_install_mouse al_install_mouse;
		pal_uninstall_mouse al_uninstall_mouse;
		pal_get_mouse_num_buttons al_get_mouse_num_buttons;
		pal_get_mouse_num_axes al_get_mouse_num_axes;
		pal_set_mouse_xy al_set_mouse_xy;
		pal_set_mouse_z al_set_mouse_z;
		pal_set_mouse_w al_set_mouse_w;
		pal_set_mouse_axis al_set_mouse_axis;
		pal_get_mouse_state al_get_mouse_state;
		pal_mouse_button_down al_mouse_button_down;
		pal_get_mouse_state_axis al_get_mouse_state_axis;
		pal_get_mouse_cursor_position al_get_mouse_cursor_position;
		pal_grab_mouse al_grab_mouse;
		pal_ungrab_mouse al_ungrab_mouse;
		pal_set_mouse_wheel_precision al_set_mouse_wheel_precision;
		pal_get_mouse_wheel_precision al_get_mouse_wheel_precision;
		pal_get_mouse_event_source al_get_mouse_event_source;
	}
}
