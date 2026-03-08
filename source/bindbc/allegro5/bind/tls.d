module bindbc.allegro5.bind.tls;

import bindbc.allegro5.config;

enum ALLEGRO_STATE_FLAGS {
	ALLEGRO_STATE_NEW_DISPLAY_PARAMETERS = 0x0001,
	ALLEGRO_STATE_NEW_BITMAP_PARAMETERS  = 0x0002,
	ALLEGRO_STATE_DISPLAY                = 0x0004,
	ALLEGRO_STATE_TARGET_BITMAP          = 0x0008,
	ALLEGRO_STATE_BLENDER                = 0x0010,
	ALLEGRO_STATE_NEW_FILE_INTERFACE     = 0x0020,
	ALLEGRO_STATE_TRANSFORM              = 0x0040,
	ALLEGRO_STATE_PROJECTION_TRANSFORM   = 0x0100,
	ALLEGRO_STATE_BITMAP                 = ALLEGRO_STATE_TARGET_BITMAP + ALLEGRO_STATE_NEW_BITMAP_PARAMETERS,
	ALLEGRO_STATE_ALL                    = 0xffff,
}
mixin ExpandEnum!ALLEGRO_STATE_FLAGS;

struct ALLEGRO_STATE {
	char[1024] _tls;
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	void al_store_state(ALLEGRO_STATE* state, int flags);
	void al_restore_state(const(ALLEGRO_STATE)* state);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	void al_store_state(ALLEGRO_STATE* state, int flags) => ptr_al_store_state(state, flags);
	void al_restore_state(const(ALLEGRO_STATE)* state) => ptr_al_restore_state(state);
	package(bindbc.allegro5) __gshared {
		typeof(&al_store_state) ptr_al_store_state;
		typeof(&al_restore_state) ptr_al_restore_state;
	}
}
