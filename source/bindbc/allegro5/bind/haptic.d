module bindbc.allegro5.bind.haptic;

import bindbc.allegro5.config;

import bindbc.allegro5.bind.mouse : ALLEGRO_MOUSE;
import bindbc.allegro5.bind.joystick : ALLEGRO_JOYSTICK;
import bindbc.allegro5.bind.keyboard : ALLEGRO_KEYBOARD;
import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;
import bindbc.allegro5.bind.touch_input : ALLEGRO_TOUCH_INPUT;

version (ALLEGRO_UNSTABLE):

enum ALLEGRO_HAPTIC_CONSTANTS {
	ALLEGRO_HAPTIC_RUMBLE     = 1 << 0,
	ALLEGRO_HAPTIC_PERIODIC   = 1 << 1,
	ALLEGRO_HAPTIC_CONSTANT   = 1 << 2,
	ALLEGRO_HAPTIC_SPRING     = 1 << 3,
	ALLEGRO_HAPTIC_FRICTION   = 1 << 4,
	ALLEGRO_HAPTIC_DAMPER     = 1 << 5,
	ALLEGRO_HAPTIC_INERTIA    = 1 << 6,
	ALLEGRO_HAPTIC_RAMP       = 1 << 7,
	ALLEGRO_HAPTIC_SQUARE     = 1 << 8,
	ALLEGRO_HAPTIC_TRIANGLE   = 1 << 9,
	ALLEGRO_HAPTIC_SINE       = 1 << 10,
	ALLEGRO_HAPTIC_SAW_UP     = 1 << 11,
	ALLEGRO_HAPTIC_SAW_DOWN   = 1 << 12,
	ALLEGRO_HAPTIC_CUSTOM     = 1 << 13,
	ALLEGRO_HAPTIC_GAIN       = 1 << 14,
	ALLEGRO_HAPTIC_ANGLE      = 1 << 15,
	ALLEGRO_HAPTIC_RADIUS     = 1 << 16,
	ALLEGRO_HAPTIC_AZIMUTH    = 1 << 17,
	ALLEGRO_HAPTIC_AUTOCENTER = 1 << 18,
}
mixin ExpandEnum!ALLEGRO_HAPTIC_CONSTANTS;

struct ALLEGRO_HAPTIC;

struct ALLEGRO_HAPTIC_DIRECTION {
	double angle;
	double radius;
	double azimuth;
}

struct ALLEGRO_HAPTIC_REPLAY {
	double length;
	double delay;
}

struct ALLEGRO_HAPTIC_ENVELOPE {
	double attack_length;
	double attack_level;
	double fade_length;
	double fade_level;
}

struct ALLEGRO_HAPTIC_CONSTANT_EFFECT {
	double level;
	ALLEGRO_HAPTIC_ENVELOPE envelope;
}

struct ALLEGRO_HAPTIC_RAMP_EFFECT {
	double start_level;
	double end_level;
	ALLEGRO_HAPTIC_ENVELOPE envelope;
}

struct ALLEGRO_HAPTIC_CONDITION_EFFECT {
	double right_saturation;
	double left_saturation;
	double right_coeff;
	double left_coeff;
	double deadband;
	double center;
}

struct ALLEGRO_HAPTIC_PERIODIC_EFFECT {
	int waveform;
	double period;
	double magnitude;
	double offset;
	double phase;

	ALLEGRO_HAPTIC_ENVELOPE envelope;
	int custom_len;
	double* custom_data;
}

struct ALLEGRO_HAPTIC_RUMBLE_EFFECT {
	double strong_magnitude;
	double weak_magnitude;
}

union ALLEGRO_HAPTIC_EFFECT_UNION {
	ALLEGRO_HAPTIC_CONSTANT_EFFECT constant;
	ALLEGRO_HAPTIC_RAMP_EFFECT ramp;
	ALLEGRO_HAPTIC_PERIODIC_EFFECT periodic;
	ALLEGRO_HAPTIC_CONDITION_EFFECT condition;
	ALLEGRO_HAPTIC_RUMBLE_EFFECT rumble;
}

struct ALLEGRO_HAPTIC_EFFECT {
	int type;
	ALLEGRO_HAPTIC_DIRECTION direction;
	ALLEGRO_HAPTIC_REPLAY replay;
	ALLEGRO_HAPTIC_EFFECT_UNION data;
}

