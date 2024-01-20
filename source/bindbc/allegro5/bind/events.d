module bindbc.allegro5.bind.events;

import core.stdc.stdint : intptr_t;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.altime;
import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;
import bindbc.allegro5.bind.base : AL_ID;

alias ALLEGRO_EVENT_TYPE = uint;

enum {
	ALLEGRO_EVENT_JOYSTICK_AXIS               =  1,
	ALLEGRO_EVENT_JOYSTICK_BUTTON_DOWN        =  2,
	ALLEGRO_EVENT_JOYSTICK_BUTTON_UP          =  3,
	ALLEGRO_EVENT_JOYSTICK_CONFIGURATION      =  4,

	ALLEGRO_EVENT_KEY_DOWN                    = 10,
	ALLEGRO_EVENT_KEY_CHAR                    = 11,
	ALLEGRO_EVENT_KEY_UP                      = 12,

	ALLEGRO_EVENT_MOUSE_AXES                  = 20,
	ALLEGRO_EVENT_MOUSE_BUTTON_DOWN           = 21,
	ALLEGRO_EVENT_MOUSE_BUTTON_UP             = 22,
	ALLEGRO_EVENT_MOUSE_ENTER_DISPLAY         = 23,
	ALLEGRO_EVENT_MOUSE_LEAVE_DISPLAY         = 24,
	ALLEGRO_EVENT_MOUSE_WARPED                = 25,

	ALLEGRO_EVENT_TIMER                       = 30,

	ALLEGRO_EVENT_DISPLAY_EXPOSE              = 40,
	ALLEGRO_EVENT_DISPLAY_RESIZE              = 41,
	ALLEGRO_EVENT_DISPLAY_CLOSE               = 42,
	ALLEGRO_EVENT_DISPLAY_LOST                = 43,
	ALLEGRO_EVENT_DISPLAY_FOUND               = 44,
	ALLEGRO_EVENT_DISPLAY_SWITCH_IN           = 45,
	ALLEGRO_EVENT_DISPLAY_SWITCH_OUT          = 46,
	ALLEGRO_EVENT_DISPLAY_ORIENTATION         = 47,
	ALLEGRO_EVENT_DISPLAY_HALT_DRAWING        = 48,
	ALLEGRO_EVENT_DISPLAY_RESUME_DRAWING      = 49,

	ALLEGRO_EVENT_TOUCH_BEGIN                 = 50,
	ALLEGRO_EVENT_TOUCH_END                   = 51,
	ALLEGRO_EVENT_TOUCH_MOVE                  = 52,
	ALLEGRO_EVENT_TOUCH_CANCEL                = 53,

	ALLEGRO_EVENT_DISPLAY_CONNECTED           = 60,
	ALLEGRO_EVENT_DISPLAY_DISCONNECTED        = 61,
}
static if (allegroSupport >= AllegroSupport.v5_2_9) {
	enum ALLEGRO_EVENT_DROP                   = 62;
}

@nogc nothrow {
	bool ALLEGRO_EVENT_TYPE_IS_USER(ALLEGRO_EVENT_TYPE t) {
		return t >= 512;
	}
	
	ALLEGRO_EVENT_TYPE ALLEGRO_GET_EVENT_TYPE(char a, char b, char c, char d) {
		return AL_ID(a, b, c, d);
	}
}


struct ALLEGRO_EVENT_SOURCE {
	int[32] __pad;
}


mixin template _AL_EVENT_HEADER(Src) {
	ALLEGRO_EVENT_TYPE type; 
	Src* source;
	double timestamp;
}

struct ALLEGRO_ANY_EVENT {
	mixin _AL_EVENT_HEADER!ALLEGRO_EVENT_SOURCE;
}

struct ALLEGRO_DISPLAY_EVENT {
	mixin _AL_EVENT_HEADER!ALLEGRO_DISPLAY;
	int x, y;
	int width, height;
	int orientation;
}

struct ALLEGRO_JOYSTICK_EVENT {
	import bindbc.allegro5.bind.joystick : ALLEGRO_JOYSTICK;
	mixin _AL_EVENT_HEADER!ALLEGRO_JOYSTICK;
	ALLEGRO_JOYSTICK* id;
	int stick;
	int axis;
	float pos;
	int button;
}

