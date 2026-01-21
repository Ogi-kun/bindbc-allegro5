module bindbc.allegro5.bind.clipboard;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	char* al_get_clipboard_text(ALLEGRO_DISPLAY* display);
	bool al_set_clipboard_text(ALLEGRO_DISPLAY* display, const(char)* text);
	bool al_clipboard_has_text(ALLEGRO_DISPLAY* display);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	char* al_get_clipboard_text(ALLEGRO_DISPLAY* display) => ptr_al_get_clipboard_text(display);
	bool al_set_clipboard_text(ALLEGRO_DISPLAY* display, const(char)* text) => ptr_al_set_clipboard_text(display, text);
	bool al_clipboard_has_text(ALLEGRO_DISPLAY* display) => ptr_al_clipboard_has_text(display);
	package(bindbc.allegro5) __gshared {
		typeof(&al_get_clipboard_text) ptr_al_get_clipboard_text;
		typeof(&al_set_clipboard_text) ptr_al_set_clipboard_text;
		typeof(&al_clipboard_has_text) ptr_al_clipboard_has_text;
	}
}
