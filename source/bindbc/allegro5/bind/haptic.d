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

	bool al_is_mouse_haptic(ALLEGRO_MOUSE* mouse);
	bool al_is_joystick_haptic(ALLEGRO_JOYSTICK* joystick);
	bool al_is_keyboard_haptic(ALLEGRO_KEYBOARD* keyboard);
	bool al_is_display_haptic(ALLEGRO_DISPLAY* display);
	bool al_is_touch_input_haptic(ALLEGRO_TOUCH_INPUT* touch_input);

	ALLEGRO_HAPTIC* al_get_haptic_from_mouse(ALLEGRO_MOUSE* mouse);
	ALLEGRO_HAPTIC* al_get_haptic_from_joystick(ALLEGRO_JOYSTICK* joystick);
	ALLEGRO_HAPTIC* al_get_haptic_from_keyboard(ALLEGRO_KEYBOARD* keyboard);
	ALLEGRO_HAPTIC* al_get_haptic_from_display(ALLEGRO_DISPLAY* display);
	ALLEGRO_HAPTIC* al_get_haptic_from_touch_input(ALLEGRO_TOUCH_INPUT* touch_input);

	bool al_release_haptic(ALLEGRO_HAPTIC* haptic);

	bool al_is_haptic_active(ALLEGRO_HAPTIC* haptic);
	int al_get_haptic_capabilities(ALLEGRO_HAPTIC* haptic);
	bool al_is_haptic_capable(ALLEGRO_HAPTIC* haptic, int query);

	bool al_set_haptic_gain(ALLEGRO_HAPTIC* haptic, double gain);
	double al_get_haptic_gain(ALLEGRO_HAPTIC* haptic);

	bool al_set_haptic_autocenter(ALLEGRO_HAPTIC* haptic, double intensity);
	double al_get_haptic_autocenter(ALLEGRO_HAPTIC* haptic);

	int al_get_max_haptic_effects(ALLEGRO_HAPTIC* haptic);
	bool al_is_haptic_effect_ok(ALLEGRO_HAPTIC* haptic, ALLEGRO_HAPTIC_EFFECT* effect);
	bool al_upload_haptic_effect(ALLEGRO_HAPTIC* haptic, ALLEGRO_HAPTIC_EFFECT* effect, ALLEGRO_HAPTIC_EFFECT_ID* id);
	bool al_play_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID* id, int loop);
	bool al_upload_and_play_haptic_effect(ALLEGRO_HAPTIC* haptic, ALLEGRO_HAPTIC_EFFECT* effect, ALLEGRO_HAPTIC_EFFECT_ID* id, int loop);
	bool al_stop_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID* id);
	bool al_is_haptic_effect_playing(ALLEGRO_HAPTIC_EFFECT_ID* id);
	bool al_release_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID* id);
	double al_get_haptic_effect_duration(ALLEGRO_HAPTIC_EFFECT* effect);
	bool al_rumble_haptic(ALLEGRO_HAPTIC* haptic, double intensity, double duration, ALLEGRO_HAPTIC_EFFECT_ID* id);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	bool al_install_haptic() => ptr_al_install_haptic();
	void al_uninstall_haptic() => ptr_al_uninstall_haptic();
	bool al_is_haptic_installed() => ptr_al_is_haptic_installed();

	bool al_is_mouse_haptic(ALLEGRO_MOUSE* mouse) => ptr_al_is_mouse_haptic(mouse);
	bool al_is_joystick_haptic(ALLEGRO_JOYSTICK* joystick) => ptr_al_is_joystick_haptic(joystick);
	bool al_is_keyboard_haptic(ALLEGRO_KEYBOARD* keyboard) => ptr_al_is_keyboard_haptic(keyboard);
	bool al_is_display_haptic(ALLEGRO_DISPLAY* display) => ptr_al_is_display_haptic(display);
	bool al_is_touch_input_haptic(ALLEGRO_TOUCH_INPUT* touch_input) => ptr_al_is_touch_input_haptic(touch_input);

	ALLEGRO_HAPTIC* al_get_haptic_from_mouse(ALLEGRO_MOUSE* mouse) => ptr_al_get_haptic_from_mouse(mouse);
	ALLEGRO_HAPTIC* al_get_haptic_from_joystick(ALLEGRO_JOYSTICK* joystick) => ptr_al_get_haptic_from_joystick(joystick);
	ALLEGRO_HAPTIC* al_get_haptic_from_keyboard(ALLEGRO_KEYBOARD* keyboard) => ptr_al_get_haptic_from_keyboard(keyboard);
	ALLEGRO_HAPTIC* al_get_haptic_from_display(ALLEGRO_DISPLAY* display) => ptr_al_get_haptic_from_display(display);
	ALLEGRO_HAPTIC* al_get_haptic_from_touch_input(ALLEGRO_TOUCH_INPUT* touch_input) => ptr_al_get_haptic_from_touch_input(touch_input);

	bool al_release_haptic(ALLEGRO_HAPTIC* haptic) => ptr_al_release_haptic(haptic);

	bool al_is_haptic_active(ALLEGRO_HAPTIC* haptic) => ptr_al_is_haptic_active(haptic);
	int al_get_haptic_capabilities(ALLEGRO_HAPTIC* haptic) => ptr_al_get_haptic_capabilities(haptic);
	bool al_is_haptic_capable(ALLEGRO_HAPTIC* haptic, int query) => ptr_al_is_haptic_capable(haptic, query);

	bool al_set_haptic_gain(ALLEGRO_HAPTIC* haptic, double gain) => ptr_al_set_haptic_gain(haptic, gain);
	double al_get_haptic_gain(ALLEGRO_HAPTIC* haptic) => ptr_al_get_haptic_gain(haptic);

	bool al_set_haptic_autocenter(ALLEGRO_HAPTIC* haptic, double intensity) => ptr_al_set_haptic_autocenter(haptic, intensity);
	double al_get_haptic_autocenter(ALLEGRO_HAPTIC* haptic) => ptr_al_get_haptic_autocenter(haptic);

	int al_get_max_haptic_effects(ALLEGRO_HAPTIC* haptic) => ptr_al_get_max_haptic_effects(haptic);
	bool al_is_haptic_effect_ok(ALLEGRO_HAPTIC* haptic, ALLEGRO_HAPTIC_EFFECT* effect) => ptr_al_is_haptic_effect_ok(haptic, effect);
	bool al_upload_haptic_effect(ALLEGRO_HAPTIC* haptic, ALLEGRO_HAPTIC_EFFECT* effect, ALLEGRO_HAPTIC_EFFECT_ID* id) => ptr_al_upload_haptic_effect(haptic, effect, id);
	bool al_play_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID* id, int loop) => ptr_al_play_haptic_effect(id, loop);
	bool al_upload_and_play_haptic_effect(ALLEGRO_HAPTIC* haptic, ALLEGRO_HAPTIC_EFFECT* effect, ALLEGRO_HAPTIC_EFFECT_ID* id, int loop) => ptr_al_upload_and_play_haptic_effect(haptic, effect, id, loop);
	bool al_stop_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID* id) => ptr_al_stop_haptic_effect(id);
	bool al_is_haptic_effect_playing(ALLEGRO_HAPTIC_EFFECT_ID* id) => ptr_al_is_haptic_effect_playing(id);
	bool al_release_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID* id) => ptr_al_release_haptic_effect(id);
	double al_get_haptic_effect_duration(ALLEGRO_HAPTIC_EFFECT* effect) => ptr_al_get_haptic_effect_duration(effect);
	bool al_rumble_haptic(ALLEGRO_HAPTIC* haptic, double intensity, double duration, ALLEGRO_HAPTIC_EFFECT_ID* id) => ptr_al_rumble_haptic(haptic, intensity, duration, id);

	package(bindbc.allegro5) __gshared {
		typeof(&al_install_haptic) ptr_al_install_haptic;
		typeof(&al_uninstall_haptic) ptr_al_uninstall_haptic;
		typeof(&al_is_haptic_installed) ptr_al_is_haptic_installed;

		typeof(&al_is_mouse_haptic) ptr_al_is_mouse_haptic;
		typeof(&al_is_joystick_haptic) ptr_al_is_joystick_haptic;
		typeof(&al_is_keyboard_haptic) ptr_al_is_keyboard_haptic;
		typeof(&al_is_display_haptic) ptr_al_is_display_haptic;
		typeof(&al_is_touch_input_haptic) ptr_al_is_touch_input_haptic;

		typeof(&al_get_haptic_from_mouse) ptr_al_get_haptic_from_mouse;
		typeof(&al_get_haptic_from_joystick) ptr_al_get_haptic_from_joystick;
		typeof(&al_get_haptic_from_keyboard) ptr_al_get_haptic_from_keyboard;
		typeof(&al_get_haptic_from_display) ptr_al_get_haptic_from_display;
		typeof(&al_get_haptic_from_touch_input) ptr_al_get_haptic_from_touch_input;

		typeof(&al_release_haptic) ptr_al_release_haptic;

		typeof(&al_is_haptic_active) ptr_al_is_haptic_active;
		typeof(&al_get_haptic_capabilities) ptr_al_get_haptic_capabilities;
		typeof(&al_is_haptic_capable) ptr_al_is_haptic_capable;

		typeof(&al_set_haptic_gain) ptr_al_set_haptic_gain;
		typeof(&al_get_haptic_gain) ptr_al_get_haptic_gain;

		typeof(&al_set_haptic_autocenter) ptr_al_set_haptic_autocenter;
		typeof(&al_get_haptic_autocenter) ptr_al_get_haptic_autocenter;

		typeof(&al_get_max_haptic_effects) ptr_al_get_max_haptic_effects;
		typeof(&al_is_haptic_effect_ok) ptr_al_is_haptic_effect_ok;
		typeof(&al_upload_haptic_effect) ptr_al_upload_haptic_effect;
		typeof(&al_play_haptic_effect) ptr_al_play_haptic_effect;
		typeof(&al_upload_and_play_haptic_effect) ptr_al_upload_and_play_haptic_effect;
		typeof(&al_stop_haptic_effect) ptr_al_stop_haptic_effect;
		typeof(&al_is_haptic_effect_playing) ptr_al_is_haptic_effect_playing;
		typeof(&al_release_haptic_effect) ptr_al_release_haptic_effect;
		typeof(&al_get_haptic_effect_duration) ptr_al_get_haptic_effect_duration;
		typeof(&al_rumble_haptic) ptr_al_rumble_haptic;
	}
}
