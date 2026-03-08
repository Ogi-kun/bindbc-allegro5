module bindbc.allegro5.bind.allegro_osx;

import bindbc.allegro5.config;

version (OSX):

import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;

extern (Objective-C)
extern class NSWindow {}

static if (staticBinding) {
	NSWindow al_osx_get_window(ALLEGRO_DISPLAY* d);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	NSWindow al_osx_get_window(ALLEGRO_DISPLAY* d) => ptr_al_osx_get_window(d);
	package(bindbc.allegro5) __gshared {
		typeof(&al_osx_get_window) ptr_al_osx_get_window;
	}
}