struct ALLEGRO_KEYBOARD_EVENT {
	import bindbc.allegro5.bind.keyboard : ALLEGRO_KEYBOARD;
	mixin _AL_EVENT_HEADER!ALLEGRO_KEYBOARD;
	ALLEGRO_DISPLAY* display;
	int keycode;
	int unichar;
	uint modifiers;
	bool repeat;
}

struct ALLEGRO_MOUSE_EVENT {
	import bindbc.allegro5.bind.mouse : ALLEGRO_MOUSE;
	mixin _AL_EVENT_HEADER!ALLEGRO_MOUSE;
	ALLEGRO_DISPLAY* display;
	int x, y, z, w;
	int dx, dy, dz, dw;
	uint button;
	float pressure;
}

struct ALLEGRO_TIMER_EVENT {
	import bindbc.allegro5.bind.timer : ALLEGRO_TIMER;
	mixin _AL_EVENT_HEADER!ALLEGRO_TIMER;
	long count;
	double error;
}

struct ALLEGRO_TOUCH_EVENT {
	import bindbc.allegro5.bind.touch_input : ALLEGRO_TOUCH_INPUT;
	mixin _AL_EVENT_HEADER!ALLEGRO_TOUCH_INPUT;
	ALLEGRO_DISPLAY* display;
	int id;
	float x, y;
	float dx, dy;
	bool primary;
}

struct ALLEGRO_USER_EVENT_DESCRIPTOR;

struct ALLEGRO_USER_EVENT {
	mixin _AL_EVENT_HEADER!ALLEGRO_EVENT_SOURCE;
	ALLEGRO_USER_EVENT_DESCRIPTOR* __internal__descr;
	intptr_t data1;
	intptr_t data2;
	intptr_t data3;
	intptr_t data4;
}

static if (allegroSupport >= AllegroSupport.v5_2_9) {
	struct ALLEGRO_DROP_EVENT {
		mixin _AL_EVENT_HEADER!ALLEGRO_DISPLAY;
		int x, y;
		int row;
		bool is_file;
		char *text;
		bool is_complete;
	}
}

union ALLEGRO_EVENT {
	ALLEGRO_EVENT_TYPE     type;
	ALLEGRO_ANY_EVENT      any;
	ALLEGRO_DISPLAY_EVENT  display;
	ALLEGRO_JOYSTICK_EVENT joystick;
	ALLEGRO_KEYBOARD_EVENT keyboard;
	ALLEGRO_MOUSE_EVENT    mouse;
	ALLEGRO_TIMER_EVENT    timer;
	ALLEGRO_TOUCH_EVENT    touch;
	ALLEGRO_USER_EVENT     user;
	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		ALLEGRO_DROP_EVENT drop;
	}
}

struct ALLEGRO_EVENT_QUEUE;

