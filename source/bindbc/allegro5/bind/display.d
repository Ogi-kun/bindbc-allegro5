module bindbc.allegro5.bind.display;

import bindbc.allegro5.config;

import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import bindbc.allegro5.bind.events : ALLEGRO_EVENT_SOURCE;

enum {
	ALLEGRO_WINDOWED                    = 1 << 0,
	ALLEGRO_FULLSCREEN                  = 1 << 1,
	ALLEGRO_OPENGL                      = 1 << 2,
	ALLEGRO_DIRECT3D_INTERNAL           = 1 << 3,
	ALLEGRO_RESIZABLE                   = 1 << 4,
	ALLEGRO_FRAMELESS                   = 1 << 5,
	ALLEGRO_NOFRAME                     = ALLEGRO_FRAMELESS,
	ALLEGRO_GENERATE_EXPOSE_EVENTS      = 1 << 6,
	ALLEGRO_OPENGL_3_0                  = 1 << 7,
	ALLEGRO_OPENGL_FORWARD_COMPATIBLE   = 1 << 8,
	ALLEGRO_FULLSCREEN_WINDOW           = 1 << 9,
	ALLEGRO_MINIMIZED                   = 1 << 10,
	ALLEGRO_PROGRAMMABLE_PIPELINE       = 1 << 11,
	ALLEGRO_GTK_TOPLEVEL_INTERNAL       = 1 << 12,
	ALLEGRO_MAXIMIZED                   = 1 << 13,
	ALLEGRO_OPENGL_ES_PROFILE           = 1 << 14,
}
version (ALLEGRO_UNSTABLE) {
	static if (allegroSupport >= AllegroSupport.v5_2_7) {
		enum ALLEGRO_OPENGL_CORE_PROFILE    = 1 << 15;
	}
	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		enum ALLEGRO_DRAG_AND_DROP    = 1 << 16;
	}
}

mixin(
	q{enum ALLEGRO_DISPLAY_OPTIONS } ~ `{` ~ q{
		ALLEGRO_RED_SIZE = 0,
		ALLEGRO_GREEN_SIZE = 1,
		ALLEGRO_BLUE_SIZE = 2,
		ALLEGRO_ALPHA_SIZE = 3,
		ALLEGRO_RED_SHIFT = 4,
		ALLEGRO_GREEN_SHIFT = 5,
		ALLEGRO_BLUE_SHIFT = 6,
		ALLEGRO_ALPHA_SHIFT = 7,
		ALLEGRO_ACC_RED_SIZE = 8,
		ALLEGRO_ACC_GREEN_SIZE = 9,
		ALLEGRO_ACC_BLUE_SIZE = 10,
		ALLEGRO_ACC_ALPHA_SIZE = 11,
		ALLEGRO_STEREO = 12,
		ALLEGRO_AUX_BUFFERS = 13,
		ALLEGRO_COLOR_SIZE = 14,
		ALLEGRO_DEPTH_SIZE = 15,
		ALLEGRO_STENCIL_SIZE = 16,
		ALLEGRO_SAMPLE_BUFFERS = 17,
		ALLEGRO_SAMPLES = 18,
		ALLEGRO_RENDER_METHOD = 19,
		ALLEGRO_FLOAT_COLOR = 20,
		ALLEGRO_FLOAT_DEPTH = 21,
		ALLEGRO_SINGLE_BUFFER = 22,
		ALLEGRO_SWAP_METHOD = 23,
		ALLEGRO_COMPATIBLE_DISPLAY = 24,
		ALLEGRO_UPDATE_DISPLAY_REGION = 25,
		ALLEGRO_VSYNC = 26,
		ALLEGRO_MAX_BITMAP_SIZE = 27,
		ALLEGRO_SUPPORT_NPOT_BITMAP = 28,
		ALLEGRO_CAN_DRAW_INTO_BITMAP = 29,
		ALLEGRO_SUPPORT_SEPARATE_ALPHA = 30,
		ALLEGRO_AUTO_CONVERT_BITMAPS = 31,
		ALLEGRO_SUPPORTED_ORIENTATIONS = 32,
		ALLEGRO_OPENGL_MAJOR_VERSION = 33,
		ALLEGRO_OPENGL_MINOR_VERSION = 34,
	} ~ (allegroSupport >= AllegroSupport.v5_2_8
				? q{ALLEGRO_DEFAULT_SHADER_PLATFORM = 35, }
				: q{ }) ~
		q{ALLEGRO_DISPLAY_OPTIONS_COUNT, } ~
`}`);
mixin ExpandEnum!ALLEGRO_DISPLAY_OPTIONS;

