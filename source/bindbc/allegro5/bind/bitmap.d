module bindbc.allegro5.bind.bitmap;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.color : ALLEGRO_COLOR;

struct ALLEGRO_BITMAP;

version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_8) {
	enum ALLEGRO_BITMAP_WRAP {
		ALLEGRO_BITMAP_WRAP_DEFAULT = 0,
		ALLEGRO_BITMAP_WRAP_REPEAT = 1,
		ALLEGRO_BITMAP_WRAP_CLAMP = 2,
		ALLEGRO_BITMAP_WRAP_MIRROR = 3,
	}
	mixin ExpandEnum!ALLEGRO_BITMAP_WRAP;
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
		static if (allegroSupport >= AllegroSupport.v5_2_1) {
			int al_get_new_bitmap_depth();
			void al_set_new_bitmap_depth(int depth);
			int al_get_new_bitmap_samples();
			void al_set_new_bitmap_samples(int samples);
			int al_get_bitmap_depth(ALLEGRO_BITMAP* bitmap);
			int al_get_bitmap_samples(ALLEGRO_BITMAP* bitmap);
			void al_backup_dirty_bitmap(ALLEGRO_BITMAP* bitmap);
		}

		static if (allegroSupport >= AllegroSupport.v5_2_5) {
			ALLEGRO_COLOR al_get_bitmap_blend_color();
			void al_get_bitmap_blender(int* op, int* src, int* dst);
			void al_get_separate_bitmap_blender(int* op, int* src, int* dst, int* alpha_op, int* alpha_src, int* alpha_dst);
			void al_set_bitmap_blend_color(ALLEGRO_COLOR color);
			void al_set_bitmap_blender(int op, int src, int dst);
			void al_set_separate_bitmap_blender(int op, int src, int dst, int alpha_op, int alpha_src, int alpha_dst);
			void al_reset_bitmap_blender();
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			void al_get_new_bitmap_wrap(ALLEGRO_BITMAP_WRAP* u, ALLEGRO_BITMAP_WRAP* v);
			void al_set_new_bitmap_wrap(ALLEGRO_BITMAP_WRAP u, ALLEGRO_BITMAP_WRAP v);
		}
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	void al_set_new_bitmap_format(int format) => ptr_al_set_new_bitmap_format(format);
	void al_set_new_bitmap_flags(int flags) => ptr_al_set_new_bitmap_flags(flags);
	int al_get_new_bitmap_format() => ptr_al_get_new_bitmap_format();
	int al_get_new_bitmap_flags() => ptr_al_get_new_bitmap_flags();
	void al_add_new_bitmap_flag(int flag) => ptr_al_add_new_bitmap_flag(flag);

	int al_get_bitmap_width(ALLEGRO_BITMAP* bitmap) => ptr_al_get_bitmap_width(bitmap);
	int al_get_bitmap_height(ALLEGRO_BITMAP* bitmap) => ptr_al_get_bitmap_height(bitmap);
	int al_get_bitmap_format(ALLEGRO_BITMAP* bitmap) => ptr_al_get_bitmap_format(bitmap);
	int al_get_bitmap_flags(ALLEGRO_BITMAP* bitmap) => ptr_al_get_bitmap_flags(bitmap);

	ALLEGRO_BITMAP* al_create_bitmap(int w, int h) => ptr_al_create_bitmap(w, h);
	void al_destroy_bitmap(ALLEGRO_BITMAP* bitmap) => ptr_al_destroy_bitmap(bitmap);

	void al_put_pixel(int x, int y, ALLEGRO_COLOR color) => ptr_al_put_pixel(x, y, color);
	void al_put_blended_pixel(int x, int y, ALLEGRO_COLOR color) => ptr_al_put_blended_pixel(x, y, color);
	ALLEGRO_COLOR al_get_pixel(ALLEGRO_BITMAP* bitmap, int x, int y) => ptr_al_get_pixel(bitmap, x, y);

	void al_convert_mask_to_alpha(ALLEGRO_BITMAP* bitmap, ALLEGRO_COLOR mask_color) => ptr_al_convert_mask_to_alpha(bitmap, mask_color);

	void al_set_clipping_rectangle(int x, int y, int width, int height) => ptr_al_set_clipping_rectangle(x, y, width, height);
	void al_reset_clipping_rectangle() => ptr_al_reset_clipping_rectangle();
	void al_get_clipping_rectangle(int* x, int* y, int* w, int* h) => ptr_al_get_clipping_rectangle(x, y, w, h);

	ALLEGRO_BITMAP* al_create_sub_bitmap(ALLEGRO_BITMAP* parent, int x, int y, int w, int h) => ptr_al_create_sub_bitmap(parent, x, y, w, h);
	bool al_is_sub_bitmap(ALLEGRO_BITMAP* bitmap) => ptr_al_is_sub_bitmap(bitmap);
	ALLEGRO_BITMAP* al_get_parent_bitmap(ALLEGRO_BITMAP* bitmap) => ptr_al_get_parent_bitmap(bitmap);
	int al_get_bitmap_x(ALLEGRO_BITMAP* bitmap) => ptr_al_get_bitmap_x(bitmap);
	int al_get_bitmap_y(ALLEGRO_BITMAP* bitmap) => ptr_al_get_bitmap_y(bitmap);
	void al_reparent_bitmap(ALLEGRO_BITMAP* bitmap, ALLEGRO_BITMAP* parent, int x, int y, int w, int h) => ptr_al_reparent_bitmap(bitmap, parent, x, y, w, h);

	ALLEGRO_BITMAP* al_clone_bitmap(ALLEGRO_BITMAP* bitmap) => ptr_al_clone_bitmap(bitmap);
	void al_convert_bitmap(ALLEGRO_BITMAP* bitmap) => ptr_al_convert_bitmap(bitmap);
	void al_convert_memory_bitmaps() => ptr_al_convert_memory_bitmaps();

	version (ALLEGRO_UNSTABLE) {
		static if (allegroSupport >= AllegroSupport.v5_2_1) {
			int al_get_new_bitmap_depth() => ptr_al_get_new_bitmap_depth();
			void al_set_new_bitmap_depth(int depth) => ptr_al_set_new_bitmap_depth(depth);
			int al_get_new_bitmap_samples() => ptr_al_get_new_bitmap_samples();
			void al_set_new_bitmap_samples(int samples) => ptr_al_set_new_bitmap_samples(samples);
			int al_get_bitmap_depth(ALLEGRO_BITMAP* bitmap) => ptr_al_get_bitmap_depth(bitmap);
			int al_get_bitmap_samples(ALLEGRO_BITMAP* bitmap) => ptr_al_get_bitmap_samples(bitmap);
			void al_backup_dirty_bitmap(ALLEGRO_BITMAP* bitmap) => ptr_al_backup_dirty_bitmap(bitmap);
		}

		static if (allegroSupport >= AllegroSupport.v5_2_5) {
			ALLEGRO_COLOR al_get_bitmap_blend_color() => ptr_al_get_bitmap_blend_color();
			void al_get_bitmap_blender(int* op, int* src, int* dst) => ptr_al_get_bitmap_blender(op, src, dst);
			void al_get_separate_bitmap_blender(int* op, int* src, int* dst, int* alpha_op, int* alpha_src, int* alpha_dst) => ptr_al_get_separate_bitmap_blender(op, src, dst, alpha_op, alpha_src, alpha_dst);
			void al_set_bitmap_blend_color(ALLEGRO_COLOR color) => ptr_al_set_bitmap_blend_color(color);
			void al_set_bitmap_blender(int op, int src, int dst) => ptr_al_set_bitmap_blender(op, src, dst);
			void al_set_separate_bitmap_blender(int op, int src, int dst, int alpha_op, int alpha_src, int alpha_dst) => ptr_al_set_separate_bitmap_blender(op, src, dst, alpha_op, alpha_src, alpha_dst);
			void al_reset_bitmap_blender() => ptr_al_reset_bitmap_blender();
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			void al_get_new_bitmap_wrap(ALLEGRO_BITMAP_WRAP* u, ALLEGRO_BITMAP_WRAP* v) => ptr_al_get_new_bitmap_wrap(u, v);
			void al_set_new_bitmap_wrap(ALLEGRO_BITMAP_WRAP u, ALLEGRO_BITMAP_WRAP v) => ptr_al_set_new_bitmap_wrap(u, v);
		}
	}

	package(bindbc.allegro5) __gshared {
		typeof(&al_set_new_bitmap_format) ptr_al_set_new_bitmap_format;
		typeof(&al_set_new_bitmap_flags) ptr_al_set_new_bitmap_flags;
		typeof(&al_get_new_bitmap_format) ptr_al_get_new_bitmap_format;
		typeof(&al_get_new_bitmap_flags) ptr_al_get_new_bitmap_flags;
		typeof(&al_add_new_bitmap_flag) ptr_al_add_new_bitmap_flag;

		typeof(&al_get_bitmap_width) ptr_al_get_bitmap_width;
		typeof(&al_get_bitmap_height) ptr_al_get_bitmap_height;
		typeof(&al_get_bitmap_format) ptr_al_get_bitmap_format;
		typeof(&al_get_bitmap_flags) ptr_al_get_bitmap_flags;

		typeof(&al_create_bitmap) ptr_al_create_bitmap;
		typeof(&al_destroy_bitmap) ptr_al_destroy_bitmap;

		typeof(&al_put_pixel) ptr_al_put_pixel;
		typeof(&al_put_blended_pixel) ptr_al_put_blended_pixel;
		typeof(&al_get_pixel) ptr_al_get_pixel;

		typeof(&al_convert_mask_to_alpha) ptr_al_convert_mask_to_alpha;

		typeof(&al_set_clipping_rectangle) ptr_al_set_clipping_rectangle;
		typeof(&al_reset_clipping_rectangle) ptr_al_reset_clipping_rectangle;
		typeof(&al_get_clipping_rectangle) ptr_al_get_clipping_rectangle;

		typeof(&al_create_sub_bitmap) ptr_al_create_sub_bitmap;
		typeof(&al_is_sub_bitmap) ptr_al_is_sub_bitmap;
		typeof(&al_get_parent_bitmap) ptr_al_get_parent_bitmap;
		typeof(&al_get_bitmap_x) ptr_al_get_bitmap_x;
		typeof(&al_get_bitmap_y) ptr_al_get_bitmap_y;
		typeof(&al_reparent_bitmap) ptr_al_reparent_bitmap;

		typeof(&al_clone_bitmap) ptr_al_clone_bitmap;
		typeof(&al_convert_bitmap) ptr_al_convert_bitmap;
		typeof(&al_convert_memory_bitmaps) ptr_al_convert_memory_bitmaps;

		version (ALLEGRO_UNSTABLE) {
			static if (allegroSupport >= AllegroSupport.v5_2_1) {
				typeof(&al_get_new_bitmap_depth) ptr_al_get_new_bitmap_depth;
				typeof(&al_set_new_bitmap_depth) ptr_al_set_new_bitmap_depth;
				typeof(&al_get_new_bitmap_samples) ptr_al_get_new_bitmap_samples;
				typeof(&al_set_new_bitmap_samples) ptr_al_set_new_bitmap_samples;
				typeof(&al_get_bitmap_depth) ptr_al_get_bitmap_depth;
				typeof(&al_get_bitmap_samples) ptr_al_get_bitmap_samples;
				typeof(&al_backup_dirty_bitmap) ptr_al_backup_dirty_bitmap;
			}

			static if (allegroSupport >= AllegroSupport.v5_2_5) {
				typeof(&al_get_bitmap_blend_color) ptr_al_get_bitmap_blend_color;
				typeof(&al_get_bitmap_blender) ptr_al_get_bitmap_blender;
				typeof(&al_get_separate_bitmap_blender) ptr_al_get_separate_bitmap_blender;
				typeof(&al_set_bitmap_blend_color) ptr_al_set_bitmap_blend_color;
				typeof(&al_set_bitmap_blender) ptr_al_set_bitmap_blender;
				typeof(&al_set_separate_bitmap_blender) ptr_al_set_separate_bitmap_blender;
				typeof(&al_reset_bitmap_blender) ptr_al_reset_bitmap_blender;
			}

			static if (allegroSupport >= AllegroSupport.v5_2_8) {
				typeof(&al_get_new_bitmap_wrap) ptr_al_get_new_bitmap_wrap;
				typeof(&al_set_new_bitmap_wrap) ptr_al_set_new_bitmap_wrap;
			}
		}
	}
}
