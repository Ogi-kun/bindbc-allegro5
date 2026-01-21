module bindbc.allegro5.bind.joystick;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.events : ALLEGRO_EVENT_SOURCE;
import bindbc.allegro5.bind.file : ALLEGRO_FILE;

static if (allegroSupport >= AllegroSupport.v5_2_11) {
	enum _AL_MAX_JOYSTICK_AXES = 6;
}
else {
	enum _AL_MAX_JOYSTICK_AXES = 3;
}

enum _AL_MAX_JOYSTICK_STICKS = 16;

static if (allegroSupport >= AllegroSupport.v5_2_10) {
	version (Android) {
		enum _AL_MAX_JOYSTICK_BUTTONS = 36;
	}
	else {
		enum _AL_MAX_JOYSTICK_BUTTONS = 32;
	}
}
else {
	enum _AL_MAX_JOYSTICK_BUTTONS = 32;
}

struct ALLEGRO_JOYSTICK;

struct ALLEGRO_JOYSTICK_STATE {
	private struct STICK {
		float[_AL_MAX_JOYSTICK_AXES] axis;
	}
	STICK[_AL_MAX_JOYSTICK_STICKS] stick;
	int[_AL_MAX_JOYSTICK_BUTTONS] button;
}

enum ALLEGRO_JOYFLAGS {
	ALLEGRO_JOYFLAG_DIGITAL  = 0x01,
	ALLEGRO_JOYFLAG_ANALOGUE = 0x02,
}
mixin ExpandEnum!ALLEGRO_JOYFLAGS;

