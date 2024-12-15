module bindbc.allegro5.bind.allegro_iphone_objc;

import bindbc.allegro5.config;

version (iOS):

import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;
import core.attribute : selector;

extern (Objective-C) {
	extern class UIWindow {}
	extern class UIView {}
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	UIWindow al_iphone_get_window(ALLEGRO_DISPLAY *d);
	UIView al_iphone_get_view(ALLEGRO_DISPLAY *d);
}
else {
	extern(C) @nogc nothrow {
		alias pal_iphone_get_window = UIWindow function(ALLEGRO_DISPLAY *d);
		alias pal_iphone_get_view = UIView function(ALLEGRO_DISPLAY *d);
	}

	__gshared {
		pal_iphone_get_window al_iphone_get_window;
		pal_iphone_get_view al_iphone_get_view;
	}
}
