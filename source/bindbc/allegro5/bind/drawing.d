module bindbc.allegro5.bind.drawing;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.color : ALLEGRO_COLOR;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	void al_clear_to_color(ALLEGRO_COLOR color);
	void al_clear_depth_buffer(float x);
	void al_draw_pixel(float x, float y, ALLEGRO_COLOR color);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	void al_clear_to_color(ALLEGRO_COLOR color) => ptr_al_clear_to_color(color);
	void al_clear_depth_buffer(float x) => ptr_al_clear_depth_buffer(x);
	void al_draw_pixel(float x, float y, ALLEGRO_COLOR color) => ptr_al_draw_pixel(x, y, color);
	package(bindbc.allegro5) __gshared {
		typeof(&al_clear_to_color) ptr_al_clear_to_color;
		typeof(&al_clear_depth_buffer) ptr_al_clear_depth_buffer;
		typeof(&al_draw_pixel) ptr_al_draw_pixel;
	}
}
