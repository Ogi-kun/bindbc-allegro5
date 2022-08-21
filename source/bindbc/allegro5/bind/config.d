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
	extern(C) @nogc nothrow {
		alias pal_create_config = ALLEGRO_CONFIG* function();
		alias pal_add_config_section = void function(ALLEGRO_CONFIG* config, const(char)* name);
		alias pal_set_config_value = void function(ALLEGRO_CONFIG* config, const(char)* section, const(char)* key, const(char)* value);
		alias pal_add_config_comment = void function(ALLEGRO_CONFIG* config, const(char)* section, const(char)* comment);
		alias pal_get_config_value = const(char)* function(const(ALLEGRO_CONFIG)* config, const(char)* section, const(char)* key);
		alias pal_load_config_file = ALLEGRO_CONFIG* function(const(char)* filename);
		alias pal_load_config_file_f = ALLEGRO_CONFIG* function(ALLEGRO_FILE* filename);
		alias pal_save_config_file = bool function(const(char)* filename, const(ALLEGRO_CONFIG)* config);
		alias pal_save_config_file_f = bool function(ALLEGRO_FILE* file, const(ALLEGRO_CONFIG)* config);
		alias pal_merge_config_into = void function(ALLEGRO_CONFIG* master, const(ALLEGRO_CONFIG)* add);
		alias pal_merge_config = ALLEGRO_CONFIG* function(const(ALLEGRO_CONFIG)* cfg1, const(ALLEGRO_CONFIG)* cfg2);
		alias pal_destroy_config = void function(ALLEGRO_CONFIG* config);
		alias pal_remove_config_section = bool function(ALLEGRO_CONFIG* config, const(char)* section);
		alias pal_remove_config_key = bool function(ALLEGRO_CONFIG* config, const(char)* section, const(char)* key);

		alias pal_get_first_config_section = const(char)* function(const(ALLEGRO_CONFIG)* config, ALLEGRO_CONFIG_SECTION** iterator);
		alias pal_get_next_config_section = const(char)* function(ALLEGRO_CONFIG_SECTION** iterator);
		alias pal_get_first_config_entry = const(char)* function(const(ALLEGRO_CONFIG)* config, const(char)* section, ALLEGRO_CONFIG_ENTRY** iterator);
		alias pal_get_next_config_entry = const(char)* function(ALLEGRO_CONFIG_ENTRY** iterator);
	}
	
	__gshared {
		pal_create_config al_create_config;
		pal_add_config_section al_add_config_section;
		pal_set_config_value al_set_config_value;
		pal_add_config_comment al_add_config_comment;
		pal_get_config_value al_get_config_value;
		pal_load_config_file al_load_config_file;
		pal_load_config_file_f al_load_config_file_f;
		pal_save_config_file al_save_config_file;
		pal_save_config_file_f al_save_config_file_f;
		pal_merge_config_into al_merge_config_into;
		pal_merge_config al_merge_config;
		pal_destroy_config al_destroy_config;
		pal_remove_config_section al_remove_config_section;
		pal_remove_config_key al_remove_config_key;

		pal_get_first_config_section al_get_first_config_section;
		pal_get_next_config_section al_get_next_config_section;
		pal_get_first_config_entry al_get_first_config_entry;
		pal_get_next_config_entry al_get_next_config_entry;
	}

}
