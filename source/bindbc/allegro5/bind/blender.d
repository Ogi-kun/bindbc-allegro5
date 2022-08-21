module bindbc.allegro5.bind.blender;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.color : ALLEGRO_COLOR;

enum ALLEGRO_BLEND_MODE {
	ALLEGRO_ZERO                = 0,
	ALLEGRO_ONE                 = 1,
	ALLEGRO_ALPHA               = 2,
	ALLEGRO_INVERSE_ALPHA       = 3,
	ALLEGRO_SRC_COLOR           = 4,
	ALLEGRO_DEST_COLOR          = 5,
	ALLEGRO_INVERSE_SRC_COLOR   = 6,
	ALLEGRO_INVERSE_DEST_COLOR  = 7,
	ALLEGRO_CONST_COLOR         = 8,
	ALLEGRO_INVERSE_CONST_COLOR = 9,
	ALLEGRO_NUM_BLEND_MODES
}

enum ALLEGRO_BLEND_OPERATIONS {
	ALLEGRO_ADD                = 0,
	ALLEGRO_SRC_MINUS_DEST     = 1,
	ALLEGRO_DEST_MINUS_SRC     = 2,
	ALLEGRO_NUM_BLEND_OPERATIONS
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	void al_set_blender(int op, int source, int dest);
	void al_set_blend_color(ALLEGRO_COLOR color);
	void al_get_blender(int* op, int* source, int* dest);
	ALLEGRO_COLOR al_get_blend_color();
	void al_set_separate_blender(int op, int source, int dest, int alpha_op, 
			int alpha_source, int alpha_dest);
	void al_get_separate_blender(int* op, int* source, int* dest, int* alpha_op, 
			int* alpha_src, int* alpha_dest);
}
else {
	extern(C) @nogc nothrow {
		alias pal_set_blender = void function(int op, int source, int dest);
		alias pal_set_blend_color = void function(ALLEGRO_COLOR color);
		alias pal_get_blender = void function(int* op, int* source, int* dest);
		alias pal_get_blend_color = ALLEGRO_COLOR function();
		alias pal_set_separate_blender = void function(int op, int source, 
				int dest, int alpha_op, int alpha_source, int alpha_dest);
		alias pal_get_separate_blender = void function(int* op, int* source, 
				int* dest, int* alpha_op, int* alpha_src, int* alpha_dest);
	}
	__gshared {
		pal_set_blender al_set_blender;
		pal_set_blend_color al_set_blend_color;
		pal_get_blender al_get_blender;
		pal_get_blend_color al_get_blend_color;
		pal_set_separate_blender al_set_separate_blender;
		pal_get_separate_blender al_get_separate_blender;
	}
}