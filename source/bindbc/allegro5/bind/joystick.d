module bindbc.allegro5.bind.joystick;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.file;
import bindbc.allegro5.bind.events : ALLEGRO_EVENT_SOURCE;

enum _AL_MAX_JOYSTICK_AXES = 3;

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
	void al_release_joystick(ALLEGRO_JOYSTICK*);
	bool al_get_joystick_active(ALLEGRO_JOYSTICK*);
	const(char)* al_get_joystick_name(ALLEGRO_JOYSTICK*);

	int al_get_joystick_num_sticks(ALLEGRO_JOYSTICK*);
	int al_get_joystick_stick_flags(ALLEGRO_JOYSTICK*, int stick);
	const(char)* al_get_joystick_stick_name(ALLEGRO_JOYSTICK*, int stick);

	int al_get_joystick_num_axes(ALLEGRO_JOYSTICK*, int stick);
	const(char)* al_get_joystick_axis_name(ALLEGRO_JOYSTICK*, int stick, int axis);

	int al_get_joystick_num_buttons(ALLEGRO_JOYSTICK*);
	const(char)* al_get_joystick_button_name(ALLEGRO_JOYSTICK*, int buttonn);

	void al_get_joystick_state(ALLEGRO_JOYSTICK*, ALLEGRO_JOYSTICK_STATE* ret_state);

	ALLEGRO_EVENT_SOURCE* al_get_joystick_event_source();

	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_11) {
		ALLEGRO_JOYSTICK_GUID al_get_joystick_guid(ALLEGRO_JOYSTICK*);
		ALLEGRO_JOYSTICK_TYPE al_get_joystick_type(ALLEGRO_JOYSTICK*);
		bool al_set_joystick_mappings(const(char)* filename);
		bool al_set_joystick_mappings_f(ALLEGRO_FILE* file);
	}
}
else {
	extern(C) @nogc nothrow {
		alias pal_install_joystick = bool function();
		alias pal_uninstall_joystick = void function();
		alias pal_is_joystick_installed = bool function();
		alias pal_reconfigure_joysticks = bool function();

		alias pal_get_num_joysticks = int function();
		alias pal_get_joystick = ALLEGRO_JOYSTICK* function(int joyn);
		alias pal_release_joystick = void function(ALLEGRO_JOYSTICK*);
		alias pal_get_joystick_active = bool function(ALLEGRO_JOYSTICK*);
		alias pal_get_joystick_name = const(char)* function(ALLEGRO_JOYSTICK*);

		alias pal_get_joystick_num_sticks = int function(ALLEGRO_JOYSTICK*);
		alias pal_get_joystick_stick_flags = int function(ALLEGRO_JOYSTICK*, int stick);
		alias pal_get_joystick_stick_name = const(char)* function(ALLEGRO_JOYSTICK*, int stick);

		alias pal_get_joystick_num_axes = int function(ALLEGRO_JOYSTICK*, int stick);
		alias pal_get_joystick_axis_name = const(char)* function(ALLEGRO_JOYSTICK*, int stick, int axis);

		alias pal_get_joystick_num_buttons = int function(ALLEGRO_JOYSTICK*);
		alias pal_get_joystick_button_name = const(char)* function(ALLEGRO_JOYSTICK*, int buttonn);

		alias pal_get_joystick_state = void function(ALLEGRO_JOYSTICK*, ALLEGRO_JOYSTICK_STATE* ret_state);

		alias pal_get_joystick_event_source = ALLEGRO_EVENT_SOURCE* function();
	}
	__gshared {
		pal_install_joystick al_install_joystick;
		pal_uninstall_joystick al_uninstall_joystick;
		pal_is_joystick_installed al_is_joystick_installed;
		pal_reconfigure_joysticks al_reconfigure_joysticks;

		pal_get_num_joysticks al_get_num_joysticks;
		pal_get_joystick al_get_joystick;
		pal_release_joystick al_release_joystick;
		pal_get_joystick_active al_get_joystick_active;
		pal_get_joystick_name al_get_joystick_name;

		pal_get_joystick_num_sticks al_get_joystick_num_sticks;
		pal_get_joystick_stick_flags al_get_joystick_stick_flags;
		pal_get_joystick_stick_name al_get_joystick_stick_name;

		pal_get_joystick_num_axes al_get_joystick_num_axes;
		pal_get_joystick_axis_name al_get_joystick_axis_name;

		pal_get_joystick_num_buttons al_get_joystick_num_buttons;
		pal_get_joystick_button_name al_get_joystick_button_name;

		pal_get_joystick_state al_get_joystick_state;

		pal_get_joystick_event_source al_get_joystick_event_source;
	}

	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_11) {
		extern(C) @nogc nothrow {
			alias pal_get_joystick_guid = ALLEGRO_JOYSTICK_GUID function(ALLEGRO_JOYSTICK*);
			alias pal_get_joystick_type = ALLEGRO_JOYSTICK_TYPE function(ALLEGRO_JOYSTICK*);
			alias pal_set_joystick_mappings = bool function(const(char)* filename);
			alias pal_set_joystick_mappings_f = bool function(ALLEGRO_FILE* file);
		}
		__gshared {
			pal_get_joystick_guid al_get_joystick_guid;
			pal_get_joystick_type al_get_joystick_type;
			pal_set_joystick_mappings al_set_joystick_mappings;
			pal_set_joystick_mappings_f al_set_joystick_mappings_f;
		}
	}
}
