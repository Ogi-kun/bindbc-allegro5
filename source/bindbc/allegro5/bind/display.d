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
	pragma(inline, true) extern(C) @nogc nothrow:

	void al_set_new_display_refresh_rate(int refresh_rate) => ptr_al_set_new_display_refresh_rate(refresh_rate);
	void al_set_new_display_flags(int flags) => ptr_al_set_new_display_flags(flags);
	int al_get_new_display_refresh_rate() => ptr_al_get_new_display_refresh_rate();
	int al_get_new_display_flags() => ptr_al_get_new_display_flags();

	void al_set_new_window_title(const(char)* title) => ptr_al_set_new_window_title(title);
	const(char)* al_get_new_window_title() => ptr_al_get_new_window_title();

	int al_get_display_width(ALLEGRO_DISPLAY* display) => ptr_al_get_display_width(display);
	int al_get_display_height(ALLEGRO_DISPLAY* display) => ptr_al_get_display_height(display);
	int al_get_display_format(ALLEGRO_DISPLAY* display) => ptr_al_get_display_format(display);
	int al_get_display_refresh_rate(ALLEGRO_DISPLAY* display) => ptr_al_get_display_refresh_rate(display);
	int al_get_display_flags(ALLEGRO_DISPLAY* display) => ptr_al_get_display_flags(display);
	int al_get_display_orientation(ALLEGRO_DISPLAY* display) => ptr_al_get_display_orientation(display);
	bool al_set_display_flag(ALLEGRO_DISPLAY* display, int flag, bool onoff) => ptr_al_set_display_flag(display, flag, onoff);

	ALLEGRO_DISPLAY* al_create_display(int w, int h) => ptr_al_create_display(w, h);
	void al_destroy_display(ALLEGRO_DISPLAY* display) => ptr_al_destroy_display(display);
	ALLEGRO_DISPLAY* al_get_current_display() => ptr_al_get_current_display();
	void al_set_target_bitmap(ALLEGRO_BITMAP* bitmap) => ptr_al_set_target_bitmap(bitmap);
	void al_set_target_backbuffer(ALLEGRO_DISPLAY* display) => ptr_al_set_target_backbuffer(display);
	ALLEGRO_BITMAP* al_get_backbuffer(ALLEGRO_DISPLAY* display) => ptr_al_get_backbuffer(display);
	ALLEGRO_BITMAP* al_get_target_bitmap() => ptr_al_get_target_bitmap();

	bool al_acknowledge_resize(ALLEGRO_DISPLAY* display) => ptr_al_acknowledge_resize(display);
	bool al_resize_display(ALLEGRO_DISPLAY* display, int width, int height) => ptr_al_resize_display(display, width, height);
	void al_flip_display() => ptr_al_flip_display();
	void al_update_display_region(int x, int y, int width, int height) => ptr_al_update_display_region(x, y, width, height);
	bool al_is_compatible_bitmap(ALLEGRO_BITMAP* bitmap) => ptr_al_is_compatible_bitmap(bitmap);

	bool al_wait_for_vsync() => ptr_al_wait_for_vsync();

	ALLEGRO_EVENT_SOURCE* al_get_display_event_source(ALLEGRO_DISPLAY* display) => ptr_al_get_display_event_source(display);

	void al_set_display_icon(ALLEGRO_DISPLAY* display, ALLEGRO_BITMAP* icon) => ptr_al_set_display_icon(display, icon);
	void al_set_display_icons(ALLEGRO_DISPLAY* display, int num_icons, ALLEGRO_BITMAP** icons) => ptr_al_set_display_icons(display, num_icons, icons);

	int al_get_new_display_adapter() => ptr_al_get_new_display_adapter();
	void al_set_new_display_adapter(int adapter) => ptr_al_set_new_display_adapter(adapter);
	void al_set_new_window_position(int x, int y) => ptr_al_set_new_window_position(x, y);
	void al_get_new_window_position(int* x, int* y) => ptr_al_get_new_window_position(x, y);
	void al_set_window_position(ALLEGRO_DISPLAY* display, int x, int y) => ptr_al_set_window_position(display, x, y);
	void al_get_window_position(ALLEGRO_DISPLAY* display, int* x, int* y) => ptr_al_get_window_position(display, x, y);
	bool al_set_window_constraints(ALLEGRO_DISPLAY* display, int min_w, int min_h, int max_w, int max_h) => ptr_al_set_window_constraints(display, min_w, min_h, max_w, max_h);
	bool al_get_window_constraints(ALLEGRO_DISPLAY* display, int* min_w, int* min_h, int* max_w, int* max_h) => ptr_al_get_window_constraints(display, min_w, min_h, max_w, max_h);
	void al_apply_window_constraints(ALLEGRO_DISPLAY* display, bool onoff) => ptr_al_apply_window_constraints(display, onoff);

	void al_set_window_title(ALLEGRO_DISPLAY* display, const(char)* title) => ptr_al_set_window_title(display, title);

	void al_set_new_display_option(int option, int value, int importance) => ptr_al_set_new_display_option(option, value, importance);
	int al_get_new_display_option(int option, int* importance) => ptr_al_get_new_display_option(option, importance);
	void al_reset_new_display_options() => ptr_al_reset_new_display_options();
	void al_set_display_option(ALLEGRO_DISPLAY* display, int option, int value) => ptr_al_set_display_option(display, option, value);
	int al_get_display_option(ALLEGRO_DISPLAY* display, int option) => ptr_al_get_display_option(display, option);

	void al_hold_bitmap_drawing(bool hold) => ptr_al_hold_bitmap_drawing(hold);
	bool al_is_bitmap_drawing_held() => ptr_al_is_bitmap_drawing_held();

	void al_acknowledge_drawing_halt(ALLEGRO_DISPLAY* display) => ptr_al_acknowledge_drawing_halt(display);
	void al_acknowledge_drawing_resume(ALLEGRO_DISPLAY* display) => ptr_al_acknowledge_drawing_resume(display);

	static if (allegroSupport >= AllegroSupport.v5_2_10) {
		int al_get_display_adapter(ALLEGRO_DISPLAY *display) => ptr_al_get_display_adapter(display);
	}

	version (ALLEGRO_UNSTABLE) {
		static if (allegroSupport >= AllegroSupport.v5_2_1) {
			void al_backup_dirty_bitmaps(ALLEGRO_DISPLAY* display) => ptr_al_backup_dirty_bitmaps(display);
		}
		static if (allegroSupport >= AllegroSupport.v5_2_9) {
			bool al_get_window_borders(ALLEGRO_DISPLAY *display, int *left, int *top, int *right, int *bottom) => ptr_al_get_window_borders(display, left, top, right, bottom);
		}
	}

	package(bindbc.allegro5) __gshared {
		typeof(&al_set_new_display_refresh_rate) ptr_al_set_new_display_refresh_rate;
		typeof(&al_set_new_display_flags) ptr_al_set_new_display_flags;
		typeof(&al_get_new_display_refresh_rate) ptr_al_get_new_display_refresh_rate;
		typeof(&al_get_new_display_flags) ptr_al_get_new_display_flags;

		typeof(&al_set_new_window_title) ptr_al_set_new_window_title;
		typeof(&al_get_new_window_title) ptr_al_get_new_window_title;

		typeof(&al_get_display_width) ptr_al_get_display_width;
		typeof(&al_get_display_height) ptr_al_get_display_height;
		typeof(&al_get_display_format) ptr_al_get_display_format;
		typeof(&al_get_display_refresh_rate) ptr_al_get_display_refresh_rate;
		typeof(&al_get_display_flags) ptr_al_get_display_flags;
		typeof(&al_get_display_orientation) ptr_al_get_display_orientation;
		typeof(&al_set_display_flag) ptr_al_set_display_flag;

		typeof(&al_create_display) ptr_al_create_display;
		typeof(&al_destroy_display) ptr_al_destroy_display;
		typeof(&al_get_current_display) ptr_al_get_current_display;
		typeof(&al_set_target_bitmap) ptr_al_set_target_bitmap;
		typeof(&al_set_target_backbuffer) ptr_al_set_target_backbuffer;
		typeof(&al_get_backbuffer) ptr_al_get_backbuffer;
		typeof(&al_get_target_bitmap) ptr_al_get_target_bitmap;

		typeof(&al_acknowledge_resize) ptr_al_acknowledge_resize;
		typeof(&al_resize_display) ptr_al_resize_display;
		typeof(&al_flip_display) ptr_al_flip_display;
		typeof(&al_update_display_region) ptr_al_update_display_region;
		typeof(&al_is_compatible_bitmap) ptr_al_is_compatible_bitmap;

		typeof(&al_wait_for_vsync) ptr_al_wait_for_vsync;

		typeof(&al_get_display_event_source) ptr_al_get_display_event_source;

		typeof(&al_set_display_icon) ptr_al_set_display_icon;
		typeof(&al_set_display_icons) ptr_al_set_display_icons;

		typeof(&al_get_new_display_adapter) ptr_al_get_new_display_adapter;
		typeof(&al_set_new_display_adapter) ptr_al_set_new_display_adapter;
		typeof(&al_set_new_window_position) ptr_al_set_new_window_position;
		typeof(&al_get_new_window_position) ptr_al_get_new_window_position;
		typeof(&al_set_window_position) ptr_al_set_window_position;
		typeof(&al_get_window_position) ptr_al_get_window_position;
		typeof(&al_set_window_constraints) ptr_al_set_window_constraints;
		typeof(&al_get_window_constraints) ptr_al_get_window_constraints;
		typeof(&al_apply_window_constraints) ptr_al_apply_window_constraints;

		typeof(&al_set_window_title) ptr_al_set_window_title;

		typeof(&al_set_new_display_option) ptr_al_set_new_display_option;
		typeof(&al_get_new_display_option) ptr_al_get_new_display_option;
		typeof(&al_reset_new_display_options) ptr_al_reset_new_display_options;
		typeof(&al_set_display_option) ptr_al_set_display_option;
		typeof(&al_get_display_option) ptr_al_get_display_option;

		typeof(&al_hold_bitmap_drawing) ptr_al_hold_bitmap_drawing;
		typeof(&al_is_bitmap_drawing_held) ptr_al_is_bitmap_drawing_held;

		typeof(&al_acknowledge_drawing_halt) ptr_al_acknowledge_drawing_halt;
		typeof(&al_acknowledge_drawing_resume) ptr_al_acknowledge_drawing_resume;

		static if (allegroSupport >= AllegroSupport.v5_2_10) {
			typeof(&al_get_display_adapter) ptr_al_get_display_adapter;
		}

		version (ALLEGRO_UNSTABLE) {
			static if (allegroSupport >= AllegroSupport.v5_2_1) {
				typeof(&al_backup_dirty_bitmaps) ptr_al_backup_dirty_bitmaps;
			}
			static if (allegroSupport >= AllegroSupport.v5_2_9) {
				typeof(&al_get_window_borders) ptr_al_get_window_borders;
			}
		}
	}
}
