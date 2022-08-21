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
	extern(C) @nogc nothrow {
		alias pal_get_clipboard_text = char* function(ALLEGRO_DISPLAY* display);
		alias pal_set_clipboard_text = bool function(ALLEGRO_DISPLAY* display, const(char)* text);
		alias pal_clipboard_has_text = bool function(ALLEGRO_DISPLAY* display);
	}
	__gshared {
		pal_get_clipboard_text al_get_clipboard_text;
		pal_set_clipboard_text al_set_clipboard_text;
		pal_clipboard_has_text al_clipboard_has_text;
	}
}
