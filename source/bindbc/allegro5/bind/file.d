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
	extern(C) @nogc nothrow:
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
	const(char)* al_ferrmsg(ALLEGRO_FILE* f);
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
	ALLEGRO_FILE* al_make_temp_file(const(char)* tmpl, ALLEGRO_PATH** ret_path);

	ALLEGRO_FILE* al_fopen_slice(ALLEGRO_FILE* fp, size_t initial_size, const(char)* mode);

	const(ALLEGRO_FILE_INTERFACE)* al_get_new_file_interface();
	void al_set_new_file_interface(const(ALLEGRO_FILE_INTERFACE)* file_interface);
	void al_set_standard_file_interface();

	void* al_get_file_userdata(ALLEGRO_FILE* f);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	ALLEGRO_FILE* al_fopen(const(char)* path, const(char)* mode) => ptr_al_fopen(path, mode);
	ALLEGRO_FILE* al_fopen_interface(const(ALLEGRO_FILE_INTERFACE)* vt, const(char)* path, const(char)* mode) => ptr_al_fopen_interface(vt, path, mode);
	ALLEGRO_FILE* al_create_file_handle(const(ALLEGRO_FILE_INTERFACE)* vt, void* userdata) => ptr_al_create_file_handle(vt, userdata);
	bool al_fclose(ALLEGRO_FILE* f) => ptr_al_fclose(f);
	size_t al_fread(ALLEGRO_FILE* f, void* ptr, size_t size) => ptr_al_fread(f, ptr, size);
	size_t al_fwrite(ALLEGRO_FILE* f, const(void)* ptr, size_t size) => ptr_al_fwrite(f,  ptr, size);
	bool al_fflush(ALLEGRO_FILE* f) => ptr_al_fflush(f);
	long al_ftell(ALLEGRO_FILE* f) => ptr_al_ftell(f);
	bool al_fseek(ALLEGRO_FILE* f, long offset, int whence) => ptr_al_fseek(f, offset, whence);
	bool al_feof(ALLEGRO_FILE* f) => ptr_al_feof(f);
	int al_ferror(ALLEGRO_FILE* f) => ptr_al_ferror(f);
	const(char)* al_ferrmsg(ALLEGRO_FILE* f) => ptr_al_ferrmsg(f);
	void al_fclearerr(ALLEGRO_FILE* f) => ptr_al_fclearerr(f);
	int al_fungetc(ALLEGRO_FILE* f, int c) => ptr_al_fungetc(f, c);
	long al_fsize(ALLEGRO_FILE* f) => ptr_al_fsize(f);

	int al_fgetc(ALLEGRO_FILE* f) => ptr_al_fgetc(f);
	int al_fputc(ALLEGRO_FILE* f, int c) => ptr_al_fputc(f, c);
	short al_fread16le(ALLEGRO_FILE* f) => ptr_al_fread16le(f);
	short al_fread16be(ALLEGRO_FILE* f) => ptr_al_fread16be(f);
	size_t al_fwrite16le(ALLEGRO_FILE* f, short w) => ptr_al_fwrite16le(f, w);
	size_t al_fwrite16be(ALLEGRO_FILE* f, short w) => ptr_al_fwrite16be(f, w);
	int al_fread32le(ALLEGRO_FILE* f) => ptr_al_fread32le(f);
	int al_fread32be(ALLEGRO_FILE* f) => ptr_al_fread32be(f);
	size_t al_fwrite32le(ALLEGRO_FILE* f, int l) => ptr_al_fwrite32le(f, l);
	size_t al_fwrite32be(ALLEGRO_FILE* f, int l) => ptr_al_fwrite32be(f, l);
	char* al_fgets(ALLEGRO_FILE* f, const(char)* p, size_t max) => ptr_al_fgets(f, p, max);
	ALLEGRO_USTR* al_fget_ustr(ALLEGRO_FILE* f) => ptr_al_fget_ustr(f);
	int al_fputs(ALLEGRO_FILE* f, const(char)* p) => ptr_al_fputs(f, p);
	int al_fprintf(ALLEGRO_FILE* f, const(char)* format, ...) => ptr_al_fprintf(__traits(parameters));
	int al_vfprintf(ALLEGRO_FILE* f, const(char)* format, va_list args) => ptr_al_vfprintf(f, format, args);

	ALLEGRO_FILE* al_fopen_fd(int fd, const(char)* mode) => ptr_al_fopen_fd(fd, mode);
	ALLEGRO_FILE* al_make_temp_file(const(char)* tmpl, ALLEGRO_PATH** ret_path) => ptr_al_make_temp_file(tmpl, ret_path);

	ALLEGRO_FILE* al_fopen_slice(ALLEGRO_FILE* fp, size_t initial_size, const(char)* mode) => ptr_al_fopen_slice(fp, initial_size, mode);

	const(ALLEGRO_FILE_INTERFACE)* al_get_new_file_interface() => ptr_al_get_new_file_interface();
	void al_set_new_file_interface(const(ALLEGRO_FILE_INTERFACE)* file_interface) => ptr_al_set_new_file_interface(file_interface);
	void al_set_standard_file_interface() => ptr_al_set_standard_file_interface();

	void* al_get_file_userdata(ALLEGRO_FILE* f) => ptr_al_get_file_userdata(f);

	package(bindbc.allegro5) __gshared {
		typeof(&al_fopen) ptr_al_fopen;
		typeof(&al_fopen_interface) ptr_al_fopen_interface;
		typeof(&al_create_file_handle) ptr_al_create_file_handle;
		typeof(&al_fclose) ptr_al_fclose;
		typeof(&al_fread) ptr_al_fread;
		typeof(&al_fwrite) ptr_al_fwrite;
		typeof(&al_fflush) ptr_al_fflush;
		typeof(&al_ftell) ptr_al_ftell;
		typeof(&al_fseek) ptr_al_fseek;
		typeof(&al_feof) ptr_al_feof;
		typeof(&al_ferror) ptr_al_ferror;
		typeof(&al_ferrmsg) ptr_al_ferrmsg;
		typeof(&al_fclearerr) ptr_al_fclearerr;
		typeof(&al_fungetc) ptr_al_fungetc;
		typeof(&al_fsize) ptr_al_fsize;

		typeof(&al_fgetc) ptr_al_fgetc;
		typeof(&al_fputc) ptr_al_fputc;
		typeof(&al_fread16le) ptr_al_fread16le;
		typeof(&al_fread16be) ptr_al_fread16be;
		typeof(&al_fwrite16le) ptr_al_fwrite16le;
		typeof(&al_fwrite16be) ptr_al_fwrite16be;
		typeof(&al_fread32le) ptr_al_fread32le;
		typeof(&al_fread32be) ptr_al_fread32be;
		typeof(&al_fwrite32le) ptr_al_fwrite32le;
		typeof(&al_fwrite32be) ptr_al_fwrite32be;
		typeof(&al_fgets) ptr_al_fgets;
		typeof(&al_fget_ustr) ptr_al_fget_ustr;
		typeof(&al_fputs) ptr_al_fputs;
		typeof(&al_fprintf) ptr_al_fprintf;
		typeof(&al_vfprintf) ptr_al_vfprintf;

		typeof(&al_fopen_fd) ptr_al_fopen_fd;
		typeof(&al_make_temp_file) ptr_al_make_temp_file;

		typeof(&al_fopen_slice) ptr_al_fopen_slice;

		typeof(&al_get_new_file_interface) ptr_al_get_new_file_interface;
		typeof(&al_set_new_file_interface) ptr_al_set_new_file_interface;
		typeof(&al_set_standard_file_interface) ptr_al_set_standard_file_interface;

		typeof(&al_get_file_userdata) ptr_al_get_file_userdata;
	}
}
