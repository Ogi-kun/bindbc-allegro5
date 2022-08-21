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

	int al_for_each_fs_entry(ALLEGRO_FS_ENTRY* dir, 
			int function(ALLEGRO_FS_ENTRY* entry, void* extra) callback, void* extra);

	const(ALLEGRO_FS_INTERFACE)* al_get_fs_interface();
	void al_set_fs_interface(const(ALLEGRO_FS_INTERFACE)* vtable);
	void al_set_standard_fs_interface();
}
else {

	extern(C) @nogc nothrow {
		alias pal_create_fs_entry = ALLEGRO_FS_ENTRY* function(const(char)* path);
		alias pal_destroy_fs_entry = void function(ALLEGRO_FS_ENTRY* e);
		alias pal_get_fs_entry_name = const(char)* function(ALLEGRO_FS_ENTRY* e);
		alias pal_update_fs_entry = bool function(ALLEGRO_FS_ENTRY* e);
		alias pal_get_fs_entry_mode = uint function(ALLEGRO_FS_ENTRY* e);
		alias pal_get_fs_entry_atime = time_t function(ALLEGRO_FS_ENTRY* e);
		alias pal_get_fs_entry_mtime = time_t function(ALLEGRO_FS_ENTRY* e);
		alias pal_get_fs_entry_ctime = time_t function(ALLEGRO_FS_ENTRY* e);
		alias pal_get_fs_entry_size = off_t function(ALLEGRO_FS_ENTRY* e);
		alias pal_fs_entry_exists = bool function(ALLEGRO_FS_ENTRY* e);
		alias pal_remove_fs_entry = bool function(ALLEGRO_FS_ENTRY* e);

		alias pal_open_directory = bool function(ALLEGRO_FS_ENTRY* e);
		alias pal_read_directory = ALLEGRO_FS_ENTRY* function(ALLEGRO_FS_ENTRY* e);
		alias pal_close_directory = bool function(ALLEGRO_FS_ENTRY* e);

		alias pal_filename_exists = bool function(const(char)* path);
		alias pal_remove_filename = bool function(const(char)* path);
		alias pal_get_current_directory = char* function();
		alias pal_change_directory = bool function(const(char)* path);
		alias pal_make_directory = bool function(const(char)* path);

		alias pal_open_fs_entry = ALLEGRO_FILE* function(ALLEGRO_FS_ENTRY* e, const(char)* mode);

		alias pal_for_each_fs_entry = int function(ALLEGRO_FS_ENTRY* dir, 
				int function(ALLEGRO_FS_ENTRY* entry, void* extra) callback, void* extra);

		alias pal_get_fs_interface = const(ALLEGRO_FS_INTERFACE)* function();
		alias pal_set_fs_interface = void function(const(ALLEGRO_FS_INTERFACE)* vtable);
		alias pal_set_standard_fs_interface = void function();
	}
	
	__gshared {
		pal_create_fs_entry al_create_fs_entry;
		pal_destroy_fs_entry al_destroy_fs_entry;
		pal_get_fs_entry_name al_get_fs_entry_name;
		pal_update_fs_entry al_update_fs_entry;
		pal_get_fs_entry_mode al_get_fs_entry_mode;
		pal_get_fs_entry_atime al_get_fs_entry_atime;
		pal_get_fs_entry_mtime al_get_fs_entry_mtime;
		pal_get_fs_entry_ctime al_get_fs_entry_ctime;
		pal_get_fs_entry_size al_get_fs_entry_size;
		pal_fs_entry_exists al_fs_entry_exists;
		pal_remove_fs_entry al_remove_fs_entry;

		pal_open_directory al_open_directory;
		pal_read_directory al_read_directory;
		pal_close_directory al_close_directory;

		pal_filename_exists al_filename_exists;
		pal_remove_filename al_remove_filename;
		pal_get_current_directory al_get_current_directory;
		pal_change_directory al_change_directory;
		pal_make_directory al_make_directory;

		pal_open_fs_entry al_open_fs_entry;

		pal_for_each_fs_entry al_for_each_fs_entry;

		pal_get_fs_interface al_get_fs_interface;
		pal_set_fs_interface al_set_fs_interface;
		pal_set_standard_fs_interface al_set_standard_fs_interface;
	}
}
