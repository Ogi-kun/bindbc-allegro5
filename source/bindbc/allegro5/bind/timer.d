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
	pragma(inline, true) extern(C) @nogc nothrow:
	ALLEGRO_TIMER* al_create_timer(double speed_secs) => ptr_al_create_timer(speed_secs);
	void al_destroy_timer(ALLEGRO_TIMER* timer) => ptr_al_destroy_timer(timer);
	void al_start_timer(ALLEGRO_TIMER* timer) => ptr_al_start_timer(timer);
	void al_stop_timer(ALLEGRO_TIMER* timer) => ptr_al_stop_timer(timer);
	void al_resume_timer(ALLEGRO_TIMER* timer) => ptr_al_resume_timer(timer);
	bool al_get_timer_started(const(ALLEGRO_TIMER)* timer) => ptr_al_get_timer_started(timer);
	double al_get_timer_speed(const(ALLEGRO_TIMER)* timer) => ptr_al_get_timer_speed(timer);
	void al_set_timer_speed(ALLEGRO_TIMER* timer, double speed_secs) => ptr_al_set_timer_speed(timer, speed_secs);
	long al_get_timer_count(const(ALLEGRO_TIMER)* timer) => ptr_al_get_timer_count(timer);
	void al_set_timer_count(ALLEGRO_TIMER* timer, long count) => ptr_al_set_timer_count(timer, count);
	void al_add_timer_count(ALLEGRO_TIMER* timer, long diff) => ptr_al_add_timer_count(timer, diff);
	ALLEGRO_EVENT_SOURCE* al_get_timer_event_source(ALLEGRO_TIMER* timer) => ptr_al_get_timer_event_source(timer);
	package(bindbc.allegro5) __gshared {
		typeof(&al_create_timer) ptr_al_create_timer;
		typeof(&al_destroy_timer) ptr_al_destroy_timer;
		typeof(&al_start_timer) ptr_al_start_timer;
		typeof(&al_stop_timer) ptr_al_stop_timer;
		typeof(&al_resume_timer) ptr_al_resume_timer;
		typeof(&al_get_timer_started) ptr_al_get_timer_started;
		typeof(&al_get_timer_speed) ptr_al_get_timer_speed;
		typeof(&al_set_timer_speed) ptr_al_set_timer_speed;
		typeof(&al_get_timer_count) ptr_al_get_timer_count;
		typeof(&al_set_timer_count) ptr_al_set_timer_count;
		typeof(&al_add_timer_count) ptr_al_add_timer_count;
		typeof(&al_get_timer_event_source) ptr_al_get_timer_event_source;
	}
}
