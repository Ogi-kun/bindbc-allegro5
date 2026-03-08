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
	pragma(inline, true) extern(C) @nogc nothrow:
	UIWindow al_iphone_get_window(ALLEGRO_DISPLAY *d) => ptr_al_iphone_get_window(d);
	UIView al_iphone_get_view(ALLEGRO_DISPLAY *d) => ptr_al_iphone_get_view(d);
	package(bindbc.allegro5) __gshared {
		typeof(&al_iphone_get_window) ptr_al_iphone_get_window;
		typeof(&al_iphone_get_view) ptr_al_iphone_get_view;
	}
}
