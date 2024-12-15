module bindbc.allegro5.bind.alcompat;

import bindbc.allegro5.bind.blender;
import bindbc.allegro5.bind.bitmap;
import bindbc.allegro5.bind.altime;
import bindbc.allegro5.bind.events;
import bindbc.allegro5.bind.display;

enum ALLEGRO_DST_COLOR = ALLEGRO_BLEND_MODE.ALLEGRO_DEST_COLOR;
enum ALLEGRO_INVERSE_DST_COLOR = ALLEGRO_BLEND_MODE.ALLEGRO_INVERSE_DEST_COLOR;

extern(C) @nogc nothrow:

void al_convert_bitmaps() {
	al_convert_memory_bitmaps();
}

double al_current_time() {
	return al_get_time();
}

bool al_event_queue_is_empty(ALLEGRO_EVENT_QUEUE* q) {
	return al_is_event_queue_empty(q);
}

bool al_toggle_display_flag(ALLEGRO_DISPLAY *d, int f, bool o) {
	return al_set_display_flag(d, f, o);
}
