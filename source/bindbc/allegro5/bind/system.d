module bindbc.allegro5.bind.system;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.base : AL_ID;
import bindbc.allegro5.bind.config : ALLEGRO_CONFIG;
import bindbc.allegro5.bind.path : ALLEGRO_PATH;

struct ALLEGRO_SYSTEM;

static if (allegroSupport >= AllegroSupport.v5_2_5) {
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
	mixin ExpandEnum!ALLEGRO_SYSTEM_ID;
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

	alias al_atexit_callback = int function(void function());
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	bool al_install_system(int version_, al_atexit_callback atexit_ptr);
	void al_uninstall_system();
	bool al_is_system_installed();
	ALLEGRO_SYSTEM* al_get_system_driver();
	ALLEGRO_CONFIG* al_get_system_config();

	ALLEGRO_PATH* al_get_standard_path(int id);
	void al_set_exe_name(const(char)* path);

	void al_set_org_name(const(char)* org_name);
	void al_set_app_name(const(char)* app_name);
	const(char)* al_get_org_name();
	const(char)* al_get_app_name();

	bool al_inhibit_screensaver(bool inhibit);

	static if (allegroSupport >= AllegroSupport.v5_2_5) {
		ALLEGRO_SYSTEM_ID al_get_system_id();
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	bool al_install_system(int version_, al_atexit_callback atexit_ptr) => ptr_al_install_system(version_, atexit_ptr);
	void al_uninstall_system() => ptr_al_uninstall_system();
	bool al_is_system_installed() => ptr_al_is_system_installed();
	ALLEGRO_SYSTEM* al_get_system_driver() => ptr_al_get_system_driver();
	ALLEGRO_CONFIG* al_get_system_config() => ptr_al_get_system_config();

	ALLEGRO_PATH* al_get_standard_path(int id) => ptr_al_get_standard_path(id);
	void al_set_exe_name(const(char)* path) => ptr_al_set_exe_name(path);

	void al_set_org_name(const(char)* org_name) => ptr_al_set_org_name(org_name);
	void al_set_app_name(const(char)* app_name) => ptr_al_set_app_name(app_name);
	const(char)* al_get_org_name() => ptr_al_get_org_name();
	const(char)* al_get_app_name() => ptr_al_get_app_name();

	bool al_inhibit_screensaver(bool inhibit) => ptr_al_inhibit_screensaver(inhibit);

	static if (allegroSupport >= AllegroSupport.v5_2_5) {
		ALLEGRO_SYSTEM_ID al_get_system_id() => ptr_al_get_system_id();
	}

	package(bindbc.allegro5) __gshared {
		typeof(&al_install_system) ptr_al_install_system;
		typeof(&al_uninstall_system) ptr_al_uninstall_system;
		typeof(&al_is_system_installed) ptr_al_is_system_installed;
		typeof(&al_get_system_driver) ptr_al_get_system_driver;
		typeof(&al_get_system_config) ptr_al_get_system_config;

		typeof(&al_get_standard_path) ptr_al_get_standard_path;
		typeof(&al_set_exe_name) ptr_al_set_exe_name;

		typeof(&al_set_org_name) ptr_al_set_org_name;
		typeof(&al_set_app_name) ptr_al_set_app_name;
		typeof(&al_get_org_name) ptr_al_get_org_name;
		typeof(&al_get_app_name) ptr_al_get_app_name;

		typeof(&al_inhibit_screensaver) ptr_al_inhibit_screensaver;

		static if (allegroSupport >= AllegroSupport.v5_2_5) {
			typeof(&al_get_system_id) ptr_al_get_system_id;
		}
	}
}