struct ALLEGRO_HAPTIC_EFFECT_ID {
	ALLEGRO_HAPTIC* _haptic;
	int _id;
	int _handle;
	void* _pointer;
	double _effect_duration;
	bool _playing;
	double _start_time;
	double _end_time;
	void* driver;
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	bool al_install_haptic();
	void al_uninstall_haptic();
	bool al_is_haptic_installed();

	bool al_is_mouse_haptic(ALLEGRO_MOUSE*);
	bool al_is_joystick_haptic(ALLEGRO_JOYSTICK*);
	bool al_is_keyboard_haptic(ALLEGRO_KEYBOARD*);
	bool al_is_display_haptic(ALLEGRO_DISPLAY*);
	bool al_is_touch_input_haptic(ALLEGRO_TOUCH_INPUT*);

	ALLEGRO_HAPTIC* al_get_haptic_from_mouse(ALLEGRO_MOUSE*);
	ALLEGRO_HAPTIC* al_get_haptic_from_joystick(ALLEGRO_JOYSTICK*);
	ALLEGRO_HAPTIC* al_get_haptic_from_keyboard(ALLEGRO_KEYBOARD*);
	ALLEGRO_HAPTIC* al_get_haptic_from_display(ALLEGRO_DISPLAY*);
	ALLEGRO_HAPTIC* al_get_haptic_from_touch_input(ALLEGRO_TOUCH_INPUT*);

	bool al_release_haptic(ALLEGRO_HAPTIC*);

	bool al_is_haptic_active(ALLEGRO_HAPTIC*);
	int al_get_haptic_capabilities(ALLEGRO_HAPTIC*);
	bool al_is_haptic_capable(ALLEGRO_HAPTIC*, int);

	bool al_set_haptic_gain(ALLEGRO_HAPTIC*, double);
	double al_get_haptic_gain(ALLEGRO_HAPTIC*);

	bool al_set_haptic_autocenter(ALLEGRO_HAPTIC*, double);
	double al_get_haptic_autocenter(ALLEGRO_HAPTIC*);

