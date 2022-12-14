module bindbc.allegro5.bind.mouse_cursor;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;

struct ALLEGRO_MOUSE_CURSOR;

enum ALLEGRO_SYSTEM_MOUSE_CURSOR {
	ALLEGRO_SYSTEM_MOUSE_CURSOR_NONE        =  0,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_DEFAULT     =  1,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_ARROW       =  2,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_BUSY        =  3,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_QUESTION    =  4,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_EDIT        =  5,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_MOVE        =  6,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_N    =  7,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_W    =  8,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_S    =  9,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_E    = 10,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NW   = 11,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SW   = 12,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SE   = 13,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NE   = 14,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_PROGRESS    = 15,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_PRECISION   = 16,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_LINK        = 17,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_ALT_SELECT  = 18,
	ALLEGRO_SYSTEM_MOUSE_CURSOR_UNAVAILABLE = 19,
	ALLEGRO_NUM_SYSTEM_MOUSE_CURSORS
}
mixin ExpandEnum!ALLEGRO_SYSTEM_MOUSE_CURSOR;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_MOUSE_CURSOR* al_create_mouse_cursor(ALLEGRO_BITMAP* sprite, int xfocus, int yfocus);
	void al_destroy_mouse_cursor(ALLEGRO_MOUSE_CURSOR*);
	bool al_set_mouse_cursor(ALLEGRO_DISPLAY* display, ALLEGRO_MOUSE_CURSOR* cursor);
	bool al_set_system_mouse_cursor(ALLEGRO_DISPLAY* display, ALLEGRO_SYSTEM_MOUSE_CURSOR cursor_id);
	bool al_show_mouse_cursor(ALLEGRO_DISPLAY* display);
	bool al_hide_mouse_cursor(ALLEGRO_DISPLAY* display);
}
else {
	extern(C) @nogc nothrow {
		alias pal_create_mouse_cursor = ALLEGRO_MOUSE_CURSOR* function(ALLEGRO_BITMAP* sprite, int xfocus, int yfocus);
		alias pal_destroy_mouse_cursor = void function(ALLEGRO_MOUSE_CURSOR*);
		alias pal_set_mouse_cursor = bool function(ALLEGRO_DISPLAY* display, ALLEGRO_MOUSE_CURSOR* cursor);
		alias pal_set_system_mouse_cursor = bool function(ALLEGRO_DISPLAY* display, ALLEGRO_SYSTEM_MOUSE_CURSOR cursor_id);
		alias pal_show_mouse_cursor = bool function(ALLEGRO_DISPLAY* display);
		alias pal_hide_mouse_cursor = bool function(ALLEGRO_DISPLAY* display);
	}
	__gshared {
		pal_create_mouse_cursor al_create_mouse_cursor;
		pal_destroy_mouse_cursor al_destroy_mouse_cursor;
		pal_set_mouse_cursor al_set_mouse_cursor;
		pal_set_system_mouse_cursor al_set_system_mouse_cursor;
		pal_show_mouse_cursor al_show_mouse_cursor;
		pal_hide_mouse_cursor al_hide_mouse_cursor;
	}
}
