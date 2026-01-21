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
	pragma(inline, true) extern(C) @nogc nothrow:

	void al_draw_bitmap(ALLEGRO_BITMAP *bitmap, float dx, float dy, int flags) =>
			ptr_al_draw_bitmap(bitmap, dx, dy, flags);
	void al_draw_bitmap_region(ALLEGRO_BITMAP *bitmap, float sx, float sy, float sw, float sh, float dx, float dy, int flags) =>
			ptr_al_draw_bitmap_region(bitmap, sx, sy, sw, sh, dx, dy, flags);
	void al_draw_scaled_bitmap(ALLEGRO_BITMAP *bitmap, float sx, float sy, float sw, float sh, float dx, float dy, float dw, float dh, int flags) =>
			ptr_al_draw_scaled_bitmap(bitmap, sx, sy, sw, sh, dx, dy, dw, dh, flags);
	void al_draw_rotated_bitmap(ALLEGRO_BITMAP *bitmap, float cx, float cy, float dx, float dy, float angle, int flags) =>
			ptr_al_draw_rotated_bitmap(bitmap, cx, cy, dx, dy, angle, flags);
	void al_draw_scaled_rotated_bitmap(ALLEGRO_BITMAP *bitmap, float cx, float cy, float dx, float dy, float xscale, float yscale, float angle, int flags) =>
			ptr_al_draw_scaled_rotated_bitmap(bitmap, cx, cy, dx, dy, xscale, yscale, angle, flags);

	void al_draw_tinted_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float dx, float dy, int flags) =>
			ptr_al_draw_tinted_bitmap(bitmap, tint, dx, dy, flags);
	void al_draw_tinted_bitmap_region(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float sx, float sy, float sw, float sh, float dx, float dy, int flags) =>
			ptr_al_draw_tinted_bitmap_region(bitmap, tint, sx, sy, sw, sh, dx, dy, flags);
	void al_draw_tinted_scaled_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float sx, float sy, float sw, float sh, float dx, float dy, float dw, float dh, int flags) =>
			ptr_al_draw_tinted_scaled_bitmap(bitmap, tint, sx, sy, sw, sh, dx, dy, dw, dh, flags);
	void al_draw_tinted_rotated_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float cx, float cy, float dx, float dy, float angle, int flags) =>
			ptr_al_draw_tinted_rotated_bitmap(bitmap, tint, cx, cy, dx, dy, angle, flags);
	void al_draw_tinted_scaled_rotated_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float cx, float cy, float dx, float dy, float xscale, float yscale, float angle, int flags) =>
			ptr_al_draw_tinted_scaled_rotated_bitmap(bitmap, tint, cx, cy, dx, dy, xscale, yscale, angle, flags);
	void al_draw_tinted_scaled_rotated_bitmap_region(ALLEGRO_BITMAP *bitmap, float sx, float sy, float sw, float sh, ALLEGRO_COLOR tint, float cx, float cy, float dx, float dy, float xscale, float yscale, float angle, int flags) =>
			ptr_al_draw_tinted_scaled_rotated_bitmap_region(bitmap, sx, sy, sw, sh, tint, cx, cy, dx, dy, xscale, yscale, angle, flags);

	package(bindbc.allegro5) __gshared {
		typeof(&al_draw_bitmap) ptr_al_draw_bitmap;
		typeof(&al_draw_bitmap_region) ptr_al_draw_bitmap_region;
		typeof(&al_draw_scaled_bitmap) ptr_al_draw_scaled_bitmap;
		typeof(&al_draw_rotated_bitmap) ptr_al_draw_rotated_bitmap;
		typeof(&al_draw_scaled_rotated_bitmap) ptr_al_draw_scaled_rotated_bitmap;

		typeof(&al_draw_tinted_bitmap) ptr_al_draw_tinted_bitmap;
		typeof(&al_draw_tinted_bitmap_region) ptr_al_draw_tinted_bitmap_region;
		typeof(&al_draw_tinted_scaled_bitmap) ptr_al_draw_tinted_scaled_bitmap;
		typeof(&al_draw_tinted_rotated_bitmap) ptr_al_draw_tinted_rotated_bitmap;
		typeof(&al_draw_tinted_scaled_rotated_bitmap) ptr_al_draw_tinted_scaled_rotated_bitmap;
		typeof(&al_draw_tinted_scaled_rotated_bitmap_region) ptr_al_draw_tinted_scaled_rotated_bitmap_region;
	}
}