extern(C) @nogc nothrow {
	alias al_user_event_dtor = void function(ALLEGRO_USER_EVENT*);
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	void al_init_user_event_source(ALLEGRO_EVENT_SOURCE*);
	void al_destroy_user_event_source(ALLEGRO_EVENT_SOURCE*);
	bool al_emit_user_event(ALLEGRO_EVENT_SOURCE*, ALLEGRO_EVENT*, al_user_event_dtor dtor);
	void al_unref_user_event(ALLEGRO_USER_EVENT*);
	void al_set_event_source_data(ALLEGRO_EVENT_SOURCE*, intptr_t data);
	intptr_t al_get_event_source_data(const(ALLEGRO_EVENT_SOURCE)*);

	ALLEGRO_EVENT_QUEUE* al_create_event_queue();
	void al_destroy_event_queue(ALLEGRO_EVENT_QUEUE*);
	bool al_is_event_source_registered(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT_SOURCE*);
	void al_register_event_source(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT_SOURCE*);
	void al_unregister_event_source(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT_SOURCE*);
	void al_pause_event_queue(ALLEGRO_EVENT_QUEUE*, bool);
	bool al_is_event_queue_paused(const(ALLEGRO_EVENT_QUEUE)*);
	bool al_is_event_queue_empty(ALLEGRO_EVENT_QUEUE*);
	bool al_get_next_event(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event);
	bool al_peek_next_event(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event);
	bool al_drop_next_event(ALLEGRO_EVENT_QUEUE*);
	void al_flush_event_queue(ALLEGRO_EVENT_QUEUE*);
	void al_wait_for_event(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event);
	bool al_wait_for_event_timed(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event, float secs);
	bool al_wait_for_event_until(ALLEGRO_EVENT_QUEUE* queue, ALLEGRO_EVENT* ret_event, ALLEGRO_TIMEOUT* timeout);
}
else {
	extern(C) @nogc nothrow {
		alias pal_init_user_event_source = void function(ALLEGRO_EVENT_SOURCE*);
		alias pal_destroy_user_event_source = void function(ALLEGRO_EVENT_SOURCE*);
		alias pal_emit_user_event = bool function(ALLEGRO_EVENT_SOURCE*, ALLEGRO_EVENT*, al_user_event_dtor dtor);
		alias pal_unref_user_event = void function(ALLEGRO_USER_EVENT*);
		alias pal_set_event_source_data = void function(ALLEGRO_EVENT_SOURCE*, intptr_t data);
		alias pal_get_event_source_data = intptr_t function(const(ALLEGRO_EVENT_SOURCE)*);

		alias pal_create_event_queue = ALLEGRO_EVENT_QUEUE* function();
		alias pal_destroy_event_queue = void function(ALLEGRO_EVENT_QUEUE*);
		alias pal_is_event_source_registered = bool function(ALLEGRO_EVENT_QUEUE* , ALLEGRO_EVENT_SOURCE*);
		alias pal_register_event_source = void function(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT_SOURCE*);
		alias pal_unregister_event_source = void function(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT_SOURCE*);
		alias pal_pause_event_queue = void function(ALLEGRO_EVENT_QUEUE*, bool);
		alias pal_is_event_queue_paused = bool function(const(ALLEGRO_EVENT_QUEUE)*);
		alias pal_is_event_queue_empty = bool function(ALLEGRO_EVENT_QUEUE*);
		alias pal_get_next_event = bool function(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event);
		alias pal_peek_next_event = bool function(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event);
		alias pal_drop_next_event = bool function(ALLEGRO_EVENT_QUEUE*);
		alias pal_flush_event_queue = void function(ALLEGRO_EVENT_QUEUE*);
		alias pal_wait_for_event = void function(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event);
		alias pal_wait_for_event_timed = bool function(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event, float secs);
		alias pal_wait_for_event_until = bool function(ALLEGRO_EVENT_QUEUE* queue, ALLEGRO_EVENT* ret_event, ALLEGRO_TIMEOUT* timeout);
	}
	__gshared {
		pal_init_user_event_source al_init_user_event_source;
		pal_destroy_user_event_source al_destroy_user_event_source;
		pal_emit_user_event al_emit_user_event;
		pal_unref_user_event al_unref_user_event;
		pal_set_event_source_data al_set_event_source_data;
		pal_get_event_source_data al_get_event_source_data;

		pal_create_event_queue al_create_event_queue;
		pal_destroy_event_queue al_destroy_event_queue;
		pal_is_event_source_registered al_is_event_source_registered;
		pal_register_event_source al_register_event_source;
		pal_unregister_event_source al_unregister_event_source;
		pal_pause_event_queue al_pause_event_queue;
		pal_is_event_queue_paused al_is_event_queue_paused;
		pal_is_event_queue_empty al_is_event_queue_empty;
		pal_get_next_event al_get_next_event;
		pal_peek_next_event al_peek_next_event;
		pal_drop_next_event al_drop_next_event;
		pal_flush_event_queue al_flush_event_queue;
		pal_wait_for_event al_wait_for_event;
		pal_wait_for_event_timed al_wait_for_event_timed;
		pal_wait_for_event_until al_wait_for_event_until;
	}
}
