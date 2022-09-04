module bindbc.allegro5.bind.file;

import core.stdc.stdarg : va_list;
import bindbc.allegro5.config;
import bindbc.allegro5.bind.utf8 : ALLEGRO_USTR;
import bindbc.allegro5.bind.path : ALLEGRO_PATH;
version (Posix) {
	import core.sys.posix.sys.types : posix_off_t = off_t;
	alias off_t = posix_off_t;
}
else {
	alias off_t = uint;
}

struct ALLEGRO_FILE;

struct ALLEGRO_FILE_INTERFACE {
	void* function(const char *path, const char *mode) fi_fopen;
	bool function(ALLEGRO_FILE *handle) fi_fclose;
	size_t function(ALLEGRO_FILE *f, void *ptr, size_t size) fi_fread;
	size_t function(ALLEGRO_FILE *f, const void *ptr, size_t size) fi_fwrite;
	bool function(ALLEGRO_FILE *f) fi_fflush;
	long function(ALLEGRO_FILE *f) fi_ftell;
	bool function(ALLEGRO_FILE *f, long offset, int whence) fi_fseek;
	bool function(ALLEGRO_FILE *f) fi_feof;
	int function(ALLEGRO_FILE *f) fi_ferror;
	const(char)* function(ALLEGRO_FILE *f) fi_ferrmsg;
	void function(ALLEGRO_FILE *f) fi_fclearerr;
	int function(ALLEGRO_FILE *f, int c) fi_fungetc;
	off_t function(ALLEGRO_FILE *f) fi_fsize;
}

