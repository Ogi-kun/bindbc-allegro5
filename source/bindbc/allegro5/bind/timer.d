module bindbc.allegro5.bind.timer;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.events : ALLEGRO_EVENT_SOURCE;

extern(C) @nogc nothrow {
	double ALLEGRO_USECS_TO_SECS(double x) {
		return x / 1000000.0;
	}
	double ALLEGRO_MSECS_TO_SECS(double x) {
		return x / 1000.0;
	}
	double ALLEGRO_BPS_TO_SECS(double x) {
		return 1.0 / x;
	}
	double ALLEGRO_BPM_TO_SECS(double x) {
		return 60.0 / x;
	}
}

struct ALLEGRO_TIMER;


static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_TIMER* al_create_timer(double speed_secs);
	void al_destroy_timer(ALLEGRO_TIMER* timer);
	void al_start_timer(ALLEGRO_TIMER* timer);
	void al_stop_timer(ALLEGRO_TIMER* timer);
	void al_resume_timer(ALLEGRO_TIMER* timer);
	bool al_get_timer_started(const(ALLEGRO_TIMER)* timer);
	double al_get_timer_speed(const(ALLEGRO_TIMER)* timer);
	void al_set_timer_speed(ALLEGRO_TIMER* timer, double speed_secs);
	long al_get_timer_count(const(ALLEGRO_TIMER)* timer);
	void al_set_timer_count(ALLEGRO_TIMER* timer, long count);
	void al_add_timer_count(ALLEGRO_TIMER* timer, long diff);
	ALLEGRO_EVENT_SOURCE* al_get_timer_event_source(ALLEGRO_TIMER* timer);
}
else {
	extern(C) @nogc nothrow {
		alias pal_create_timer = ALLEGRO_TIMER* function(double speed_secs);
		alias pal_destroy_timer = void function(ALLEGRO_TIMER* timer);
		alias pal_start_timer = void function(ALLEGRO_TIMER* timer);
		alias pal_stop_timer = void function(ALLEGRO_TIMER* timer);
		alias pal_resume_timer = void function(ALLEGRO_TIMER* timer);
		alias pal_get_timer_started = bool function(const(ALLEGRO_TIMER)* timer);
		alias pal_get_timer_speed = double function(const(ALLEGRO_TIMER)* timer);
		alias pal_set_timer_speed = void function(ALLEGRO_TIMER* timer, double speed_secs);
		alias pal_get_timer_count = long function(const(ALLEGRO_TIMER)* timer);
		alias pal_set_timer_count = void function(ALLEGRO_TIMER* timer, long count);
		alias pal_add_timer_count = void function(ALLEGRO_TIMER* timer, long diff);
		alias pal_get_timer_event_source = ALLEGRO_EVENT_SOURCE* function(ALLEGRO_TIMER* timer);
	}
	__gshared {
		pal_create_timer al_create_timer;
		pal_destroy_timer al_destroy_timer;
		pal_start_timer al_start_timer;
		pal_stop_timer al_stop_timer;
		pal_resume_timer al_resume_timer;
		pal_get_timer_started al_get_timer_started;
		pal_get_timer_speed al_get_timer_speed;
		pal_set_timer_speed al_set_timer_speed;
		pal_get_timer_count al_get_timer_count;
		pal_set_timer_count al_set_timer_count;
		pal_add_timer_count al_add_timer_count;
		pal_get_timer_event_source al_get_timer_event_source;
	}
}