	int al_get_max_haptic_effects(ALLEGRO_HAPTIC*);
	bool al_is_haptic_effect_ok(ALLEGRO_HAPTIC*, ALLEGRO_HAPTIC_EFFECT*);
	bool al_upload_haptic_effect(ALLEGRO_HAPTIC*, ALLEGRO_HAPTIC_EFFECT*, ALLEGRO_HAPTIC_EFFECT_ID*);
	bool al_play_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID*, int);
	bool al_upload_and_play_haptic_effect(ALLEGRO_HAPTIC*, ALLEGRO_HAPTIC_EFFECT*, ALLEGRO_HAPTIC_EFFECT_ID*, int);
	bool al_stop_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID*);
	bool al_is_haptic_effect_playing(ALLEGRO_HAPTIC_EFFECT_ID*);
	bool al_release_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID*);
	double al_get_haptic_effect_duration(ALLEGRO_HAPTIC_EFFECT*);
	bool al_rumble_haptic(ALLEGRO_HAPTIC*, double, double, ALLEGRO_HAPTIC_EFFECT_ID*);
}
else {
	extern(C) @nogc nothrow {
		alias pal_install_haptic = bool function();
		alias pal_uninstall_haptic = void function();
		alias pal_is_haptic_installed = bool function();

		alias pal_is_mouse_haptic = bool function(ALLEGRO_MOUSE*);
		alias pal_is_joystick_haptic = bool function(ALLEGRO_JOYSTICK*);
		alias pal_is_keyboard_haptic = bool function(ALLEGRO_KEYBOARD*);
		alias pal_is_display_haptic = bool function(ALLEGRO_DISPLAY*);
		alias pal_is_touch_input_haptic = bool function(ALLEGRO_TOUCH_INPUT*);

		alias pal_get_haptic_from_mouse = ALLEGRO_HAPTIC* function(ALLEGRO_MOUSE*);
		alias pal_get_haptic_from_joystick = ALLEGRO_HAPTIC* function(ALLEGRO_JOYSTICK*);
		alias pal_get_haptic_from_keyboard = ALLEGRO_HAPTIC* function(ALLEGRO_KEYBOARD*);
		alias pal_get_haptic_from_display = ALLEGRO_HAPTIC* function(ALLEGRO_DISPLAY*);
		alias pal_get_haptic_from_touch_input = ALLEGRO_HAPTIC* function(ALLEGRO_TOUCH_INPUT*);

		alias pal_release_haptic = bool function(ALLEGRO_HAPTIC*);

		alias pal_is_haptic_active = bool function(ALLEGRO_HAPTIC*);
		alias pal_get_haptic_capabilities = int function(ALLEGRO_HAPTIC*);
		alias pal_is_haptic_capable = bool function(ALLEGRO_HAPTIC*, int);

		alias pal_set_haptic_gain = bool function(ALLEGRO_HAPTIC*, double);
		alias pal_get_haptic_gain = double function(ALLEGRO_HAPTIC*);

		alias pal_set_haptic_autocenter = bool function(ALLEGRO_HAPTIC*, double);
		alias pal_get_haptic_autocenter = double function(ALLEGRO_HAPTIC*);

		alias pal_get_max_haptic_effects = int function(ALLEGRO_HAPTIC*);
		alias pal_is_haptic_effect_ok = bool function(ALLEGRO_HAPTIC*, ALLEGRO_HAPTIC_EFFECT*);
		alias pal_upload_haptic_effect = bool function(ALLEGRO_HAPTIC*, ALLEGRO_HAPTIC_EFFECT*, ALLEGRO_HAPTIC_EFFECT_ID*);
		alias pal_play_haptic_effect = bool function(ALLEGRO_HAPTIC_EFFECT_ID*, int);
		alias pal_upload_and_play_haptic_effect = bool function(ALLEGRO_HAPTIC*, ALLEGRO_HAPTIC_EFFECT*, ALLEGRO_HAPTIC_EFFECT_ID*, int);
		alias pal_stop_haptic_effect = bool function(ALLEGRO_HAPTIC_EFFECT_ID*);
		alias pal_is_haptic_effect_playing = bool function(ALLEGRO_HAPTIC_EFFECT_ID*);
		alias pal_release_haptic_effect = bool function(ALLEGRO_HAPTIC_EFFECT_ID*);
		alias pal_get_haptic_effect_duration = double function(ALLEGRO_HAPTIC_EFFECT*);
		alias pal_rumble_haptic = bool function(ALLEGRO_HAPTIC*, double, double, ALLEGRO_HAPTIC_EFFECT_ID*);
	}
	__gshared {
		pal_install_haptic al_install_haptic;
		pal_uninstall_haptic al_uninstall_haptic;
		pal_is_haptic_installed al_is_haptic_installed;

		pal_is_mouse_haptic al_is_mouse_haptic;
		pal_is_joystick_haptic al_is_joystick_haptic;
		pal_is_keyboard_haptic al_is_keyboard_haptic;
		pal_is_display_haptic al_is_display_haptic;
		pal_is_touch_input_haptic al_is_touch_input_haptic;

		pal_get_haptic_from_mouse al_get_haptic_from_mouse;
		pal_get_haptic_from_joystick al_get_haptic_from_joystick;
		pal_get_haptic_from_keyboard al_get_haptic_from_keyboard;
		pal_get_haptic_from_display al_get_haptic_from_display;
		pal_get_haptic_from_touch_input al_get_haptic_from_touch_input;

		pal_release_haptic al_release_haptic;

		pal_is_haptic_active al_is_haptic_active;
		pal_get_haptic_capabilities al_get_haptic_capabilities;
		pal_is_haptic_capable al_is_haptic_capable;

		pal_set_haptic_gain al_set_haptic_gain;
		pal_get_haptic_gain al_get_haptic_gain;

		pal_set_haptic_autocenter al_set_haptic_autocenter;
		pal_get_haptic_autocenter al_get_haptic_autocenter;

		pal_get_max_haptic_effects al_get_max_haptic_effects;
		pal_is_haptic_effect_ok al_is_haptic_effect_ok;
		pal_upload_haptic_effect al_upload_haptic_effect;
		pal_play_haptic_effect al_play_haptic_effect;
		pal_upload_and_play_haptic_effect al_upload_and_play_haptic_effect;
		pal_stop_haptic_effect al_stop_haptic_effect;
		pal_is_haptic_effect_playing al_is_haptic_effect_playing;
		pal_release_haptic_effect al_release_haptic_effect;
		pal_get_haptic_effect_duration al_get_haptic_effect_duration;
		pal_rumble_haptic al_rumble_haptic;
	}
}
