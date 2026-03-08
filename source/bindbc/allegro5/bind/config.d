module bindbc.allegro5.bind.config;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.file : ALLEGRO_FILE;

struct ALLEGRO_CONFIG;
struct ALLEGRO_CONFIG_SECTION;
struct ALLEGRO_CONFIG_ENTRY;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_CONFIG* al_create_config();
	void al_add_config_section(ALLEGRO_CONFIG* config, const(char)* name);
	void al_set_config_value(ALLEGRO_CONFIG* config, const(char)* section, const(char)* key, const(char)* value);
	void al_add_config_comment(ALLEGRO_CONFIG* config, const(char)* section, const(char)* comment);
	const(char)* al_get_config_value(const(ALLEGRO_CONFIG)* config, const(char)* section, const(char)* key);
	ALLEGRO_CONFIG* al_load_config_file(const(char)* filename);
	ALLEGRO_CONFIG* al_load_config_file_f(ALLEGRO_FILE* filename);
	bool al_save_config_file(const(char)* filename, const(ALLEGRO_CONFIG)* config);
	bool al_save_config_file_f(ALLEGRO_FILE* file, const(ALLEGRO_CONFIG)* config);
	void al_merge_config_into(ALLEGRO_CONFIG* master, const(ALLEGRO_CONFIG)* add);
	ALLEGRO_CONFIG* al_merge_config(const(ALLEGRO_CONFIG)* cfg1, const(ALLEGRO_CONFIG)* cfg2);
	void al_destroy_config(ALLEGRO_CONFIG* config);
	bool al_remove_config_section(ALLEGRO_CONFIG* config, const(char)* section);
	bool al_remove_config_key(ALLEGRO_CONFIG* config, const(char)* section, const(char)* key);

	const(char)* al_get_first_config_section(const(ALLEGRO_CONFIG)* config, ALLEGRO_CONFIG_SECTION** iterator);
	const(char)* al_get_next_config_section(ALLEGRO_CONFIG_SECTION** iterator);
	const(char)* al_get_first_config_entry(const(ALLEGRO_CONFIG)* config, const(char)* section, ALLEGRO_CONFIG_ENTRY** iterator);
	const(char)* al_get_next_config_entry(ALLEGRO_CONFIG_ENTRY** iterator);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	ALLEGRO_CONFIG* al_create_config() => ptr_al_create_config();
	void al_add_config_section(ALLEGRO_CONFIG* config, const(char)* name) => ptr_al_add_config_section(config, name);
	void al_set_config_value(ALLEGRO_CONFIG* config, const(char)* section, const(char)* key, const(char)* value) => ptr_al_set_config_value(config, section, key, value);
	void al_add_config_comment(ALLEGRO_CONFIG* config, const(char)* section, const(char)* comment) => ptr_al_add_config_comment(config, section, comment);
	const(char)* al_get_config_value(const(ALLEGRO_CONFIG)* config, const(char)* section, const(char)* key) => ptr_al_get_config_value(config, section, key);
	ALLEGRO_CONFIG* al_load_config_file(const(char)* filename) => ptr_al_load_config_file(filename);
	ALLEGRO_CONFIG* al_load_config_file_f(ALLEGRO_FILE* filename) => ptr_al_load_config_file_f(filename);
	bool al_save_config_file(const(char)* filename, const(ALLEGRO_CONFIG)* config) => ptr_al_save_config_file(filename, config);
	bool al_save_config_file_f(ALLEGRO_FILE* file, const(ALLEGRO_CONFIG)* config) => ptr_al_save_config_file_f(file, config);
	void al_merge_config_into(ALLEGRO_CONFIG* master, const(ALLEGRO_CONFIG)* add) => ptr_al_merge_config_into(master, add);
	ALLEGRO_CONFIG* al_merge_config(const(ALLEGRO_CONFIG)* cfg1, const(ALLEGRO_CONFIG)* cfg2) => ptr_al_merge_config(cfg1, cfg2);
	void al_destroy_config(ALLEGRO_CONFIG* config) => ptr_al_destroy_config(config);
	bool al_remove_config_section(ALLEGRO_CONFIG* config, const(char)* section) => ptr_al_remove_config_section(config, section);
	bool al_remove_config_key(ALLEGRO_CONFIG* config, const(char)* section, const(char)* key) => ptr_al_remove_config_key(config, section, key);

	const(char)* al_get_first_config_section(const(ALLEGRO_CONFIG)* config, ALLEGRO_CONFIG_SECTION** iterator) => ptr_al_get_first_config_section(config, iterator);
	const(char)* al_get_next_config_section(ALLEGRO_CONFIG_SECTION** iterator) => ptr_al_get_next_config_section(iterator);
	const(char)* al_get_first_config_entry(const(ALLEGRO_CONFIG)* config, const(char)* section, ALLEGRO_CONFIG_ENTRY** iterator) => ptr_al_get_first_config_entry(config, section, iterator);
	const(char)* al_get_next_config_entry(ALLEGRO_CONFIG_ENTRY** iterator) => ptr_al_get_next_config_entry(iterator);

	package(bindbc.allegro5) __gshared {
		typeof(&al_create_config) ptr_al_create_config;
		typeof(&al_add_config_section) ptr_al_add_config_section;
		typeof(&al_set_config_value) ptr_al_set_config_value;
		typeof(&al_add_config_comment) ptr_al_add_config_comment;
		typeof(&al_get_config_value) ptr_al_get_config_value;
		typeof(&al_load_config_file) ptr_al_load_config_file;
		typeof(&al_load_config_file_f) ptr_al_load_config_file_f;
		typeof(&al_save_config_file) ptr_al_save_config_file;
		typeof(&al_save_config_file_f) ptr_al_save_config_file_f;
		typeof(&al_merge_config_into) ptr_al_merge_config_into;
		typeof(&al_merge_config) ptr_al_merge_config;
		typeof(&al_destroy_config) ptr_al_destroy_config;
		typeof(&al_remove_config_section) ptr_al_remove_config_section;
		typeof(&al_remove_config_key) ptr_al_remove_config_key;

		typeof(&al_get_first_config_section) ptr_al_get_first_config_section;
		typeof(&al_get_next_config_section) ptr_al_get_next_config_section;
		typeof(&al_get_first_config_entry) ptr_al_get_first_config_entry;
		typeof(&al_get_next_config_entry) ptr_al_get_next_config_entry;
	}
}
