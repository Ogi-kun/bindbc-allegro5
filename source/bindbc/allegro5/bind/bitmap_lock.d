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
	extern(C) @nogc nothrow {
		alias pal_lock_bitmap = ALLEGRO_LOCKED_REGION* function(ALLEGRO_BITMAP* bitmap, int format, int flags);
		alias pal_lock_bitmap_region = ALLEGRO_LOCKED_REGION* function(ALLEGRO_BITMAP* bitmap,
				int x, int y, int width, int height, int format, int flags);
		alias pal_lock_bitmap_blocked = ALLEGRO_LOCKED_REGION* function(ALLEGRO_BITMAP* bitmap, int flags);
		alias pal_lock_bitmap_region_blocked = ALLEGRO_LOCKED_REGION* function(ALLEGRO_BITMAP* bitmap,
				int x_block, int y_block, int width_block, int height_block, int flags);
		alias pal_unlock_bitmap = void function(ALLEGRO_BITMAP* bitmap);
		alias pal_is_bitmap_locked = bool function(ALLEGRO_BITMAP* bitmap);
	}
	__gshared {
		pal_lock_bitmap al_lock_bitmap;
		pal_lock_bitmap_region al_lock_bitmap_region;
		pal_lock_bitmap_blocked al_lock_bitmap_blocked;
		pal_lock_bitmap_region_blocked al_lock_bitmap_region_blocked;
		pal_unlock_bitmap al_unlock_bitmap;
		pal_is_bitmap_locked al_is_bitmap_locked;
	}
}