enum ALLEGRO_SEEK {
	ALLEGRO_SEEK_SET = 0,
	ALLEGRO_SEEK_CUR,
	ALLEGRO_SEEK_END
}
mixin ExpandEnum!ALLEGRO_SEEK;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_FILE* al_fopen(const(char)* path, const(char)* mode);
	ALLEGRO_FILE* al_fopen_interface(const(ALLEGRO_FILE_INTERFACE)* vt, const(char)* path, const(char)* mode);
	ALLEGRO_FILE* al_create_file_handle(const(ALLEGRO_FILE_INTERFACE)* vt, void* userdata);
	bool al_fclose(ALLEGRO_FILE* f);
	size_t al_fread(ALLEGRO_FILE* f, void* ptr, size_t size);
	size_t al_fwrite(ALLEGRO_FILE* f, const(void)* ptr, size_t size);
	bool al_fflush(ALLEGRO_FILE* f);
	long al_ftell(ALLEGRO_FILE* f);
	bool al_fseek(ALLEGRO_FILE* f, long offset, int whence);
	bool al_feof(ALLEGRO_FILE* f);
	int al_ferror(ALLEGRO_FILE* f);
	const(char)*  al_ferrmsg(ALLEGRO_FILE* f);
	void al_fclearerr(ALLEGRO_FILE* f);
	int al_fungetc(ALLEGRO_FILE* f, int c);
	long al_fsize(ALLEGRO_FILE* f);

	int al_fgetc(ALLEGRO_FILE* f);
	int al_fputc(ALLEGRO_FILE* f, int c);
	short al_fread16le(ALLEGRO_FILE* f);
	short al_fread16be(ALLEGRO_FILE* f);
	size_t al_fwrite16le(ALLEGRO_FILE* f, short w);
	size_t al_fwrite16be(ALLEGRO_FILE* f, short w);
	int al_fread32le(ALLEGRO_FILE* f);
	int al_fread32be(ALLEGRO_FILE* f);
	size_t al_fwrite32le(ALLEGRO_FILE* f, int l);
	size_t al_fwrite32be(ALLEGRO_FILE* f, int l);
	char* al_fgets(ALLEGRO_FILE* f, const(char)* p, size_t max);
	ALLEGRO_USTR* al_fget_ustr(ALLEGRO_FILE* f);
	int al_fputs(ALLEGRO_FILE* f, const(char)* p);
	int al_fprintf(ALLEGRO_FILE* f, const(char)* format, ...);
	int al_vfprintf(ALLEGRO_FILE* f, const(char)* format, va_list args);

	ALLEGRO_FILE* al_fopen_fd(int fd, const(char)* mode);
	ALLEGRO_FILE* al_make_temp_file(const(char)* tmpl, ALLEGRO_PATH* *ret_path);

	ALLEGRO_FILE* al_fopen_slice(ALLEGRO_FILE* fp, size_t initial_size, const(char)* mode);

	const(ALLEGRO_FILE_INTERFACE)* al_get_new_file_interface();
	void al_set_new_file_interface(const(ALLEGRO_FILE_INTERFACE)* file_interface);
	void al_set_standard_file_interface();

	void* al_get_file_userdata(ALLEGRO_FILE* f);
}
else {
	extern(C) @nogc nothrow {
		alias pal_fopen = ALLEGRO_FILE* function(const(char)* path, const(char)* mode);
		alias pal_fopen_interface = ALLEGRO_FILE* function(const(ALLEGRO_FILE_INTERFACE)* vt, const(char)* path, const(char)* mode);
		alias pal_create_file_handle = ALLEGRO_FILE* function(const(ALLEGRO_FILE_INTERFACE)* vt, void* userdata);
		alias pal_fclose = bool function(ALLEGRO_FILE* f);
		alias pal_fread = size_t function(ALLEGRO_FILE* f, void* ptr, size_t size);
		alias pal_fwrite = size_t function(ALLEGRO_FILE* f, const(void)* ptr, size_t size);
		alias pal_fflush = bool function(ALLEGRO_FILE* f);
		alias pal_ftell = long function(ALLEGRO_FILE* f);
		alias pal_fseek = bool function(ALLEGRO_FILE* f, long offset, int whence);
		alias pal_feof = bool function(ALLEGRO_FILE* f);
		alias pal_ferror = int function(ALLEGRO_FILE* f);
		alias pal_ferrmsg = const(char)* function(ALLEGRO_FILE* f);
		alias pal_fclearerr = void function(ALLEGRO_FILE* f);
		alias pal_fungetc = int function(ALLEGRO_FILE* f, int c);
		alias pal_fsize = long function(ALLEGRO_FILE* f);

		alias pal_fgetc = int function(ALLEGRO_FILE* f);
		alias pal_fputc = int function(ALLEGRO_FILE* f, int c);
		alias pal_fread16le = short function(ALLEGRO_FILE* f);
		alias pal_fread16be = short function(ALLEGRO_FILE* f);
		alias pal_fwrite16le = size_t function(ALLEGRO_FILE* f, short w);
		alias pal_fwrite16be = size_t function(ALLEGRO_FILE* f, short w);
		alias pal_fread32le = int function(ALLEGRO_FILE* f);
		alias pal_fread32be = int function(ALLEGRO_FILE* f);
		alias pal_fwrite32le = size_t function(ALLEGRO_FILE* f, int l);
		alias pal_fwrite32be = size_t function(ALLEGRO_FILE* f, int l);
		alias pal_fgets = char* function(ALLEGRO_FILE* f, const(char)* p, size_t max);
		alias pal_fget_ustr = ALLEGRO_USTR* function(ALLEGRO_FILE* f);
		alias pal_fputs = int function(ALLEGRO_FILE* f, const(char)* p);
		alias pal_fprintf = int function(ALLEGRO_FILE* f, const(char)* format, ...);
		alias pal_vfprintf = int function(ALLEGRO_FILE* f, const(char)* format, va_list args);

		alias pal_fopen_fd = ALLEGRO_FILE* function(int fd, const(char)* mode);
		alias pal_make_temp_file = ALLEGRO_FILE* function(const(char)* tmpl, ALLEGRO_PATH* *ret_path);

		alias pal_fopen_slice = ALLEGRO_FILE* function(ALLEGRO_FILE* fp, size_t initial_size, const(char)* mode);

		alias pal_get_new_file_interface = const(ALLEGRO_FILE_INTERFACE)* function();
		alias pal_set_new_file_interface = void function(const(ALLEGRO_FILE_INTERFACE)* file_interface);
		alias pal_set_standard_file_interface = void function();

		alias pal_get_file_userdata = void* function(ALLEGRO_FILE* f);
	}
	__gshared {
		pal_fopen al_fopen;
		pal_fopen_interface al_fopen_interface;
		pal_create_file_handle al_create_file_handle;
		pal_fclose al_fclose;
		pal_fread al_fread;
		pal_fwrite al_fwrite;
		pal_fflush al_fflush;
		pal_ftell al_ftell;
		pal_fseek al_fseek;
		pal_feof al_feof;
		pal_ferror al_ferror;
		pal_ferrmsg al_ferrmsg;
		pal_fclearerr al_fclearerr;
		pal_fungetc al_fungetc;
		pal_fsize al_fsize;

		pal_fgetc al_fgetc;
		pal_fputc al_fputc;
		pal_fread16le al_fread16le;
		pal_fread16be al_fread16be;
		pal_fwrite16le al_fwrite16le;
		pal_fwrite16be al_fwrite16be;
		pal_fread32le al_fread32le;
		pal_fread32be al_fread32be;
		pal_fwrite32le al_fwrite32le;
		pal_fwrite32be al_fwrite32be;
		pal_fgets al_fgets;
		pal_fget_ustr al_fget_ustr;
		pal_fputs al_fputs;
		pal_fprintf al_fprintf;
		pal_vfprintf al_vfprintf;

		pal_fopen_fd al_fopen_fd;
		pal_make_temp_file al_make_temp_file;

		pal_fopen_slice al_fopen_slice;

		pal_get_new_file_interface al_get_new_file_interface;
		pal_set_new_file_interface al_set_new_file_interface;
		pal_set_standard_file_interface al_set_standard_file_interface;

		pal_get_file_userdata al_get_file_userdata;
	}
}
