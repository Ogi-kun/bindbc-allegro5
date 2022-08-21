module bindbc.allegro5.bind.bitmap;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.color : ALLEGRO_COLOR;

struct ALLEGRO_BITMAP;

version (ALLEGRO_UNSTABLE) static if (allegro5Support >= Allegro5Support.v5_2_8) {
	enum ALLEGRO_BITMAP_WRAP {
		ALLEGRO_BITMAP_WRAP_DEFAULT = 0,
		ALLEGRO_BITMAP_WRAP_REPEAT = 1,
		ALLEGRO_BITMAP_WRAP_CLAMP = 2,
		ALLEGRO_BITMAP_WRAP_MIRROR = 3,
	}
}

enum {
	ALLEGRO_MEMORY_BITMAP            = 0x0001,
	_ALLEGRO_KEEP_BITMAP_FORMAT      = 0x0002,
	ALLEGRO_FORCE_LOCKING            = 0x0004,
	ALLEGRO_NO_PRESERVE_TEXTURE      = 0x0008,
	_ALLEGRO_ALPHA_TEST              = 0x0010,
	_ALLEGRO_INTERNAL_OPENGL         = 0x0020,
	ALLEGRO_MIN_LINEAR               = 0x0040,
	ALLEGRO_MAG_LINEAR               = 0x0080,
	ALLEGRO_MIPMAP                   = 0x0100,
	_ALLEGRO_NO_PREMULTIPLIED_ALPHA  = 0x0200,
	ALLEGRO_VIDEO_BITMAP             = 0x0400,
	ALLEGRO_CONVERT_BITMAP           = 0x1000,
}

