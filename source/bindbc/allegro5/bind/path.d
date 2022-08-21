module bindbc.allegro5.bind.path;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.utf8 : ALLEGRO_USTR;

version (Windows) {
	enum ALLEGRO_NATIVE_PATH_SEP = '\\';
	enum ALLEGRO_NATIVE_DRIVE_SEP = ':';
}
else {
	enum ALLEGRO_NATIVE_PATH_SEP = '/';
	enum ALLEGRO_NATIVE_DRIVE_SEP = '\0';
}

struct ALLEGRO_PATH;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_PATH* al_create_path(const(char)* str);
	ALLEGRO_PATH* al_create_path_for_directory(const(char)* str);
	ALLEGRO_PATH* al_clone_path(const(ALLEGRO_PATH)* path);

	int al_get_path_num_components(const(ALLEGRO_PATH)* path);
	const(char)* al_get_path_component(const(ALLEGRO_PATH)* path, int i);
	void al_replace_path_component(ALLEGRO_PATH* path, int i, const(char)* s);
	void al_remove_path_component(ALLEGRO_PATH* path, int i);
	void al_insert_path_component(ALLEGRO_PATH* path, int i, const(char)* s);
	const(char)* al_get_path_tail(const(ALLEGRO_PATH)* path);
	void al_drop_path_tail(ALLEGRO_PATH* path);
	void al_append_path_component(ALLEGRO_PATH* path, const(char)* s);
	bool al_join_paths(ALLEGRO_PATH* path, const(ALLEGRO_PATH)* tail);
	bool al_rebase_path(const(ALLEGRO_PATH)* head, ALLEGRO_PATH* tail);
	const(char)* al_path_cstr(const(ALLEGRO_PATH)* path, char delim);
	const(ALLEGRO_USTR)* al_path_ustr(const(ALLEGRO_PATH)* path, char delim);
	void al_destroy_path(ALLEGRO_PATH* path);

	void al_set_path_drive(ALLEGRO_PATH* path, const(char)* drive);
	const(char)* al_get_path_drive(const(ALLEGRO_PATH)* path);

	void al_set_path_filename(ALLEGRO_PATH* path, const(char)* filename);
	const(char)* al_get_path_filename(const(ALLEGRO_PATH)* path);

	const(char)* al_get_path_extension(const(ALLEGRO_PATH)* path);
	bool al_set_path_extension(ALLEGRO_PATH* path, const(char)* extension);
	const(char)* al_get_path_basename(const(ALLEGRO_PATH)* path);

	bool al_make_path_canonical(ALLEGRO_PATH* path);
}
else {
	extern(C) @nogc nothrow {
		alias pal_create_path = ALLEGRO_PATH* function(const(char)* str);
		alias pal_create_path_for_directory = ALLEGRO_PATH* function(const(char)* str);
		alias pal_clone_path = ALLEGRO_PATH* function(const(ALLEGRO_PATH)* path);

		alias pal_get_path_num_components = int function(const(ALLEGRO_PATH)* path);
		alias pal_get_path_component = const(char)* function(const(ALLEGRO_PATH)* path, int i);
		alias pal_replace_path_component = void function(ALLEGRO_PATH* path, int i, const(char)* s);
		alias pal_remove_path_component = void function(ALLEGRO_PATH* path, int i);
		alias pal_insert_path_component = void function(ALLEGRO_PATH* path, int i, const(char)* s);
		alias pal_get_path_tail = const(char)* function(const(ALLEGRO_PATH)* path);
		alias pal_drop_path_tail = void function(ALLEGRO_PATH* path);
		alias pal_append_path_component = void function(ALLEGRO_PATH* path, const(char)* s);
		alias pal_join_paths = bool function(ALLEGRO_PATH* path, const(ALLEGRO_PATH)* tail);
		alias pal_rebase_path = bool function(const(ALLEGRO_PATH)* head, ALLEGRO_PATH* tail);
		alias pal_path_cstr = const(char)* function(const(ALLEGRO_PATH)* path, char delim);
		alias pal_path_ustr = const(ALLEGRO_USTR)* function(const(ALLEGRO_PATH)* path, char delim);
		alias pal_destroy_path = void function(ALLEGRO_PATH* path);

		alias pal_set_path_drive = void function(ALLEGRO_PATH* path, const(char)* drive);
		alias pal_get_path_drive = const(char)* function(const(ALLEGRO_PATH)* path);

		alias pal_set_path_filename = void function(ALLEGRO_PATH* path, const(char)* filename);
		alias pal_get_path_filename = const(char)* function(const(ALLEGRO_PATH)* path);

		alias pal_get_path_extension = const(char)* function(const(ALLEGRO_PATH)* path);
		alias pal_set_path_extension = bool function(ALLEGRO_PATH* path, const(char)* extension);
		alias pal_get_path_basename = const(char)* function(const(ALLEGRO_PATH)* path);

		alias pal_make_path_canonical = bool function(ALLEGRO_PATH* path);
	}
	__gshared {
		pal_create_path al_create_path;
		pal_create_path_for_directory al_create_path_for_directory;
		pal_clone_path al_clone_path;

		pal_get_path_num_components al_get_path_num_components;
		pal_get_path_component al_get_path_component;
		pal_replace_path_component al_replace_path_component;
		pal_remove_path_component al_remove_path_component;
		pal_insert_path_component al_insert_path_component;
		pal_get_path_tail al_get_path_tail;
		pal_drop_path_tail al_drop_path_tail;
		pal_append_path_component al_append_path_component;
		pal_join_paths al_join_paths;
		pal_rebase_path al_rebase_path;
		pal_path_cstr al_path_cstr;
		pal_path_ustr al_path_ustr;
		pal_destroy_path al_destroy_path;

		pal_set_path_drive al_set_path_drive;
		pal_get_path_drive al_get_path_drive;

		pal_set_path_filename al_set_path_filename;
		pal_get_path_filename al_get_path_filename;

		pal_get_path_extension al_get_path_extension;
		pal_set_path_extension al_set_path_extension;
		pal_get_path_basename al_get_path_basename;

		pal_make_path_canonical al_make_path_canonical;
	}
}