version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_11) {
	enum ALLEGRO_GAMEPAD_BUTTON {
		ALLEGRO_GAMEPAD_BUTTON_A,
		ALLEGRO_GAMEPAD_BUTTON_B,
		ALLEGRO_GAMEPAD_BUTTON_X,
		ALLEGRO_GAMEPAD_BUTTON_Y,
		ALLEGRO_GAMEPAD_BUTTON_LEFT_SHOULDER,
		ALLEGRO_GAMEPAD_BUTTON_RIGHT_SHOULDER,
		ALLEGRO_GAMEPAD_BUTTON_BACK,
		ALLEGRO_GAMEPAD_BUTTON_START,
		ALLEGRO_GAMEPAD_BUTTON_GUIDE,
		ALLEGRO_GAMEPAD_BUTTON_LEFT_THUMB,
		ALLEGRO_GAMEPAD_BUTTON_RIGHT_THUMB,
	}
	mixin ExpandEnum!ALLEGRO_GAMEPAD_BUTTON;

	enum ALLEGRO_GAMEPAD_STICK {
		ALLEGRO_GAMEPAD_STICK_DPAD,
		ALLEGRO_GAMEPAD_STICK_LEFT_THUMB,
		ALLEGRO_GAMEPAD_STICK_RIGHT_THUMB,
		ALLEGRO_GAMEPAD_STICK_LEFT_TRIGGER,
		ALLEGRO_GAMEPAD_STICK_RIGHT_TRIGGER,
	}
	mixin ExpandEnum!ALLEGRO_GAMEPAD_STICK;

	enum ALLEGRO_JOYSTICK_TYPE {
		ALLEGRO_JOYSTICK_TYPE_UNKNOWN,
		ALLEGRO_JOYSTICK_TYPE_GAMEPAD,
	}
	mixin ExpandEnum!ALLEGRO_JOYSTICK_TYPE;

	struct ALLEGRO_JOYSTICK_GUID {
		ubyte[16] val;
	}
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	bool al_install_joystick();
	void al_uninstall_joystick();
	bool al_is_joystick_installed();
	bool al_reconfigure_joysticks();

	int al_get_num_joysticks();
	ALLEGRO_JOYSTICK* al_get_joystick(int joyn);
	void al_release_joystick(ALLEGRO_JOYSTICK* joystick);
	bool al_get_joystick_active(ALLEGRO_JOYSTICK* joystick);
	const(char)* al_get_joystick_name(ALLEGRO_JOYSTICK* joystick);

	int al_get_joystick_num_sticks(ALLEGRO_JOYSTICK* joystick);
	int al_get_joystick_stick_flags(ALLEGRO_JOYSTICK* joystick, int stick);
	const(char)* al_get_joystick_stick_name(ALLEGRO_JOYSTICK* joystick, int stick);

	int al_get_joystick_num_axes(ALLEGRO_JOYSTICK* joystick, int stick);
	const(char)* al_get_joystick_axis_name(ALLEGRO_JOYSTICK* joystick, int stick, int axis);

	int al_get_joystick_num_buttons(ALLEGRO_JOYSTICK* joystick);
	const(char)* al_get_joystick_button_name(ALLEGRO_JOYSTICK* joystick, int buttonn);

	version (ALLEGRO_UNSTABLE) {
		void al_get_joystick_state(ALLEGRO_JOYSTICK* joystick, ALLEGRO_JOYSTICK_STATE* ret_state);
	}
	else {
		deprecated("`ALLEGRO_JOYSTICK_STATE` layout changes between different Allegro versions. Consider enabling `ALLEGRO_UNSTABLE`.")
		void al_get_joystick_state(ALLEGRO_JOYSTICK* joystick, ALLEGRO_JOYSTICK_STATE* ret_state);
	}

	ALLEGRO_EVENT_SOURCE* al_get_joystick_event_source();

	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_11) {
		ALLEGRO_JOYSTICK_GUID al_get_joystick_guid(ALLEGRO_JOYSTICK* joystick);
		ALLEGRO_JOYSTICK_TYPE al_get_joystick_type(ALLEGRO_JOYSTICK* joystick);
		bool al_set_joystick_mappings(const(char)* filename);
		bool al_set_joystick_mappings_f(ALLEGRO_FILE* file);
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	bool al_install_joystick() => ptr_al_install_joystick();
	void al_uninstall_joystick() => ptr_al_uninstall_joystick();
	bool al_is_joystick_installed() => ptr_al_is_joystick_installed();
	bool al_reconfigure_joysticks() => ptr_al_reconfigure_joysticks();

	int al_get_num_joysticks() => ptr_al_get_num_joysticks();
	ALLEGRO_JOYSTICK* al_get_joystick(int joyn) => ptr_al_get_joystick(joyn);
	void al_release_joystick(ALLEGRO_JOYSTICK* joystick) => ptr_al_release_joystick(joystick);
	bool al_get_joystick_active(ALLEGRO_JOYSTICK* joystick) => ptr_al_get_joystick_active(joystick);
	const(char)* al_get_joystick_name(ALLEGRO_JOYSTICK* joystick) => ptr_al_get_joystick_name(joystick);

	int al_get_joystick_num_sticks(ALLEGRO_JOYSTICK* joystick) => ptr_al_get_joystick_num_sticks(joystick);
	int al_get_joystick_stick_flags(ALLEGRO_JOYSTICK* joystick, int stick) => ptr_al_get_joystick_stick_flags(joystick, stick);
	const(char)* al_get_joystick_stick_name(ALLEGRO_JOYSTICK* joystick, int stick) => ptr_al_get_joystick_stick_name(joystick, stick);

	int al_get_joystick_num_axes(ALLEGRO_JOYSTICK* joystick, int stick) => ptr_al_get_joystick_num_axes(joystick, stick);
	const(char)* al_get_joystick_axis_name(ALLEGRO_JOYSTICK* joystick, int stick, int axis) => ptr_al_get_joystick_axis_name(joystick, stick, axis);

	int al_get_joystick_num_buttons(ALLEGRO_JOYSTICK* joystick) => ptr_al_get_joystick_num_buttons(joystick);
	const(char)* al_get_joystick_button_name(ALLEGRO_JOYSTICK* joystick, int buttonn) => ptr_al_get_joystick_button_name(joystick, buttonn);

	version (ALLEGRO_UNSTABLE) {
		void al_get_joystick_state(ALLEGRO_JOYSTICK* joystick, ALLEGRO_JOYSTICK_STATE* ret_state) => ptr_al_get_joystick_state(joystick, ret_state);
	}
	else {
		deprecated("`ALLEGRO_JOYSTICK_STATE` layout changes between different Allegro versions. Consider enabling `ALLEGRO_UNSTABLE`.")
		void al_get_joystick_state(ALLEGRO_JOYSTICK* joystick, ALLEGRO_JOYSTICK_STATE* ret_state) => ptr_al_get_joystick_state(joystick, ret_state);
	}

	ALLEGRO_EVENT_SOURCE* al_get_joystick_event_source() => ptr_al_get_joystick_event_source();

	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_11) {
		ALLEGRO_JOYSTICK_GUID al_get_joystick_guid(ALLEGRO_JOYSTICK* joystick) => ptr_al_get_joystick_guid(joystick);
		ALLEGRO_JOYSTICK_TYPE al_get_joystick_type(ALLEGRO_JOYSTICK* joystick) => ptr_al_get_joystick_type(joystick);
		bool al_set_joystick_mappings(const(char)* filename) => ptr_al_set_joystick_mappings(filename);
		bool al_set_joystick_mappings_f(ALLEGRO_FILE* file) => ptr_al_set_joystick_mappings_f(file);
	}

	package(bindbc.allegro5) __gshared {
		typeof(&al_install_joystick) ptr_al_install_joystick;
		typeof(&al_uninstall_joystick) ptr_al_uninstall_joystick;
		typeof(&al_is_joystick_installed) ptr_al_is_joystick_installed;
		typeof(&al_reconfigure_joysticks) ptr_al_reconfigure_joysticks;

		typeof(&al_get_num_joysticks) ptr_al_get_num_joysticks;
		typeof(&al_get_joystick) ptr_al_get_joystick;
		typeof(&al_release_joystick) ptr_al_release_joystick;
		typeof(&al_get_joystick_active) ptr_al_get_joystick_active;
		typeof(&al_get_joystick_name) ptr_al_get_joystick_name;

		typeof(&al_get_joystick_num_sticks) ptr_al_get_joystick_num_sticks;
		typeof(&al_get_joystick_stick_flags) ptr_al_get_joystick_stick_flags;
		typeof(&al_get_joystick_stick_name) ptr_al_get_joystick_stick_name;

		typeof(&al_get_joystick_num_axes) ptr_al_get_joystick_num_axes;
		typeof(&al_get_joystick_axis_name) ptr_al_get_joystick_axis_name;

		typeof(&al_get_joystick_num_buttons) ptr_al_get_joystick_num_buttons;
		typeof(&al_get_joystick_button_name) ptr_al_get_joystick_button_name;

		typeof(&al_get_joystick_state) ptr_al_get_joystick_state;

		typeof(&al_get_joystick_event_source) ptr_al_get_joystick_event_source;

		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_11) {
			typeof(&al_get_joystick_guid) ptr_al_get_joystick_guid;
			typeof(&al_get_joystick_type) ptr_al_get_joystick_type;
			typeof(&al_set_joystick_mappings) ptr_al_set_joystick_mappings;
			typeof(&al_set_joystick_mappings_f) ptr_al_set_joystick_mappings_f;
		}
	}
}
