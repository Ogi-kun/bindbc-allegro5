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
	extern(C) @nogc nothrow {
		alias pal_register_bitmap_loader = bool function(const(char)* ext, ALLEGRO_IIO_LOADER_FUNCTION loader);
		alias pal_register_bitmap_saver = bool function(const(char)* ext, ALLEGRO_IIO_SAVER_FUNCTION saver);
		alias pal_register_bitmap_loader_f = bool function(const(char)* ext, ALLEGRO_IIO_FS_LOADER_FUNCTION fs_loader);
		alias pal_register_bitmap_saver_f = bool function(const(char)* ext, ALLEGRO_IIO_FS_SAVER_FUNCTION fs_saver);
		alias pal_register_bitmap_identifier = bool function(const(char)* ext, ALLEGRO_IIO_IDENTIFIER_FUNCTION identifier);
		alias pal_load_bitmap = ALLEGRO_BITMAP* function(const(char)* filename);
		alias pal_load_bitmap_flags = ALLEGRO_BITMAP* function(const(char)* filename, int flags);
		alias pal_load_bitmap_f = ALLEGRO_BITMAP* function(ALLEGRO_FILE* fp, const(char)* ident);
		alias pal_load_bitmap_flags_f = ALLEGRO_BITMAP* function(ALLEGRO_FILE* fp, const(char)* ident, int flags);
		alias pal_save_bitmap = bool function(const(char)* filename, ALLEGRO_BITMAP* bitmap);
		alias pal_save_bitmap_f = bool function(ALLEGRO_FILE* fp, const(char)* ident, ALLEGRO_BITMAP* bitmap);
		alias pal_identify_bitmap_f = const(char)* function(ALLEGRO_FILE* fp);
		alias pal_identify_bitmap = const(char)* function(const(char)* filename);
	}
	__gshared {
		pal_register_bitmap_loader al_register_bitmap_loader;
		pal_register_bitmap_saver al_register_bitmap_saver;
		pal_register_bitmap_loader_f al_register_bitmap_loader_f;
		pal_register_bitmap_saver_f al_register_bitmap_saver_f;
		pal_register_bitmap_identifier al_register_bitmap_identifier;
		pal_load_bitmap al_load_bitmap;
		pal_load_bitmap_flags al_load_bitmap_flags;
		pal_load_bitmap_f al_load_bitmap_f;
		pal_load_bitmap_flags_f al_load_bitmap_flags_f;
		pal_save_bitmap al_save_bitmap;
		pal_save_bitmap_f al_save_bitmap_f;
		pal_identify_bitmap_f al_identify_bitmap_f;
		pal_identify_bitmap al_identify_bitmap;
	}
}
