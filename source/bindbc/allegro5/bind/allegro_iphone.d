module bindbc.allegro5.bind.allegro_iphone;

import bindbc.allegro5.config;

version (iOS):

enum ALLEGRO_IPHONE_STATUSBAR_ORIENTATION {
	ALLEGRO_IPHONE_STATUSBAR_ORIENTATION_PORTRAIT = 0,
	ALLEGRO_IPHONE_STATUSBAR_ORIENTATION_PORTRAIT_UPSIDE_DOWN,
	ALLEGRO_IPHONE_STATUSBAR_ORIENTATION_LANDSCAPE_RIGHT,
	ALLEGRO_IPHONE_STATUSBAR_ORIENTATION_LANDSCAPE_LEFT
}
mixin ExpandEnum!ALLEGRO_IPHONE_STATUSBAR_ORIENTATION;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	void al_iphone_set_statusbar_orientation(int orientation);
	double al_iphone_get_last_shake_time();
	float al_iphone_get_battery_level();
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	void al_iphone_set_statusbar_orientation(int orientation) => ptr_al_iphone_set_statusbar_orientation(orientation);
	double al_iphone_get_last_shake_time() => ptr_al_iphone_get_last_shake_time();
	float al_iphone_get_battery_level() => ptr_al_iphone_get_battery_level();
	package(bindbc.allegro5) __gshared {
		typeof(&al_iphone_set_statusbar_orientation) ptr_al_iphone_set_statusbar_orientation;
		typeof(&al_iphone_get_last_shake_time) ptr_al_iphone_get_last_shake_time;
		typeof(&al_iphone_get_battery_level) ptr_al_iphone_get_battery_level;
	}
}
