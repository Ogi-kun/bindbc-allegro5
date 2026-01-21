module bindbc.allegro5.bind.allegro_windows;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;

version (Windows):

import core.sys.windows.windef : HWND, UINT, WPARAM, LPARAM, LRESULT;

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
	pragma(inline, true) extern(C) @nogc nothrow:
	HWND al_get_win_window_handle(ALLEGRO_DISPLAY* display) => ptr_al_get_win_window_handle(display);
	bool al_win_add_window_callback(ALLEGRO_DISPLAY* display, al_win_window_callback callback, void* userdata) =>
			ptr_al_win_add_window_callback(display, callback, userdata);
	bool al_win_remove_window_callback(ALLEGRO_DISPLAY* display, al_win_window_callback callback, void* userdata) =>
			ptr_al_win_remove_window_callback(display, callback, userdata);
	package(bindbc.allegro5) __gshared {
		typeof(&al_get_win_window_handle) ptr_al_get_win_window_handle;
		typeof(&al_win_add_window_callback) ptr_al_win_add_window_callback;
		typeof(&al_win_remove_window_callback) ptr_al_win_remove_window_callback;
	}
}
