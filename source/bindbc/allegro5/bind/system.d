module bindbc.allegro5.bind.system;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.base : AL_ID;
import bindbc.allegro5.bind.config : ALLEGRO_CONFIG;
import bindbc.allegro5.bind.path : ALLEGRO_PATH;

struct ALLEGRO_SYSTEM;

enum ALLEGRO_SYSTEM_ID {
	ALLEGRO_SYSTEM_ID_UNKNOWN = 0,
	ALLEGRO_SYSTEM_ID_XGLX = AL_ID('X', 'G', 'L', 'X'),
	ALLEGRO_SYSTEM_ID_WINDOWS = AL_ID('W', 'I', 'N', 'D'),
	ALLEGRO_SYSTEM_ID_MACOSX = AL_ID('O', 'S', 'X', ' '),
	ALLEGRO_SYSTEM_ID_ANDROID = AL_ID('A', 'N', 'D', 'R'),
	ALLEGRO_SYSTEM_ID_IPHONE = AL_ID('I', 'P', 'H', 'O'),
	ALLEGRO_SYSTEM_ID_GP2XWIZ = AL_ID('W', 'I', 'Z', ' '),
	ALLEGRO_SYSTEM_ID_RASPBERRYPI = AL_ID('R', 'A', 'S', 'P'),
	ALLEGRO_SYSTEM_ID_SDL = AL_ID('S', 'D', 'L', '2')
}

enum {
	ALLEGRO_RESOURCES_PATH = 0,
	ALLEGRO_TEMP_PATH,
	ALLEGRO_USER_DATA_PATH,
	ALLEGRO_USER_HOME_PATH,
	ALLEGRO_USER_SETTINGS_PATH,
	ALLEGRO_USER_DOCUMENTS_PATH,
	ALLEGRO_EXENAME_PATH,
	ALLEGRO_LAST_PATH,
}

extern(C) @nogc nothrow {
	bool al_init() {
		import core.stdc.stdlib : atexit;
		import bindbc.allegro5.bind.base : ALLEGRO_VERSION_INT;
		return al_install_system(ALLEGRO_VERSION_INT, &atexit);
	}
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	bool al_install_system(int version_, int function(void function()) atexit_ptr);
	void al_uninstall_system();
	bool al_is_system_installed();
	ALLEGRO_SYSTEM* al_get_system_driver();
	ALLEGRO_CONFIG* al_get_system_config();
	ALLEGRO_SYSTEM_ID al_get_system_id();

	ALLEGRO_PATH* al_get_standard_path(int id);
	void al_set_exe_name(const(char)* path);

	void al_set_org_name(const(char)* org_name);
	void al_set_app_name(const(char)* app_name);
	const(char)* al_get_org_name();
	const(char)* al_get_app_name();

	bool al_inhibit_screensaver(bool inhibit);
}
else {
	extern(C) @nogc nothrow {
		alias pal_install_system = bool function(int version_, int function(void function()) atexit_ptr);
		alias pal_uninstall_system = void function();
		alias pal_is_system_installed = bool function();
		alias pal_get_system_driver = ALLEGRO_SYSTEM* function();
		alias pal_get_system_config = ALLEGRO_CONFIG* function();
		alias pal_get_system_id = ALLEGRO_SYSTEM_ID function();

		alias pal_get_standard_path = ALLEGRO_PATH* function(int id);
		alias pal_set_exe_name = void function(const(char)* path);

		alias pal_set_org_name = void function(const(char)* org_name);
		alias pal_set_app_name = void function(const(char)* app_name);
		alias pal_get_org_name = const(char)* function();
		alias pal_get_app_name = const(char)* function();

		alias pal_inhibit_screensaver = bool function(bool inhibit);
	}
	__gshared {
		pal_install_system al_install_system;
		pal_uninstall_system al_uninstall_system;
		pal_is_system_installed al_is_system_installed;
		pal_get_system_driver al_get_system_driver;
		pal_get_system_config al_get_system_config;
		pal_get_system_id al_get_system_id;

		pal_get_standard_path al_get_standard_path;
		pal_set_exe_name al_set_exe_name;

		pal_set_org_name al_set_org_name;
		pal_set_app_name al_set_app_name;
		pal_get_org_name al_get_org_name;
		pal_get_app_name al_get_app_name;

		pal_inhibit_screensaver al_inhibit_screensaver;
	}
}
