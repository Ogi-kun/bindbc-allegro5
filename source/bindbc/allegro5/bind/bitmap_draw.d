module bindbc.allegro5.bind.bitmap_draw;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import bindbc.allegro5.bind.color : ALLEGRO_COLOR;


enum {
	ALLEGRO_FLIP_HORIZONTAL = 0x00001,
	ALLEGRO_FLIP_VERTICAL   = 0x00002,
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	void al_draw_bitmap(ALLEGRO_BITMAP *bitmap, float dx, float dy, int flags);
	void al_draw_bitmap_region(ALLEGRO_BITMAP *bitmap, float sx, float sy,
			float sw, float sh, float dx, float dy, int flags);
	void al_draw_scaled_bitmap(ALLEGRO_BITMAP *bitmap, float sx, float sy,
			float sw, float sh, float dx, float dy, float dw, float dh, int flags);
	void al_draw_rotated_bitmap(ALLEGRO_BITMAP *bitmap, float cx, float cy,
			float dx, float dy, float angle, int flags);
	void al_draw_scaled_rotated_bitmap(ALLEGRO_BITMAP *bitmap, float cx, float cy,
			float dx, float dy, float xscale, float yscale, float angle, int flags);

	void al_draw_tinted_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint,
			float dx, float dy, int flags);
	void al_draw_tinted_bitmap_region(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint,
			float sx, float sy, float sw, float sh, float dx, float dy, int flags);
	void al_draw_tinted_scaled_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint,
			float sx, float sy, float sw, float sh, float dx, float dy, float dw, float dh, int flags);
	void al_draw_tinted_rotated_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint,
			float cx, float cy, float dx, float dy, float angle, int flags);
	void al_draw_tinted_scaled_rotated_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint,
			float cx, float cy, float dx, float dy, float xscale, float yscale, float angle, int flags);
	void al_draw_tinted_scaled_rotated_bitmap_region(ALLEGRO_BITMAP *bitmap,
			float sx, float sy, float sw, float sh, ALLEGRO_COLOR tint, float cx, float cy,
			float dx, float dy, float xscale, float yscale, float angle, int flags);
}
else {
	extern(C) @nogc nothrow {
		alias pal_draw_bitmap = void function(ALLEGRO_BITMAP *bitmap, float dx, float dy, int flags);
		alias pal_draw_bitmap_region = void function(ALLEGRO_BITMAP *bitmap,
				float sx, float sy, float sw, float sh, float dx, float dy, int flags);
		alias pal_draw_scaled_bitmap = void function(ALLEGRO_BITMAP *bitmap,
				float sx, float sy, float sw, float sh, float dx, float dy, float dw, float dh, int flags);
		alias pal_draw_rotated_bitmap = void function(ALLEGRO_BITMAP *bitmap,
				float cx, float cy, float dx, float dy, float angle, int flags);
		alias pal_draw_scaled_rotated_bitmap = void function(ALLEGRO_BITMAP *bitmap, float cx, float cy,
				float dx, float dy, float xscale, float yscale, float angle, int flags);

		alias pal_draw_tinted_bitmap = void function(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint,
				float dx, float dy, int flags);
		alias pal_draw_tinted_bitmap_region = void function(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint,
				float sx, float sy, float sw, float sh, float dx, float dy, int flags);
		alias pal_draw_tinted_scaled_bitmap = void function(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint,
				float sx, float sy, float sw, float sh, float dx, float dy, float dw, float dh, int flags);
		alias pal_draw_tinted_rotated_bitmap = void function(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint,
				float cx, float cy, float dx, float dy, float angle, int flags);
		alias pal_draw_tinted_scaled_rotated_bitmap = void function(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint,
				float cx, float cy, float dx, float dy, float xscale, float yscale, float angle, int flags);
		alias pal_draw_tinted_scaled_rotated_bitmap_region = void function(ALLEGRO_BITMAP *bitmap,
				float sx, float sy, float sw, float sh, ALLEGRO_COLOR tint, float cx, float cy,
				float dx, float dy, float xscale, float yscale, float angle, int flags);
	}

	__gshared {
		pal_draw_bitmap al_draw_bitmap;
		pal_draw_bitmap_region al_draw_bitmap_region;
		pal_draw_scaled_bitmap al_draw_scaled_bitmap;
		pal_draw_rotated_bitmap al_draw_rotated_bitmap;
		pal_draw_scaled_rotated_bitmap al_draw_scaled_rotated_bitmap;

		pal_draw_tinted_bitmap al_draw_tinted_bitmap;
		pal_draw_tinted_bitmap_region al_draw_tinted_bitmap_region;
		pal_draw_tinted_scaled_bitmap al_draw_tinted_scaled_bitmap;
		pal_draw_tinted_rotated_bitmap al_draw_tinted_rotated_bitmap;
		pal_draw_tinted_scaled_rotated_bitmap al_draw_tinted_scaled_rotated_bitmap;
		pal_draw_tinted_scaled_rotated_bitmap_region al_draw_tinted_scaled_rotated_bitmap_region;
	}
}
