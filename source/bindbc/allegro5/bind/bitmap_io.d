module bindbc.allegro5.bind.bitmap_io;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import bindbc.allegro5.bind.file : ALLEGRO_FILE;

enum {
	ALLEGRO_KEEP_BITMAP_FORMAT       = 0x0002,
	ALLEGRO_NO_PREMULTIPLIED_ALPHA   = 0x0200,
	ALLEGRO_KEEP_INDEX               = 0x0800,
}

extern(C) @nogc nothrow {
	alias ALLEGRO_IIO_LOADER_FUNCTION = ALLEGRO_BITMAP* function(const(char)* filename, int flags);
	alias ALLEGRO_IIO_FS_LOADER_FUNCTION = ALLEGRO_BITMAP* function(ALLEGRO_FILE* fp, int flags);
	alias ALLEGRO_IIO_SAVER_FUNCTION = bool function(const(char)* filename, ALLEGRO_BITMAP* bitmap);
	alias ALLEGRO_IIO_FS_SAVER_FUNCTION = bool function(ALLEGRO_FILE* fp, ALLEGRO_BITMAP* bitmap);
	alias ALLEGRO_IIO_IDENTIFIER_FUNCTION = bool function(ALLEGRO_FILE* f);
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	bool al_register_bitmap_loader(const(char)* ext, ALLEGRO_IIO_LOADER_FUNCTION loader);
	bool al_register_bitmap_saver(const(char)* ext, ALLEGRO_IIO_SAVER_FUNCTION saver);
	bool al_register_bitmap_loader_f(const(char)* ext, ALLEGRO_IIO_FS_LOADER_FUNCTION fs_loader);
	bool al_register_bitmap_saver_f(const(char)* ext, ALLEGRO_IIO_FS_SAVER_FUNCTION fs_saver);
	bool al_register_bitmap_identifier(const(char)* ext, ALLEGRO_IIO_IDENTIFIER_FUNCTION identifier);
	ALLEGRO_BITMAP* al_load_bitmap(const(char)* filename);
	ALLEGRO_BITMAP* al_load_bitmap_flags(const(char)* filename, int flags);
	ALLEGRO_BITMAP* al_load_bitmap_f(ALLEGRO_FILE* fp, const(char)* ident);
	ALLEGRO_BITMAP* al_load_bitmap_flags_f(ALLEGRO_FILE* fp, const(char)* ident, int flags);
	bool al_save_bitmap(const(char)* filename, ALLEGRO_BITMAP* bitmap);
	bool al_save_bitmap_f(ALLEGRO_FILE* fp, const(char)* ident, ALLEGRO_BITMAP* bitmap);
	const(char)* al_identify_bitmap_f(ALLEGRO_FILE* fp);
	const(char)* al_identify_bitmap(const(char)* filename);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	bool al_register_bitmap_loader(const(char)* ext, ALLEGRO_IIO_LOADER_FUNCTION loader) => ptr_al_register_bitmap_loader(ext, loader);
	bool al_register_bitmap_saver(const(char)* ext, ALLEGRO_IIO_SAVER_FUNCTION saver) => ptr_al_register_bitmap_saver(ext, saver);
	bool al_register_bitmap_loader_f(const(char)* ext, ALLEGRO_IIO_FS_LOADER_FUNCTION fs_loader) => ptr_al_register_bitmap_loader_f(ext, fs_loader);
	bool al_register_bitmap_saver_f(const(char)* ext, ALLEGRO_IIO_FS_SAVER_FUNCTION fs_saver) => ptr_al_register_bitmap_saver_f(ext, fs_saver);
	bool al_register_bitmap_identifier(const(char)* ext, ALLEGRO_IIO_IDENTIFIER_FUNCTION identifier) => ptr_al_register_bitmap_identifier(ext, identifier);
	ALLEGRO_BITMAP* al_load_bitmap(const(char)* filename) => ptr_al_load_bitmap(filename);
	ALLEGRO_BITMAP* al_load_bitmap_flags(const(char)* filename, int flags) => ptr_al_load_bitmap_flags(filename, flags);
	ALLEGRO_BITMAP* al_load_bitmap_f(ALLEGRO_FILE* fp, const(char)* ident) => ptr_al_load_bitmap_f(fp, ident);
	ALLEGRO_BITMAP* al_load_bitmap_flags_f(ALLEGRO_FILE* fp, const(char)* ident, int flags) => ptr_al_load_bitmap_flags_f(fp, ident, flags);
	bool al_save_bitmap(const(char)* filename, ALLEGRO_BITMAP* bitmap) => ptr_al_save_bitmap(filename, bitmap);
	bool al_save_bitmap_f(ALLEGRO_FILE* fp, const(char)* ident, ALLEGRO_BITMAP* bitmap) => ptr_al_save_bitmap_f(fp, ident, bitmap);
	const(char)* al_identify_bitmap_f(ALLEGRO_FILE* fp) => ptr_al_identify_bitmap_f(fp);
	const(char)* al_identify_bitmap(const(char)* filename) => ptr_al_identify_bitmap(filename);

	package(bindbc.allegro5) __gshared {
		typeof(&al_register_bitmap_loader) ptr_al_register_bitmap_loader;
		typeof(&al_register_bitmap_saver) ptr_al_register_bitmap_saver;
		typeof(&al_register_bitmap_loader_f) ptr_al_register_bitmap_loader_f;
		typeof(&al_register_bitmap_saver_f) ptr_al_register_bitmap_saver_f;
		typeof(&al_register_bitmap_identifier) ptr_al_register_bitmap_identifier;
		typeof(&al_load_bitmap) ptr_al_load_bitmap;
		typeof(&al_load_bitmap_flags) ptr_al_load_bitmap_flags;
		typeof(&al_load_bitmap_f) ptr_al_load_bitmap_f;
		typeof(&al_load_bitmap_flags_f) ptr_al_load_bitmap_flags_f;
		typeof(&al_save_bitmap) ptr_al_save_bitmap;
		typeof(&al_save_bitmap_f) ptr_al_save_bitmap_f;
		typeof(&al_identify_bitmap_f) ptr_al_identify_bitmap_f;
		typeof(&al_identify_bitmap) ptr_al_identify_bitmap;
	}
}
