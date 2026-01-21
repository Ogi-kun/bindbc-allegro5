module bindbc.allegro5.bind.fshook;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.file : off_t, ALLEGRO_FILE;
import core.stdc.time : time_t;

struct ALLEGRO_FS_ENTRY {
	const(ALLEGRO_FS_INTERFACE)* vtable;
}

enum ALLEGRO_FILE_MODE {
	ALLEGRO_FILEMODE_READ    = 1,
	ALLEGRO_FILEMODE_WRITE   = 1 << 1,
	ALLEGRO_FILEMODE_EXECUTE = 1 << 2,
	ALLEGRO_FILEMODE_HIDDEN  = 1 << 3,
	ALLEGRO_FILEMODE_ISFILE  = 1 << 4,
	ALLEGRO_FILEMODE_ISDIR   = 1 << 5
}

enum EOF = -1;

enum ALLEGRO_FOR_EACH_FS_ENTRY_RESULT {
	ALLEGRO_FOR_EACH_FS_ENTRY_ERROR = -1,
	ALLEGRO_FOR_EACH_FS_ENTRY_OK    =  0,
	ALLEGRO_FOR_EACH_FS_ENTRY_SKIP  =  1,
	ALLEGRO_FOR_EACH_FS_ENTRY_STOP  =  2,
}


struct ALLEGRO_FS_INTERFACE {
	extern(C) @nogc nothrow:
	ALLEGRO_FS_ENTRY* function(const(char)* path) fs_create_entry;
	void function(ALLEGRO_FS_ENTRY* e) fs_destroy_entry;
	const(char)*  function(ALLEGRO_FS_ENTRY* e) fs_entry_name;
	bool function(ALLEGRO_FS_ENTRY* e) fs_update_entry;
	uint function(ALLEGRO_FS_ENTRY* e) fs_entry_mode;
	time_t function(ALLEGRO_FS_ENTRY* e) fs_entry_atime;
	time_t function(ALLEGRO_FS_ENTRY* e) fs_entry_mtime;
	time_t function(ALLEGRO_FS_ENTRY* e) fs_entry_ctime;
	off_t function(ALLEGRO_FS_ENTRY* e) fs_entry_size;
	bool function(ALLEGRO_FS_ENTRY* e) fs_entry_exists;
	bool function(ALLEGRO_FS_ENTRY* e) fs_remove_entry;

	bool function(ALLEGRO_FS_ENTRY* e) fs_open_directory;
	ALLEGRO_FS_ENTRY* function(ALLEGRO_FS_ENTRY* e) fs_read_directory;
	bool function(ALLEGRO_FS_ENTRY* e) fs_close_directory;

	bool function(const(char)* path) fs_filename_exists;
	bool function(const(char)* path) fs_remove_filename;
	char* function() fs_get_current_directory;
	bool function(const(char)* path) fs_change_directory;
	bool function(const(char)* path) fs_make_directory;

	ALLEGRO_FILE* function(ALLEGRO_FS_ENTRY* e, const(char)* mode) fs_open_file;
}

