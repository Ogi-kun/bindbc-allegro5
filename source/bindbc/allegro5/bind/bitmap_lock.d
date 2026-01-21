module bindbc.allegro5.bind.bitmap_lock;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;

enum {
	ALLEGRO_LOCK_READWRITE  = 0,
	ALLEGRO_LOCK_READONLY   = 1,
	ALLEGRO_LOCK_WRITEONLY  = 2,
}

struct ALLEGRO_LOCKED_REGION {
	void* data;
	int format;
	int pitch;
	int pixel_size;
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_LOCKED_REGION* al_lock_bitmap(ALLEGRO_BITMAP* bitmap, int format, int flags);
	ALLEGRO_LOCKED_REGION* al_lock_bitmap_region(ALLEGRO_BITMAP* bitmap,
			int x, int y, int width, int height, int format, int flags);
	ALLEGRO_LOCKED_REGION* al_lock_bitmap_blocked(ALLEGRO_BITMAP* bitmap, int flags);
	ALLEGRO_LOCKED_REGION* al_lock_bitmap_region_blocked(ALLEGRO_BITMAP* bitmap,
			int x_block, int y_block, int width_block, int height_block, int flags);
	void al_unlock_bitmap(ALLEGRO_BITMAP* bitmap);
	bool al_is_bitmap_locked(ALLEGRO_BITMAP* bitmap);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	ALLEGRO_LOCKED_REGION* al_lock_bitmap(ALLEGRO_BITMAP* bitmap, int format, int flags) => ptr_al_lock_bitmap(bitmap, format, flags);
	ALLEGRO_LOCKED_REGION* al_lock_bitmap_region(ALLEGRO_BITMAP* bitmap, int x, int y, int width, int height, int format, int flags) =>
			ptr_al_lock_bitmap_region(bitmap, x, y, width, height, format, flags);
	ALLEGRO_LOCKED_REGION* al_lock_bitmap_blocked(ALLEGRO_BITMAP* bitmap, int flags) => ptr_al_lock_bitmap_blocked(bitmap, flags);
	ALLEGRO_LOCKED_REGION* al_lock_bitmap_region_blocked(ALLEGRO_BITMAP* bitmap, int x_block, int y_block, int width_block, int height_block, int flags) =>
			ptr_al_lock_bitmap_region_blocked(bitmap, x_block, y_block, width_block, height_block, flags);
	void al_unlock_bitmap(ALLEGRO_BITMAP* bitmap) => ptr_al_unlock_bitmap(bitmap);
	bool al_is_bitmap_locked(ALLEGRO_BITMAP* bitmap) => ptr_al_is_bitmap_locked(bitmap);
	package(bindbc.allegro5) __gshared {
		typeof(&al_lock_bitmap) ptr_al_lock_bitmap;
		typeof(&al_lock_bitmap_region) ptr_al_lock_bitmap_region;
		typeof(&al_lock_bitmap_blocked) ptr_al_lock_bitmap_blocked;
		typeof(&al_lock_bitmap_region_blocked) ptr_al_lock_bitmap_region_blocked;
		typeof(&al_unlock_bitmap) ptr_al_unlock_bitmap;
		typeof(&al_is_bitmap_locked) ptr_al_is_bitmap_locked;
	}
}
