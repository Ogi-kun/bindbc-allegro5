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
	extern(C) @nogc nothrow {
		alias pal_iphone_set_statusbar_orientation = void function(int orientation);
		alias pal_iphone_get_last_shake_time = double function();
		alias pal_iphone_get_battery_level = float function();
	}

	__gshared {
		pal_iphone_set_statusbar_orientation al_iphone_set_statusbar_orientation;
		pal_iphone_get_last_shake_time al_iphone_get_last_shake_time;
		pal_iphone_get_battery_level al_iphone_get_battery_level;
	}
}