enum {
	ALLEGRO_DONTCARE,
	ALLEGRO_REQUIRE,
	ALLEGRO_SUGGEST
}

enum ALLEGRO_DISPLAY_ORIENTATION {
	ALLEGRO_DISPLAY_ORIENTATION_UNKNOWN = 0,
	ALLEGRO_DISPLAY_ORIENTATION_0_DEGREES = 1,
	ALLEGRO_DISPLAY_ORIENTATION_90_DEGREES = 2,
	ALLEGRO_DISPLAY_ORIENTATION_180_DEGREES = 4,
	ALLEGRO_DISPLAY_ORIENTATION_270_DEGREES = 8,
	ALLEGRO_DISPLAY_ORIENTATION_PORTRAIT = 5,
	ALLEGRO_DISPLAY_ORIENTATION_LANDSCAPE = 10,
	ALLEGRO_DISPLAY_ORIENTATION_ALL = 15,
	ALLEGRO_DISPLAY_ORIENTATION_FACE_UP = 16,
	ALLEGRO_DISPLAY_ORIENTATION_FACE_DOWN = 32
}
mixin ExpandEnum!ALLEGRO_DISPLAY_ORIENTATION;

enum {
	_ALLEGRO_PRIM_MAX_USER_ATTR = 10
}


struct ALLEGRO_DISPLAY;