extern(C) @nogc nothrow {
	alias al_for_each_fs_entry_callback = int function(ALLEGRO_FS_ENTRY* entry, void* extra);
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_FS_ENTRY* al_create_fs_entry(const(char)* path);
	void al_destroy_fs_entry(ALLEGRO_FS_ENTRY* e);
	const(char)* al_get_fs_entry_name(ALLEGRO_FS_ENTRY* e);
	bool al_update_fs_entry(ALLEGRO_FS_ENTRY* e);
	uint al_get_fs_entry_mode(ALLEGRO_FS_ENTRY* e);
	time_t al_get_fs_entry_atime(ALLEGRO_FS_ENTRY* e);
	time_t al_get_fs_entry_mtime(ALLEGRO_FS_ENTRY* e);
	time_t al_get_fs_entry_ctime(ALLEGRO_FS_ENTRY* e);
	off_t al_get_fs_entry_size(ALLEGRO_FS_ENTRY* e);
	bool al_fs_entry_exists(ALLEGRO_FS_ENTRY* e);
	bool al_remove_fs_entry(ALLEGRO_FS_ENTRY* e);

	bool al_open_directory(ALLEGRO_FS_ENTRY* e);
	ALLEGRO_FS_ENTRY* al_read_directory(ALLEGRO_FS_ENTRY* e);
	bool al_close_directory(ALLEGRO_FS_ENTRY* e);

	bool al_filename_exists(const(char)* path);
	bool al_remove_filename(const(char)* path);
	char* al_get_current_directory();
	bool al_change_directory(const(char)* path);
	bool al_make_directory(const(char)* path);

	ALLEGRO_FILE* al_open_fs_entry(ALLEGRO_FS_ENTRY* e, const(char)* mode);

	int al_for_each_fs_entry(ALLEGRO_FS_ENTRY* dir, al_for_each_fs_entry_callback callback, void* extra);

	const(ALLEGRO_FS_INTERFACE)* al_get_fs_interface();
	void al_set_fs_interface(const(ALLEGRO_FS_INTERFACE)* vtable);
	void al_set_standard_fs_interface();
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	ALLEGRO_FS_ENTRY* al_create_fs_entry(const(char)* path) => ptr_al_create_fs_entry(path);
	void al_destroy_fs_entry(ALLEGRO_FS_ENTRY* e) => ptr_al_destroy_fs_entry(e);
	const(char)* al_get_fs_entry_name(ALLEGRO_FS_ENTRY* e) => ptr_al_get_fs_entry_name(e);
	bool al_update_fs_entry(ALLEGRO_FS_ENTRY* e) => ptr_al_update_fs_entry(e);
	uint al_get_fs_entry_mode(ALLEGRO_FS_ENTRY* e) => ptr_al_get_fs_entry_mode(e);
	time_t al_get_fs_entry_atime(ALLEGRO_FS_ENTRY* e) => ptr_al_get_fs_entry_atime(e);
	time_t al_get_fs_entry_mtime(ALLEGRO_FS_ENTRY* e) => ptr_al_get_fs_entry_mtime(e);
	time_t al_get_fs_entry_ctime(ALLEGRO_FS_ENTRY* e) => ptr_al_get_fs_entry_ctime(e);
	off_t al_get_fs_entry_size(ALLEGRO_FS_ENTRY* e) => ptr_al_get_fs_entry_size(e);
	bool al_fs_entry_exists(ALLEGRO_FS_ENTRY* e) => ptr_al_fs_entry_exists(e);
	bool al_remove_fs_entry(ALLEGRO_FS_ENTRY* e) => ptr_al_remove_fs_entry(e);

	bool al_open_directory(ALLEGRO_FS_ENTRY* e) => ptr_al_open_directory(e);
	ALLEGRO_FS_ENTRY* al_read_directory(ALLEGRO_FS_ENTRY* e) => ptr_al_read_directory(e);
	bool al_close_directory(ALLEGRO_FS_ENTRY* e) => ptr_al_close_directory(e);

	bool al_filename_exists(const(char)* path) => ptr_al_filename_exists(path);
	bool al_remove_filename(const(char)* path) => ptr_al_remove_filename(path);
	char* al_get_current_directory() => ptr_al_get_current_directory();
	bool al_change_directory(const(char)* path) => ptr_al_change_directory(path);
	bool al_make_directory(const(char)* path) => ptr_al_make_directory(path);

	ALLEGRO_FILE* al_open_fs_entry(ALLEGRO_FS_ENTRY* e, const(char)* mode) => ptr_al_open_fs_entry(e,  mode);

	int al_for_each_fs_entry(ALLEGRO_FS_ENTRY* dir, al_for_each_fs_entry_callback callback, void* extra) => ptr_al_for_each_fs_entry(dir, callback, extra);

	const(ALLEGRO_FS_INTERFACE)* al_get_fs_interface() => ptr_al_get_fs_interface();
	void al_set_fs_interface(const(ALLEGRO_FS_INTERFACE)* vtable) => ptr_al_set_fs_interface(vtable);
	void al_set_standard_fs_interface() => ptr_al_set_standard_fs_interface();

	package(bindbc.allegro5) __gshared {
		typeof(&al_create_fs_entry) ptr_al_create_fs_entry;
		typeof(&al_destroy_fs_entry) ptr_al_destroy_fs_entry;
		typeof(&al_get_fs_entry_name) ptr_al_get_fs_entry_name;
		typeof(&al_update_fs_entry) ptr_al_update_fs_entry;
		typeof(&al_get_fs_entry_mode) ptr_al_get_fs_entry_mode;
		typeof(&al_get_fs_entry_atime) ptr_al_get_fs_entry_atime;
		typeof(&al_get_fs_entry_mtime) ptr_al_get_fs_entry_mtime;
		typeof(&al_get_fs_entry_ctime) ptr_al_get_fs_entry_ctime;
		typeof(&al_get_fs_entry_size) ptr_al_get_fs_entry_size;
		typeof(&al_fs_entry_exists) ptr_al_fs_entry_exists;
		typeof(&al_remove_fs_entry) ptr_al_remove_fs_entry;

		typeof(&al_open_directory) ptr_al_open_directory;
		typeof(&al_read_directory) ptr_al_read_directory;
		typeof(&al_close_directory) ptr_al_close_directory;

		typeof(&al_filename_exists) ptr_al_filename_exists;
		typeof(&al_remove_filename) ptr_al_remove_filename;
		typeof(&al_get_current_directory) ptr_al_get_current_directory;
		typeof(&al_change_directory) ptr_al_change_directory;
		typeof(&al_make_directory) ptr_al_make_directory;

		typeof(&al_open_fs_entry) ptr_al_open_fs_entry;

		typeof(&al_for_each_fs_entry) ptr_al_for_each_fs_entry;

		typeof(&al_get_fs_interface) ptr_al_get_fs_interface;
		typeof(&al_set_fs_interface) ptr_al_set_fs_interface;
		typeof(&al_set_standard_fs_interface) ptr_al_set_standard_fs_interface;
	}
}
