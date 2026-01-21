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


enum ALLEGRO_MOUSE_BUTTON
{
	ALLEGRO_MOUSE_BUTTON_LEFT = 1,
	ALLEGRO_MOUSE_BUTTON_RIGHT = 2,
	ALLEGRO_MOUSE_BUTTON_MIDDLE = 3,
}
mixin ExpandEnum!ALLEGRO_MOUSE_BUTTON;

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
	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		bool al_can_get_mouse_cursor_position();
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	bool al_is_mouse_installed() => ptr_al_is_mouse_installed();
	bool al_install_mouse() => ptr_al_install_mouse();
	void al_uninstall_mouse() => ptr_al_uninstall_mouse();
	uint al_get_mouse_num_buttons() => ptr_al_get_mouse_num_buttons();
	uint al_get_mouse_num_axes() => ptr_al_get_mouse_num_axes();
	bool al_set_mouse_xy(ALLEGRO_DISPLAY* display, int x, int y) => ptr_al_set_mouse_xy(display, x, y);
	bool al_set_mouse_z(int z) => ptr_al_set_mouse_z(z);
	bool al_set_mouse_w(int w) => ptr_al_set_mouse_w(w);
	bool al_set_mouse_axis(int axis, int value) => ptr_al_set_mouse_axis(axis, value);
	void al_get_mouse_state(ALLEGRO_MOUSE_STATE* ret_state) => ptr_al_get_mouse_state(ret_state);
	bool al_mouse_button_down(const(ALLEGRO_MOUSE_STATE)* state, int button) => ptr_al_mouse_button_down(state, button);
	int al_get_mouse_state_axis(const(ALLEGRO_MOUSE_STATE)* state, int axis) => ptr_al_get_mouse_state_axis(state, axis);
	bool al_get_mouse_cursor_position(int* ret_x, int* ret_y) => ptr_al_get_mouse_cursor_position(ret_x, ret_y);
	bool al_grab_mouse(ALLEGRO_DISPLAY* display) => ptr_al_grab_mouse(display);
	bool al_ungrab_mouse() => ptr_al_ungrab_mouse();
	void al_set_mouse_wheel_precision(int precision) => ptr_al_set_mouse_wheel_precision(precision);
	int al_get_mouse_wheel_precision() => ptr_al_get_mouse_wheel_precision();
	ALLEGRO_EVENT_SOURCE* al_get_mouse_event_source() => ptr_al_get_mouse_event_source();
	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		bool al_can_get_mouse_cursor_position() => ptr_al_can_get_mouse_cursor_position();
	}

	package(bindbc.allegro5) __gshared {
		typeof(&al_is_mouse_installed) ptr_al_is_mouse_installed;
		typeof(&al_install_mouse) ptr_al_install_mouse;
		typeof(&al_uninstall_mouse) ptr_al_uninstall_mouse;
		typeof(&al_get_mouse_num_buttons) ptr_al_get_mouse_num_buttons;
		typeof(&al_get_mouse_num_axes) ptr_al_get_mouse_num_axes;
		typeof(&al_set_mouse_xy) ptr_al_set_mouse_xy;
		typeof(&al_set_mouse_z) ptr_al_set_mouse_z;
		typeof(&al_set_mouse_w) ptr_al_set_mouse_w;
		typeof(&al_set_mouse_axis) ptr_al_set_mouse_axis;
		typeof(&al_get_mouse_state) ptr_al_get_mouse_state;
		typeof(&al_mouse_button_down) ptr_al_mouse_button_down;
		typeof(&al_get_mouse_state_axis) ptr_al_get_mouse_state_axis;
		typeof(&al_get_mouse_cursor_position) ptr_al_get_mouse_cursor_position;
		typeof(&al_grab_mouse) ptr_al_grab_mouse;
		typeof(&al_ungrab_mouse) ptr_al_ungrab_mouse;
		typeof(&al_set_mouse_wheel_precision) ptr_al_set_mouse_wheel_precision;
		typeof(&al_get_mouse_wheel_precision) ptr_al_get_mouse_wheel_precision;
		typeof(&al_get_mouse_event_source) ptr_al_get_mouse_event_source;

		static if (allegroSupport >= AllegroSupport.v5_2_9) {
			typeof(&al_can_get_mouse_cursor_position) ptr_al_can_get_mouse_cursor_position;
		}
	}
}
