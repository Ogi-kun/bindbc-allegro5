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
	extern(C) @nogc nothrow {
		alias pal_clear_to_color = void function(ALLEGRO_COLOR color);
		alias pal_clear_depth_buffer = void function(float x);
		alias pal_draw_pixel = void function(float x, float y, ALLEGRO_COLOR color);
	}
	__gshared {
		pal_clear_to_color al_clear_to_color;
		pal_clear_depth_buffer al_clear_depth_buffer;
		pal_draw_pixel al_draw_pixel;
	}
}