static if (staticBinding) {
	extern(C) @nogc nothrow:

	void al_set_new_bitmap_format(int format);
	void al_set_new_bitmap_flags(int flags);
	int al_get_new_bitmap_format();
	int al_get_new_bitmap_flags();
	void al_add_new_bitmap_flag(int flag);

	int al_get_bitmap_width(ALLEGRO_BITMAP* bitmap);
	int al_get_bitmap_height(ALLEGRO_BITMAP* bitmap);
	int al_get_bitmap_format(ALLEGRO_BITMAP* bitmap);
	int al_get_bitmap_flags(ALLEGRO_BITMAP* bitmap);

	ALLEGRO_BITMAP* al_create_bitmap(int w, int h);
	void al_destroy_bitmap(ALLEGRO_BITMAP* bitmap);

	void al_put_pixel(int x, int y, ALLEGRO_COLOR color);
	void al_put_blended_pixel(int x, int y, ALLEGRO_COLOR color);
	ALLEGRO_COLOR al_get_pixel(ALLEGRO_BITMAP* bitmap, int x, int y);

	void al_convert_mask_to_alpha(ALLEGRO_BITMAP* bitmap, ALLEGRO_COLOR mask_color);

	void al_set_clipping_rectangle(int x, int y, int width, int height);
	void al_reset_clipping_rectangle();
	void al_get_clipping_rectangle(int* x, int* y, int* w, int* h);

	ALLEGRO_BITMAP* al_create_sub_bitmap(ALLEGRO_BITMAP* parent, int x, int y, int w, int h);
	bool al_is_sub_bitmap(ALLEGRO_BITMAP* bitmap);
	ALLEGRO_BITMAP* al_get_parent_bitmap(ALLEGRO_BITMAP* bitmap);
	int al_get_bitmap_x(ALLEGRO_BITMAP* bitmap);
	int al_get_bitmap_y(ALLEGRO_BITMAP* bitmap);
	void al_reparent_bitmap(ALLEGRO_BITMAP* bitmap, ALLEGRO_BITMAP* parent, int x, int y, int w, int h);

	ALLEGRO_BITMAP* al_clone_bitmap(ALLEGRO_BITMAP* bitmap);
	void al_convert_bitmap(ALLEGRO_BITMAP* bitmap);
	void al_convert_memory_bitmaps();

	version (ALLEGRO_UNSTABLE) {
		static if (allegro5Support >= Allegro5Support.v5_2_1) {
			int al_get_new_bitmap_depth();
			void al_set_new_bitmap_depth(int depth);
			int al_get_new_bitmap_samples();
			void al_set_new_bitmap_samples(int samples);
			int al_get_bitmap_depth(ALLEGRO_BITMAP* bitmap);
			int al_get_bitmap_samples(ALLEGRO_BITMAP* bitmap);
			void al_backup_dirty_bitmap(ALLEGRO_BITMAP* bitmap);
		}

		static if (allegro5Support >= Allegro5Support.v5_2_5) {
			ALLEGRO_COLOR al_get_bitmap_blend_color();
			void al_get_bitmap_blender(int* op, int* src, int* dst);
			void al_get_separate_bitmap_blender(int* op, int* src, int* dst, int* alpha_op, int* alpha_src, int* alpha_dst);
			void al_set_bitmap_blend_color(ALLEGRO_COLOR color);
			void al_set_bitmap_blender(int op, int src, int dst);
			void al_set_separate_bitmap_blender(int op, int src, int dst, int alpha_op, int alpha_src, int alpha_dst);
			void al_reset_bitmap_blender();
		}

		static if (allegro5Support >= Allegro5Support.v5_2_8) {
			void al_get_new_bitmap_wrap(ALLEGRO_BITMAP_WRAP* u, ALLEGRO_BITMAP_WRAP* v);
			void al_set_new_bitmap_wrap(ALLEGRO_BITMAP_WRAP u, ALLEGRO_BITMAP_WRAP v);
		}
	}
}
else {
	extern(C) @nogc nothrow {

		alias pal_set_new_bitmap_format = void function(int format);
		alias pal_set_new_bitmap_flags = void function(int flags);
		alias pal_get_new_bitmap_format = int function();
		alias pal_get_new_bitmap_flags = int function();
		alias pal_add_new_bitmap_flag = void function(int flag);

		alias pal_get_bitmap_width = int function(ALLEGRO_BITMAP* bitmap);
		alias pal_get_bitmap_height = int function(ALLEGRO_BITMAP* bitmap);
		alias pal_get_bitmap_format = int function(ALLEGRO_BITMAP* bitmap);
		alias pal_get_bitmap_flags = int function(ALLEGRO_BITMAP* bitmap);

		alias pal_create_bitmap = ALLEGRO_BITMAP* function(int w, int h);
		alias pal_destroy_bitmap = void function(ALLEGRO_BITMAP* bitmap);

		alias pal_put_pixel = void function(int x, int y, ALLEGRO_COLOR color);
		alias pal_put_blended_pixel = void function(int x, int y, ALLEGRO_COLOR color);
		alias pal_get_pixel = ALLEGRO_COLOR function(ALLEGRO_BITMAP* bitmap, int x, int y);

		alias pal_convert_mask_to_alpha = void function(ALLEGRO_BITMAP* bitmap, ALLEGRO_COLOR mask_color);

		alias pal_set_clipping_rectangle = void function(int x, int y, int width, int height);
		alias pal_reset_clipping_rectangle = void function();
		alias pal_get_clipping_rectangle = void function(int* x, int* y, int* w, int* h);

		alias pal_create_sub_bitmap = ALLEGRO_BITMAP* function(ALLEGRO_BITMAP* parent, int x, int y, int w, int h);
		alias pal_is_sub_bitmap = bool function(ALLEGRO_BITMAP* bitmap);
		alias pal_get_parent_bitmap = ALLEGRO_BITMAP* function(ALLEGRO_BITMAP* bitmap);
		alias pal_get_bitmap_x = int function(ALLEGRO_BITMAP* bitmap);
		alias pal_get_bitmap_y = int function(ALLEGRO_BITMAP* bitmap);
		alias pal_reparent_bitmap = void function(ALLEGRO_BITMAP* bitmap, ALLEGRO_BITMAP* parent, int x, int y, int w, int h);

		alias pal_clone_bitmap = ALLEGRO_BITMAP* function(ALLEGRO_BITMAP* bitmap);
		alias pal_convert_bitmap = void function(ALLEGRO_BITMAP* bitmap);
		alias pal_convert_memory_bitmaps = void function();
	}
	
	__gshared {
		pal_set_new_bitmap_format al_set_new_bitmap_format;
		pal_set_new_bitmap_flags al_set_new_bitmap_flags;
		pal_get_new_bitmap_format al_get_new_bitmap_format;
		pal_get_new_bitmap_flags al_get_new_bitmap_flags;
		pal_add_new_bitmap_flag al_add_new_bitmap_flag;

		pal_get_bitmap_width al_get_bitmap_width;
		pal_get_bitmap_height al_get_bitmap_height;
		pal_get_bitmap_format al_get_bitmap_format;
		pal_get_bitmap_flags al_get_bitmap_flags;

		pal_create_bitmap al_create_bitmap;
		pal_destroy_bitmap al_destroy_bitmap;

		pal_put_pixel al_put_pixel;
		pal_put_blended_pixel al_put_blended_pixel;
		pal_get_pixel al_get_pixel;

		pal_convert_mask_to_alpha al_convert_mask_to_alpha;

		pal_set_clipping_rectangle al_set_clipping_rectangle;
		pal_reset_clipping_rectangle al_reset_clipping_rectangle;
		pal_get_clipping_rectangle al_get_clipping_rectangle;

		pal_create_sub_bitmap al_create_sub_bitmap;
		pal_is_sub_bitmap al_is_sub_bitmap;
		pal_get_parent_bitmap al_get_parent_bitmap;
		pal_get_bitmap_x al_get_bitmap_x;
		pal_get_bitmap_y al_get_bitmap_y;
		pal_reparent_bitmap al_reparent_bitmap;

		pal_clone_bitmap al_clone_bitmap;
		pal_convert_bitmap al_convert_bitmap;
		pal_convert_memory_bitmaps al_convert_memory_bitmaps;
	}
	
	version (ALLEGRO_UNSTABLE) {
		static if (allegro5Support >= Allegro5Support.v5_2_1) {
			extern(C) @nogc nothrow {
				alias pal_get_new_bitmap_depth = int function();
				alias pal_set_new_bitmap_depth = void function(int depth);
				alias pal_get_new_bitmap_samples = int function();
				alias pal_set_new_bitmap_samples = void function(int samples);
				alias pal_get_bitmap_depth = int function(ALLEGRO_BITMAP* bitmap);
				alias pal_get_bitmap_samples = int function(ALLEGRO_BITMAP* bitmap);
				alias pal_backup_dirty_bitmap = void function(ALLEGRO_BITMAP* bitmap);
			}
			__gshared {
				pal_get_new_bitmap_depth al_get_new_bitmap_depth;
				pal_set_new_bitmap_depth al_set_new_bitmap_depth;
				pal_get_new_bitmap_samples al_get_new_bitmap_samples;
				pal_set_new_bitmap_samples al_set_new_bitmap_samples;
				pal_get_bitmap_depth al_get_bitmap_depth;
				pal_get_bitmap_samples al_get_bitmap_samples;
				pal_backup_dirty_bitmap al_backup_dirty_bitmap;
			}
		}
			
		static if (allegro5Support >= Allegro5Support.v5_2_5) {
			extern(C) @nogc nothrow {
				alias pal_get_bitmap_blend_color = ALLEGRO_COLOR function();
				alias pal_get_bitmap_blender = void function(int* op, int* src, int* dst);
				alias pal_get_separate_bitmap_blender = void function(int* op, int* src, int* dst, int* alpha_op, int* alpha_src, int* alpha_dst);
				alias pal_set_bitmap_blend_color = void function(ALLEGRO_COLOR color);
				alias pal_set_bitmap_blender = void function(int op, int src, int dst);
				alias pal_set_separate_bitmap_blender = void function(int op, int src, int dst, int alpha_op, int alpha_src, int alpha_dst);
				alias pal_reset_bitmap_blender = void function();
			}
			__gshared {
				pal_get_bitmap_blend_color al_get_bitmap_blend_color;
				pal_get_bitmap_blender al_get_bitmap_blender;
				pal_get_separate_bitmap_blender al_get_separate_bitmap_blender;
				pal_set_bitmap_blend_color al_set_bitmap_blend_color;
				pal_set_bitmap_blender al_set_bitmap_blender;
				pal_set_separate_bitmap_blender al_set_separate_bitmap_blender;
				pal_reset_bitmap_blender al_reset_bitmap_blender;
			}
		}
			
		static if (allegro5Support >= Allegro5Support.v5_2_8) {
			extern(C) @nogc nothrow {
				alias pal_get_new_bitmap_wrap = void function(ALLEGRO_BITMAP_WRAP* u, ALLEGRO_BITMAP_WRAP* v);
				alias pal_set_new_bitmap_wrap = void function(ALLEGRO_BITMAP_WRAP u, ALLEGRO_BITMAP_WRAP v);
			}
			__gshared {
				pal_get_new_bitmap_wrap al_get_new_bitmap_wrap;
				pal_set_new_bitmap_wrap al_set_new_bitmap_wrap;
			}
		}

	}
	
}
