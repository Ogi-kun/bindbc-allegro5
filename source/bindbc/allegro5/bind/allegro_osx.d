module bindbc.allegro5.bind.allegro_osx;

import bindbc.allegro5.config;

version (OSX):

extern (Objective-C)
extern class NSWindow {}

static if (staticBinding) {
	NSWindow al_osx_get_window(ALLEGRO_DISPLAY* d);
}
else {
	extern(C) @nogc nothrow {
		alias pal_osx_get_window = NSWindow function(ALLEGRO_DISPLAY* d);
	}
	
	__gshared {
		pal_osx_get_window al_osx_get_window;
	}
}

