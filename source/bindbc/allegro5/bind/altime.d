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
	extern(C) @nogc nothrow {
		alias pal_get_time = double function();
		alias pal_rest = void function(double seconds);
		alias pal_init_timeout = void function(ALLEGRO_TIMEOUT* timeout, double seconds);
	}

	__gshared {
		pal_get_time al_get_time;
		pal_rest al_rest;
		pal_init_timeout al_init_timeout;
	}
}
