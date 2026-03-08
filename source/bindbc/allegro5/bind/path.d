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

	void al_destroy_path(ALLEGRO_PATH* path);

	void al_set_path_drive(ALLEGRO_PATH* path, const(char)* drive);
	const(char)* al_get_path_drive(const(ALLEGRO_PATH)* path);

	void al_set_path_filename(ALLEGRO_PATH* path, const(char)* filename);
	const(char)* al_get_path_filename(const(ALLEGRO_PATH)* path);

	const(char)* al_get_path_extension(const(ALLEGRO_PATH)* path);
	bool al_set_path_extension(ALLEGRO_PATH* path, const(char)* extension);
	const(char)* al_get_path_basename(const(ALLEGRO_PATH)* path);

	bool al_make_path_canonical(ALLEGRO_PATH* path);

	static if (allegroSupport >= AllegroSupport.v5_2_3) {
		const(ALLEGRO_USTR)* al_path_ustr(const(ALLEGRO_PATH)* path, char delim);
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	ALLEGRO_PATH* al_create_path(const(char)* str) => ptr_al_create_path(str);
	ALLEGRO_PATH* al_create_path_for_directory(const(char)* str) => ptr_al_create_path_for_directory(str);
	ALLEGRO_PATH* al_clone_path(const(ALLEGRO_PATH)* path) => ptr_al_clone_path(path);

	int al_get_path_num_components(const(ALLEGRO_PATH)* path) => ptr_al_get_path_num_components(path);
	const(char)* al_get_path_component(const(ALLEGRO_PATH)* path, int i) => ptr_al_get_path_component(path, i);
	void al_replace_path_component(ALLEGRO_PATH* path, int i, const(char)* s) => ptr_al_replace_path_component(path, i, s);
	void al_remove_path_component(ALLEGRO_PATH* path, int i) => ptr_al_remove_path_component(path, i);
	void al_insert_path_component(ALLEGRO_PATH* path, int i, const(char)* s) => ptr_al_insert_path_component(path, i, s);
	const(char)* al_get_path_tail(const(ALLEGRO_PATH)* path) => ptr_al_get_path_tail(path);
	void al_drop_path_tail(ALLEGRO_PATH* path) => ptr_al_drop_path_tail(path);
	void al_append_path_component(ALLEGRO_PATH* path, const(char)* s) => ptr_al_append_path_component(path, s);
	bool al_join_paths(ALLEGRO_PATH* path, const(ALLEGRO_PATH)* tail) => ptr_al_join_paths(path, tail);
	bool al_rebase_path(const(ALLEGRO_PATH)* head, ALLEGRO_PATH* tail) => ptr_al_rebase_path(head, tail);
	const(char)* al_path_cstr(const(ALLEGRO_PATH)* path, char delim) => ptr_al_path_cstr(path, delim);

	void al_destroy_path(ALLEGRO_PATH* path) => ptr_al_destroy_path(path);

	void al_set_path_drive(ALLEGRO_PATH* path, const(char)* drive) => ptr_al_set_path_drive(path, drive);
	const(char)* al_get_path_drive(const(ALLEGRO_PATH)* path) => ptr_al_get_path_drive(path);

	void al_set_path_filename(ALLEGRO_PATH* path, const(char)* filename) => ptr_al_set_path_filename(path, filename);
	const(char)* al_get_path_filename(const(ALLEGRO_PATH)* path) => ptr_al_get_path_filename(path);

	const(char)* al_get_path_extension(const(ALLEGRO_PATH)* path) => ptr_al_get_path_extension(path);
	bool al_set_path_extension(ALLEGRO_PATH* path, const(char)* extension) => ptr_al_set_path_extension(path, extension);
	const(char)* al_get_path_basename(const(ALLEGRO_PATH)* path) => ptr_al_get_path_basename(path);

	bool al_make_path_canonical(ALLEGRO_PATH* path) => ptr_al_make_path_canonical(path);

	static if (allegroSupport >= AllegroSupport.v5_2_3) {
		const(ALLEGRO_USTR)* al_path_ustr(const(ALLEGRO_PATH)* path, char delim) => ptr_al_path_ustr(path, delim);
	}

	package(bindbc.allegro5) __gshared {
		typeof(&al_create_path) ptr_al_create_path;
		typeof(&al_create_path_for_directory) ptr_al_create_path_for_directory;
		typeof(&al_clone_path) ptr_al_clone_path;

		typeof(&al_get_path_num_components) ptr_al_get_path_num_components;
		typeof(&al_get_path_component) ptr_al_get_path_component;
		typeof(&al_replace_path_component) ptr_al_replace_path_component;
		typeof(&al_remove_path_component) ptr_al_remove_path_component;
		typeof(&al_insert_path_component) ptr_al_insert_path_component;
		typeof(&al_get_path_tail) ptr_al_get_path_tail;
		typeof(&al_drop_path_tail) ptr_al_drop_path_tail;
		typeof(&al_append_path_component) ptr_al_append_path_component;
		typeof(&al_join_paths) ptr_al_join_paths;
		typeof(&al_rebase_path) ptr_al_rebase_path;
		typeof(&al_path_cstr) ptr_al_path_cstr;
		typeof(&al_destroy_path) ptr_al_destroy_path;

		typeof(&al_set_path_drive) ptr_al_set_path_drive;
		typeof(&al_get_path_drive) ptr_al_get_path_drive;

		typeof(&al_set_path_filename) ptr_al_set_path_filename;
		typeof(&al_get_path_filename) ptr_al_get_path_filename;

		typeof(&al_get_path_extension) ptr_al_get_path_extension;
		typeof(&al_set_path_extension) ptr_al_set_path_extension;
		typeof(&al_get_path_basename) ptr_al_get_path_basename;

		typeof(&al_make_path_canonical) ptr_al_make_path_canonical;

		static if (allegroSupport >= AllegroSupport.v5_2_3) {
			typeof(&al_path_ustr) ptr_al_path_ustr;
		}
	}
}
