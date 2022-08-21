module bindbc.allegro5.bind.base;

import bindbc.allegro5.config;
//import bindbc.allegro5.bind.internal.alconfig;

enum ALLEGRO_VERSION     = 5;
enum ALLEGRO_SUB_VERSION = 2;

/* BetterC disallows converting integers to strings at compile time.
*  The workaround is to define everything as strings and mixin when you need integers
*/ 

version (Allegro_5_2_8) {
	private enum _ALLEGRO_WIP_VERSION_STR = "8";
	private enum _ALLEGRO_DATE_STR = "20220605";
}
version (Allegro_5_2_7) {
	private enum _ALLEGRO_WIP_VERSION_STR = "7";
	private enum _ALLEGRO_DATE_STR = "20210307";
}
version (Allegro_5_2_6) {
	private enum _ALLEGRO_WIP_VERSION_STR = "6";
	private enum _ALLEGRO_DATE_STR = "20200207";
}
version (Allegro_5_2_5) {
	private enum _ALLEGRO_WIP_VERSION_STR = "5";
	private enum _ALLEGRO_DATE_STR = "20190224";
}
version (Allegro_5_2_4) {
	private enum _ALLEGRO_WIP_VERSION_STR = "4";
	private enum _ALLEGRO_DATE_STR = "20180224";
}
version (Allegro_5_2_3) {
	private enum _ALLEGRO_WIP_VERSION_STR = "3";
	private enum _ALLEGRO_DATE_STR = "20171008";
}
version (Allegro_5_2_2) {
	private enum _ALLEGRO_WIP_VERSION_STR = "2";
	private enum _ALLEGRO_DATE_STR = "20161211";
}
version (Allegro_5_2_1) {
	private enum _ALLEGRO_WIP_VERSION_STR = "1";
	private enum _ALLEGRO_DATE_STR = "20160813";
}
else {
	private enum _ALLEGRO_WIP_VERSION_STR = "0";
	private enum _ALLEGRO_DATE_STR = "20160401";
}

enum ALLEGRO_WIP_VERSION = mixin(_ALLEGRO_WIP_VERSION_STR);

version (ALLEGRO_UNSTABLE) {
	enum ALLEGRO_UNSTABLE_BIT = 1 << 31;
}
else {
	enum ALLEGRO_UNSTABLE_BIT = 0;
}

enum ALLEGRO_RELEASE_NUMBER = 1;

enum ALLEGRO_VERSION_STR = "5.2."~_ALLEGRO_WIP_VERSION_STR;

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
