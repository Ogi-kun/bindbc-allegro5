module bindbc.allegro5.bind.base;

import bindbc.allegro5.config;
//import bindbc.allegro5.bind.internal.alconfig;

enum ALLEGRO_VERSION     = 5;
enum ALLEGRO_SUB_VERSION = 2;

/* BetterC disallows converting integers to strings at compile time.
*  The workaround is to define everything as strings and mixin when you need integers
*/ 

private enum _ALLEGRO_WIP_VERSION_STR = "8";

enum ALLEGRO_WIP_VERSION = mixin(_ALLEGRO_WIP_VERSION_STR);

version (ALLEGRO_UNSTABLE) {
	enum ALLEGRO_UNSTABLE_BIT = 1 << 31;
}
else {
	enum ALLEGRO_UNSTABLE_BIT = 0;
}

enum ALLEGRO_RELEASE_NUMBER = 1;

enum ALLEGRO_VERSION_STR = "5.2."~_ALLEGRO_WIP_VERSION_STR;

private enum _ALLEGRO_DATE_STR = "20220605";

enum ALLEGRO_DATE = mixin(_ALLEGRO_DATE_STR);

enum ALLEGRO_DATE_STR = _ALLEGRO_DATE_STR[0..4];

enum ALLEGRO_VERSION_INT =
		 (ALLEGRO_VERSION << 24) 
		| (ALLEGRO_SUB_VERSION << 16) 
		| (ALLEGRO_WIP_VERSION << 8) 
		| ALLEGRO_RELEASE_NUMBER 
		| ALLEGRO_UNSTABLE_BIT;
		
enum ALLEGRO_PI = 3.14159265358979323846;

extern(C) uint AL_ID(char a, char b, char c, char d) @nogc nothrow {
	return (a<<24) | (b<<16) | (c<<8) | d;
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	uint al_get_allegro_version();
	int al_run_main(int argc, char** argv, int function(int, char**) user_main);
}
else {
	extern(C) @nogc nothrow {
		alias pal_get_allegro_version = uint function();
		alias pal_run_main = int function(int argc, char** argv, int function(int, char**) user_main);
	}
	__gshared {
		pal_get_allegro_version al_get_allegro_version;
		pal_run_main al_run_main;
	}
}
