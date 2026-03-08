module bindbc.allegro5.bind.altime;

import bindbc.allegro5.config;

struct ALLEGRO_TIMEOUT {
	ulong __pad1__;
	ulong __pad2__;
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	double al_get_time();
	void al_rest(double seconds);
	void al_init_timeout(ALLEGRO_TIMEOUT* timeout, double seconds);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	double al_get_time() => ptr_al_get_time();
	void al_rest(double seconds) => ptr_al_rest(seconds);
	void al_init_timeout(ALLEGRO_TIMEOUT* timeout, double seconds) => ptr_al_init_timeout(timeout, seconds);
	package(bindbc.allegro5) __gshared {
		typeof(&al_get_time) ptr_al_get_time;
		typeof(&al_rest) ptr_al_rest;
		typeof(&al_init_timeout) ptr_al_init_timeout;
	}
}