enum ALLEGRO_NEW_WINDOW_TITLE_MAX_SIZE = 255;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	void al_set_new_display_refresh_rate(int refresh_rate);
	void al_set_new_display_flags(int flags);
	int al_get_new_display_refresh_rate();
	int al_get_new_display_flags();

	void al_set_new_window_title(const(char)* title);
	const(char)* al_get_new_window_title();

	int al_get_display_width(ALLEGRO_DISPLAY* display);
	int al_get_display_height(ALLEGRO_DISPLAY* display);
	int al_get_display_format(ALLEGRO_DISPLAY* display);
	int al_get_display_refresh_rate(ALLEGRO_DISPLAY* display);
	int al_get_display_flags(ALLEGRO_DISPLAY* display);
	int al_get_display_orientation(ALLEGRO_DISPLAY* display);
	bool al_set_display_flag(ALLEGRO_DISPLAY* display, int flag, bool onoff);

	ALLEGRO_DISPLAY* al_create_display(int w, int h);
	void al_destroy_display(ALLEGRO_DISPLAY* display);
	ALLEGRO_DISPLAY* al_get_current_display();
	void al_set_target_bitmap(ALLEGRO_BITMAP* bitmap);
	void al_set_target_backbuffer(ALLEGRO_DISPLAY* display);
	ALLEGRO_BITMAP* al_get_backbuffer(ALLEGRO_DISPLAY* display);
	ALLEGRO_BITMAP* al_get_target_bitmap();

	bool al_acknowledge_resize(ALLEGRO_DISPLAY* display);
	bool al_resize_display(ALLEGRO_DISPLAY* display, int width, int height);
	void al_flip_display();
	void al_update_display_region(int x, int y, int width, int height);
	bool al_is_compatible_bitmap(ALLEGRO_BITMAP* bitmap);

	bool al_wait_for_vsync();

	ALLEGRO_EVENT_SOURCE* al_get_display_event_source(ALLEGRO_DISPLAY* display);

	void al_set_display_icon(ALLEGRO_DISPLAY* display, ALLEGRO_BITMAP* icon);
	void al_set_display_icons(ALLEGRO_DISPLAY* display, int num_icons, ALLEGRO_BITMAP** icons);

	int al_get_new_display_adapter();
	void al_set_new_display_adapter(int adapter);
	void al_set_new_window_position(int x, int y);
	void al_get_new_window_position(int* x, int* y);
	void al_set_window_position(ALLEGRO_DISPLAY* display, int x, int y);
	void al_get_window_position(ALLEGRO_DISPLAY* display, int* x, int* y);
	bool al_set_window_constraints(ALLEGRO_DISPLAY* display, int min_w, int min_h, int max_w, int max_h);
	bool al_get_window_constraints(ALLEGRO_DISPLAY* display, int* min_w, int* min_h, int* max_w, int* max_h);
	void al_apply_window_constraints(ALLEGRO_DISPLAY* display, bool onoff);

	void al_set_window_title(ALLEGRO_DISPLAY* display, const(char)* title);

	void al_set_new_display_option(int option, int value, int importance);
	int al_get_new_display_option(int option, int* importance);
	void al_reset_new_display_options();
	void al_set_display_option(ALLEGRO_DISPLAY* display, int option, int value);
	int al_get_display_option(ALLEGRO_DISPLAY* display, int option);

	void al_hold_bitmap_drawing(bool hold);
	bool al_is_bitmap_drawing_held();

	void al_acknowledge_drawing_halt(ALLEGRO_DISPLAY* display);
	void al_acknowledge_drawing_resume(ALLEGRO_DISPLAY* display);

	static if (allegroSupport >= AllegroSupport.v5_2_10) {
		int al_get_display_adapter(ALLEGRO_DISPLAY *display);
	}

	version (ALLEGRO_UNSTABLE) {
		static if (allegroSupport >= AllegroSupport.v5_2_1) {
			void al_backup_dirty_bitmaps(ALLEGRO_DISPLAY* display);
		}
		static if (allegroSupport >= AllegroSupport.v5_2_9) {
			bool al_get_window_borders(ALLEGRO_DISPLAY *display, int *left, int *top, int *right, int *bottom);
		}
	}
}
else {
	extern(C) @nogc nothrow {
		alias pal_set_new_display_refresh_rate = void function(int refresh_rate);
		alias pal_set_new_display_flags = void function(int flags);
		alias pal_get_new_display_refresh_rate = int function();
		alias pal_get_new_display_flags = int function();

		alias pal_set_new_window_title = void function(const(char)* title);
		alias pal_get_new_window_title = const(char)* function();

		alias pal_get_display_width = int function(ALLEGRO_DISPLAY* display);
		alias pal_get_display_height = int function(ALLEGRO_DISPLAY* display);
		alias pal_get_display_format = int function(ALLEGRO_DISPLAY* display);
		alias pal_get_display_refresh_rate = int function(ALLEGRO_DISPLAY* display);
		alias pal_get_display_flags = int function(ALLEGRO_DISPLAY* display);
		alias pal_get_display_orientation = int function(ALLEGRO_DISPLAY* display);
		alias pal_set_display_flag = bool function(ALLEGRO_DISPLAY* display, int flag, bool onoff);

		alias pal_create_display = ALLEGRO_DISPLAY* function(int w, int h);
		alias pal_destroy_display = void function(ALLEGRO_DISPLAY* display);
		alias pal_get_current_display = ALLEGRO_DISPLAY* function();
		alias pal_set_target_bitmap = void function(ALLEGRO_BITMAP* bitmap);
		alias pal_set_target_backbuffer = void function(ALLEGRO_DISPLAY* display);
		alias pal_get_backbuffer = ALLEGRO_BITMAP* function(ALLEGRO_DISPLAY* display);
		alias pal_get_target_bitmap = ALLEGRO_BITMAP* function();

		alias pal_acknowledge_resize = bool function(ALLEGRO_DISPLAY* display);
		alias pal_resize_display = bool function(ALLEGRO_DISPLAY* display, int width, int height);
		alias pal_flip_display = void function();
		alias pal_update_display_region = void function(int x, int y, int width, int height);
		alias pal_is_compatible_bitmap = bool function(ALLEGRO_BITMAP* bitmap);

		alias pal_wait_for_vsync = bool function();

		alias pal_get_display_event_source = ALLEGRO_EVENT_SOURCE* function(ALLEGRO_DISPLAY* display);

		alias pal_set_display_icon = void function(ALLEGRO_DISPLAY* display, ALLEGRO_BITMAP* icon);
		alias pal_set_display_icons = void function(ALLEGRO_DISPLAY* display, int num_icons, ALLEGRO_BITMAP** icons);

		alias pal_get_new_display_adapter = int function();
		alias pal_set_new_display_adapter = void function(int adapter);
		alias pal_set_new_window_position = void function(int x, int y);
		alias pal_get_new_window_position = void function(int* x, int* y);
		alias pal_set_window_position = void function(ALLEGRO_DISPLAY* display, int x, int y);
		alias pal_get_window_position = void function(ALLEGRO_DISPLAY* display, int* x, int* y);
		alias pal_set_window_constraints = bool function(ALLEGRO_DISPLAY* display, int min_w, int min_h, int max_w, int max_h);
		alias pal_get_window_constraints = bool function(ALLEGRO_DISPLAY* display, int* min_w, int* min_h, int* max_w, int* max_h);
		alias pal_apply_window_constraints = void function(ALLEGRO_DISPLAY* display, bool onoff);

		alias pal_set_window_title = void function(ALLEGRO_DISPLAY* display, const(char)* title);

		alias pal_set_new_display_option = void function(int option, int value, int importance);
		alias pal_get_new_display_option = int function(int option, int* importance);
		alias pal_reset_new_display_options = void function();
		alias pal_set_display_option = void function(ALLEGRO_DISPLAY* display, int option, int value);
		alias pal_get_display_option = int function(ALLEGRO_DISPLAY* display, int option);

		alias pal_hold_bitmap_drawing = void function(bool hold);
		alias pal_is_bitmap_drawing_held = bool function();

		alias pal_acknowledge_drawing_halt = void function(ALLEGRO_DISPLAY* display);
		alias pal_acknowledge_drawing_resume = void function(ALLEGRO_DISPLAY* display);
	}

	__gshared {
		pal_set_new_display_refresh_rate al_set_new_display_refresh_rate;
		pal_set_new_display_flags al_set_new_display_flags;
		pal_get_new_display_refresh_rate al_get_new_display_refresh_rate;
		pal_get_new_display_flags al_get_new_display_flags;

		pal_set_new_window_title al_set_new_window_title;
		pal_get_new_window_title al_get_new_window_title;

		pal_get_display_width al_get_display_width;
		pal_get_display_height al_get_display_height;
		pal_get_display_format al_get_display_format;
		pal_get_display_refresh_rate al_get_display_refresh_rate;
		pal_get_display_flags al_get_display_flags;
		pal_get_display_orientation al_get_display_orientation;
		pal_set_display_flag al_set_display_flag;

		pal_create_display al_create_display;
		pal_destroy_display al_destroy_display;
		pal_get_current_display al_get_current_display;
		pal_set_target_bitmap al_set_target_bitmap;
		pal_set_target_backbuffer al_set_target_backbuffer;
		pal_get_backbuffer al_get_backbuffer;
		pal_get_target_bitmap al_get_target_bitmap;

		pal_acknowledge_resize al_acknowledge_resize;
		pal_resize_display al_resize_display;
		pal_flip_display al_flip_display;
		pal_update_display_region al_update_display_region;
		pal_is_compatible_bitmap al_is_compatible_bitmap;

		pal_wait_for_vsync al_wait_for_vsync;

		pal_get_display_event_source al_get_display_event_source;

		pal_set_display_icon al_set_display_icon;
		pal_set_display_icons al_set_display_icons;

		pal_get_new_display_adapter al_get_new_display_adapter;
		pal_set_new_display_adapter al_set_new_display_adapter;
		pal_set_new_window_position al_set_new_window_position;
		pal_get_new_window_position al_get_new_window_position;
		pal_set_window_position al_set_window_position;
		pal_get_window_position al_get_window_position;
		pal_set_window_constraints al_set_window_constraints;
		pal_get_window_constraints al_get_window_constraints;
		pal_apply_window_constraints al_apply_window_constraints;

		pal_set_window_title al_set_window_title;

		pal_set_new_display_option al_set_new_display_option;
		pal_get_new_display_option al_get_new_display_option;
		pal_reset_new_display_options al_reset_new_display_options;
		pal_set_display_option al_set_display_option;
		pal_get_display_option al_get_display_option;

		pal_hold_bitmap_drawing al_hold_bitmap_drawing;
		pal_is_bitmap_drawing_held al_is_bitmap_drawing_held;

		pal_acknowledge_drawing_halt al_acknowledge_drawing_halt;
		pal_acknowledge_drawing_resume al_acknowledge_drawing_resume;
	}

	static if (allegroSupport >= AllegroSupport.v5_2_10) {
		extern(C) @nogc nothrow {
			alias pal_get_display_adapter = int function(ALLEGRO_DISPLAY *display);
		}
		__gshared {
			pal_get_display_adapter al_get_display_adapter;
		}
	}

	version (ALLEGRO_UNSTABLE) {
		static if (allegroSupport >= AllegroSupport.v5_2_1) {
			extern(C) @nogc nothrow {
				alias pal_backup_dirty_bitmaps = void function(ALLEGRO_DISPLAY* display);
			}
			__gshared {
				pal_backup_dirty_bitmaps al_backup_dirty_bitmaps;
			}
		}
		static if (allegroSupport >= AllegroSupport.v5_2_9) {
			extern(C) @nogc nothrow {
				alias pal_get_window_borders = bool function(ALLEGRO_DISPLAY *display, int *left, int *top, int *right, int *bottom);
			}
			__gshared {
				pal_get_window_borders al_get_window_borders;
			}
		}
	}
}
