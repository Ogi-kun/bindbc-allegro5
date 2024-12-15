module bindbc.allegro5.bind.allegro_windows;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;

version (Windows):

import core.sys.windows.windows;

extern(C) @nogc nothrow {
	alias al_win_window_callback = bool function(
			ALLEGRO_DISPLAY* display,
			UINT message,
			WPARAM wparam,
			LPARAM lparam,
			LRESULT* result,
			void* userdata
	);
}

static if (staticBinding) {
	extern(C) @nogc nothrow:

	HWND al_get_win_window_handle(ALLEGRO_DISPLAY* display);

	bool al_win_add_window_callback(
			ALLEGRO_DISPLAY* display,
			al_win_window_callback callback,
			void* userdata);

	bool al_win_remove_window_callback(
			ALLEGRO_DISPLAY* display,
			al_win_window_callback callback,
			void* userdata);
}
else {
	extern(C) @nogc nothrow {
		alias pal_get_win_window_handle = HWND function(ALLEGRO_DISPLAY* display);

		alias pal_win_add_window_callback = bool function(
				ALLEGRO_DISPLAY* display,
				al_win_window_callback callback,
				void* userdata);

		alias pal_win_remove_window_callback = bool function(
				ALLEGRO_DISPLAY* display,
				al_win_window_callback callback,
				void* userdata);
	}

	__gshared {
		pal_get_win_window_handle al_get_win_window_handle;
		pal_win_add_window_callback al_win_add_window_callback;
		pal_win_remove_window_callback al_win_remove_window_callback;
	}
}

