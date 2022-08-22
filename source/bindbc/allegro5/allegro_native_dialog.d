module bindbc.allegro5.allegro_native_dialog;

import bindbc.allegro5.config;

static if (allegroDialog):

import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import bindbc.allegro5.bind.events : ALLEGRO_EVENT_SOURCE;

version (ALLEGRO_X11) {
	import bindbc.allegro5.bind.display : ALLEGRO_GTK_TOPLEVEL_INTERNAL;
	alias ALLEGRO_GTK_TOPLEVEL = ALLEGRO_GTK_TOPLEVEL_INTERNAL;
}

struct ALLEGRO_FILECHOOSER;

struct ALLEGRO_TEXTLOG;

struct ALLEGRO_MENU;

struct ALLEGRO_MENU_INFO {
	const(char)* caption;
	ushort id;
	int flags;
	ALLEGRO_BITMAP* icon;
}

enum {
	ALLEGRO_FILECHOOSER_FILE_MUST_EXIST = 1,
	ALLEGRO_FILECHOOSER_SAVE            = 2,
	ALLEGRO_FILECHOOSER_FOLDER          = 4,
	ALLEGRO_FILECHOOSER_PICTURES        = 8,
	ALLEGRO_FILECHOOSER_SHOW_HIDDEN     = 16,
	ALLEGRO_FILECHOOSER_MULTIPLE        = 32,
}

enum {
	ALLEGRO_MESSAGEBOX_WARN             = 1<<0,
	ALLEGRO_MESSAGEBOX_ERROR            = 1<<1,
	ALLEGRO_MESSAGEBOX_OK_CANCEL        = 1<<2,
	ALLEGRO_MESSAGEBOX_YES_NO           = 1<<3,
	ALLEGRO_MESSAGEBOX_QUESTION         = 1<<4,
}

enum {
	ALLEGRO_TEXTLOG_NO_CLOSE            = 1<<0,
	ALLEGRO_TEXTLOG_MONOSPACE           = 1<<1,
}

enum {
	ALLEGRO_EVENT_NATIVE_DIALOG_CLOSE   = 600,
	ALLEGRO_EVENT_MENU_CLICK            = 601,
}

enum {
	ALLEGRO_MENU_ITEM_ENABLED            = 0,
	ALLEGRO_MENU_ITEM_CHECKBOX           = 1,
	ALLEGRO_MENU_ITEM_CHECKED            = 2,
	ALLEGRO_MENU_ITEM_DISABLED           = 4,
}

enum ALLEGRO_MENU_SEPARATOR = ALLEGRO_MENU_INFO("", 0xFFFF, 0, null);

enum ALLEGRO_START_OF_MENU(string caption, uint id) = ALLEGRO_MENU_INFO(caption ~ "->", id, 0, null);

enum ALLEGRO_END_OF_MENU = ALLEGRO_MENU_INFO(null, 0, 0, null);

static if (staticBinding) {
	extern(C) @nogc nothrow:

	bool al_init_native_dialog_addon();
	void al_shutdown_native_dialog_addon();
	uint al_get_allegro_native_dialog_version();

	ALLEGRO_FILECHOOSER* al_create_native_file_dialog(const(char)* initial_path, const(char)* title, const(char)* patterns, int mode);
	bool al_show_native_file_dialog(ALLEGRO_DISPLAY* display, ALLEGRO_FILECHOOSER* dialog);
	int al_get_native_file_dialog_count(const(ALLEGRO_FILECHOOSER)* dialog);
	const(char)* al_get_native_file_dialog_path(const(ALLEGRO_FILECHOOSER)* dialog, size_t index);
	void al_destroy_native_file_dialog(ALLEGRO_FILECHOOSER* dialog);

	int al_show_native_message_box(ALLEGRO_DISPLAY* display, const(char)* title, const(char)* heading, const(char)* text, const(char)* buttons, int flags);

	ALLEGRO_TEXTLOG* al_open_native_text_log(const(char)* title, int flags);
	void al_close_native_text_log(ALLEGRO_TEXTLOG* textlog);
	void al_append_native_text_log(ALLEGRO_TEXTLOG* textlog, const(char)* format, ...);
	ALLEGRO_EVENT_SOURCE* al_get_native_text_log_event_source(ALLEGRO_TEXTLOG* textlog);

	ALLEGRO_MENU* al_create_menu();
	ALLEGRO_MENU* al_create_popup_menu();
	ALLEGRO_MENU* al_build_menu(ALLEGRO_MENU_INFO* info);
	int al_append_menu_item(ALLEGRO_MENU* parent, const(char)* title, ushort id, int flags, ALLEGRO_BITMAP* icon, ALLEGRO_MENU* submenu);
	int al_insert_menu_item(ALLEGRO_MENU* parent, int pos, const(char)* title, ushort id, int flags, ALLEGRO_BITMAP* icon, ALLEGRO_MENU* submenu);
	bool al_remove_menu_item(ALLEGRO_MENU* menu, int pos);
	ALLEGRO_MENU* al_clone_menu(ALLEGRO_MENU* menu);
	ALLEGRO_MENU* al_clone_menu_for_popup(ALLEGRO_MENU* menu);
	void al_destroy_menu(ALLEGRO_MENU* menu);

	const(char)* al_get_menu_item_caption(ALLEGRO_MENU* menu, int pos);
	void al_set_menu_item_caption(ALLEGRO_MENU* menu, int pos, const(char)* caption);
	int al_get_menu_item_flags(ALLEGRO_MENU* menu, int pos);
	void al_set_menu_item_flags(ALLEGRO_MENU* menu, int pos, int flags);
	ALLEGRO_BITMAP* al_get_menu_item_icon(ALLEGRO_MENU* menu, int pos);
	void al_set_menu_item_icon(ALLEGRO_MENU* menu, int pos, ALLEGRO_BITMAP* icon);

	ALLEGRO_MENU* al_find_menu(ALLEGRO_MENU* haystack, ushort id);
	bool al_find_menu_item(ALLEGRO_MENU* haystack, ushort id, ALLEGRO_MENU** menu, int* index);
	 
	ALLEGRO_EVENT_SOURCE* al_get_default_menu_event_source();
	ALLEGRO_EVENT_SOURCE* al_enable_menu_event_source(ALLEGRO_MENU* menu);
	void al_disable_menu_event_source(ALLEGRO_MENU* menu);
	 
	ALLEGRO_MENU* al_get_display_menu(ALLEGRO_DISPLAY* display);
	bool al_set_display_menu(ALLEGRO_DISPLAY* display, ALLEGRO_MENU* menu);
	bool al_popup_menu(ALLEGRO_MENU* popup, ALLEGRO_DISPLAY* display);
	ALLEGRO_MENU* al_remove_display_menu(ALLEGRO_DISPLAY* display);


	version (ALLEGRO_UNSTABLE) {
		int al_toggle_menu_item_flags(ALLEGRO_MENU* menu, int pos, int flags);
	}

	static if (allegroSupport >= AllegroSupport.v5_2_6) {
		bool al_is_native_dialog_addon_initialized();
	}
}
else {
	extern(C) @nogc nothrow {
	
		alias pal_init_native_dialog_addon = bool function();
		alias pal_shutdown_native_dialog_addon = void function();
		alias pal_get_allegro_native_dialog_version = uint function();
	
		alias pal_create_native_file_dialog = ALLEGRO_FILECHOOSER* function(const(char)* initial_path, const(char)* title, const(char)* patterns, int mode);
		alias pal_show_native_file_dialog = bool function(ALLEGRO_DISPLAY* display, ALLEGRO_FILECHOOSER* dialog);
		alias pal_get_native_file_dialog_count = int function(const(ALLEGRO_FILECHOOSER)* dialog);
		alias pal_get_native_file_dialog_path = const(char)* function(const(ALLEGRO_FILECHOOSER)* dialog, size_t index);
		alias pal_destroy_native_file_dialog = void function(ALLEGRO_FILECHOOSER* dialog);
	
		alias pal_show_native_message_box = int function(ALLEGRO_DISPLAY* display, const(char)* title, const(char)* heading, const(char)* text, const(char)* buttons, int flags);
	
		alias pal_open_native_text_log = ALLEGRO_TEXTLOG* function(const(char)* title, int flags);
		alias pal_close_native_text_log = void function(ALLEGRO_TEXTLOG* textlog);
		alias pal_append_native_text_log = void function(ALLEGRO_TEXTLOG* textlog, const(char)* format, ...);
		alias pal_get_native_text_log_event_source = ALLEGRO_EVENT_SOURCE* function(ALLEGRO_TEXTLOG* textlog);
	
		alias pal_create_menu = ALLEGRO_MENU* function();
		alias pal_create_popup_menu = ALLEGRO_MENU* function();
		alias pal_build_menu = ALLEGRO_MENU* function(ALLEGRO_MENU_INFO* info);
		alias pal_append_menu_item = int function(ALLEGRO_MENU* parent, const(char)* title, ushort id, int flags, ALLEGRO_BITMAP* icon, ALLEGRO_MENU* submenu);
		alias pal_insert_menu_item = int function(ALLEGRO_MENU* parent, int pos, const(char)* title, ushort id, int flags, ALLEGRO_BITMAP* icon, ALLEGRO_MENU* submenu);
		alias pal_remove_menu_item = bool function(ALLEGRO_MENU* menu, int pos);
		alias pal_clone_menu = ALLEGRO_MENU* function(ALLEGRO_MENU* menu);
		alias pal_clone_menu_for_popup = ALLEGRO_MENU* function(ALLEGRO_MENU* menu);
		alias pal_destroy_menu = void function(ALLEGRO_MENU* menu);
	
		alias pal_get_menu_item_caption = const(char)* function(ALLEGRO_MENU* menu, int pos);
		alias pal_set_menu_item_caption = void function(ALLEGRO_MENU* menu, int pos, const(char)* caption);
		alias pal_get_menu_item_flags = int function(ALLEGRO_MENU* menu, int pos);
		alias pal_set_menu_item_flags = void function(ALLEGRO_MENU* menu, int pos, int flags);
		alias pal_get_menu_item_icon = ALLEGRO_BITMAP* function(ALLEGRO_MENU* menu, int pos);
		alias pal_set_menu_item_icon = void function(ALLEGRO_MENU* menu, int pos, ALLEGRO_BITMAP* icon);
	
		alias pal_find_menu = ALLEGRO_MENU* function(ALLEGRO_MENU* haystack, ushort id);
		alias pal_find_menu_item = bool function(ALLEGRO_MENU* haystack, ushort id, ALLEGRO_MENU** menu, int* index);
		 
		alias pal_get_default_menu_event_source = ALLEGRO_EVENT_SOURCE* function();
		alias pal_enable_menu_event_source = ALLEGRO_EVENT_SOURCE* function(ALLEGRO_MENU* menu);
		alias pal_disable_menu_event_source = void function(ALLEGRO_MENU* menu);
		 
		alias pal_get_display_menu = ALLEGRO_MENU* function(ALLEGRO_DISPLAY* display);
		alias pal_set_display_menu = bool function(ALLEGRO_DISPLAY* display, ALLEGRO_MENU* menu);
		alias pal_popup_menu = bool function(ALLEGRO_MENU* popup, ALLEGRO_DISPLAY* display);
		alias pal_remove_display_menu = ALLEGRO_MENU* function(ALLEGRO_DISPLAY* display);
	
	
		version (ALLEGRO_UNSTABLE) {
			alias pal_toggle_menu_item_flags = int function(ALLEGRO_MENU* menu, int pos, int flags);
		}
	
		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			alias pal_is_native_dialog_addon_initialized = bool function();
		}
	}
	__gshared {
		pal_init_native_dialog_addon al_init_native_dialog_addon;
		pal_shutdown_native_dialog_addon al_shutdown_native_dialog_addon;
		pal_get_allegro_native_dialog_version al_get_allegro_native_dialog_version;

		pal_create_native_file_dialog al_create_native_file_dialog;
		pal_show_native_file_dialog al_show_native_file_dialog;
		pal_get_native_file_dialog_count al_get_native_file_dialog_count;
		pal_get_native_file_dialog_path al_get_native_file_dialog_path;
		pal_destroy_native_file_dialog al_destroy_native_file_dialog;

		pal_show_native_message_box al_show_native_message_box;

		pal_open_native_text_log al_open_native_text_log;
		pal_close_native_text_log al_close_native_text_log;
		pal_append_native_text_log al_append_native_text_log;
		pal_get_native_text_log_event_source al_get_native_text_log_event_source;

		pal_create_menu al_create_menu;
		pal_create_popup_menu al_create_popup_menu;
		pal_build_menu al_build_menu;
		pal_append_menu_item al_append_menu_item;
		pal_insert_menu_item al_insert_menu_item;
		pal_remove_menu_item al_remove_menu_item;
		pal_clone_menu al_clone_menu;
		pal_clone_menu_for_popup al_clone_menu_for_popup;
		pal_destroy_menu al_destroy_menu;

		pal_get_menu_item_caption al_get_menu_item_caption;
		pal_set_menu_item_caption al_set_menu_item_caption;
		pal_get_menu_item_flags al_get_menu_item_flags;
		pal_set_menu_item_flags al_set_menu_item_flags;
		pal_get_menu_item_icon al_get_menu_item_icon;
		pal_set_menu_item_icon al_set_menu_item_icon;

		pal_find_menu al_find_menu;
		pal_find_menu_item al_find_menu_item;
		 
		pal_get_default_menu_event_source al_get_default_menu_event_source;
		pal_enable_menu_event_source al_enable_menu_event_source;
		pal_disable_menu_event_source al_disable_menu_event_source;
		 
		pal_get_display_menu al_get_display_menu;
		pal_set_display_menu al_set_display_menu;
		pal_popup_menu al_popup_menu;
		pal_remove_display_menu al_remove_display_menu;


		version (ALLEGRO_UNSTABLE) {
			pal_toggle_menu_item_flags al_toggle_menu_item_flags;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			pal_is_native_dialog_addon_initialized al_is_native_dialog_addon_initialized;
		}
	}

	import bindbc.loader;

	@nogc nothrow:

	version (Allegro_Monolith) {} else {

		private {
			__gshared SharedLib lib;
			__gshared AllegroSupport loadedVersion;
		}

		void unloadAllegroDialog() {
			if (lib != invalidHandle) {
				lib.unload();
			}
		}

		AllegroSupport loadedAllegroDialogVersion() {
			return loadedVersion; 
		}

		bool isAllegroDialogLoaded() {
			return lib != invalidHandle;
		}

		AllegroSupport loadAllegroDialog() {
			const(char)[][1] libNames = [
				libName!"dialog",
			];

			typeof(return) result;
			foreach (i; 0..libNames.length) {
				result = loadAllegroDialog(libNames[i].ptr);
				if (result != AllegroSupport.noLibrary) {
					break;
				}
			}
			return result;
		}

		AllegroSupport loadAllegroDialog(const(char)* libName) {
			lib = load(libName);
			if (lib == invalidHandle) {
				return AllegroSupport.noLibrary;
			}
			loadedVersion = bindAllegroDialog(lib);
			return loadedVersion == allegroSupport ? allegroSupport : AllegroSupport.badLibrary;
		}

	}

	package AllegroSupport bindAllegroDialog(SharedLib lib) {

		auto lastErrorCount = errorCount();

		lib.bindSymbol(cast(void**)&al_init_native_dialog_addon, "al_init_native_dialog_addon");
		lib.bindSymbol(cast(void**)&al_shutdown_native_dialog_addon, "al_shutdown_native_dialog_addon");
		lib.bindSymbol(cast(void**)&al_get_allegro_native_dialog_version, "al_get_allegro_native_dialog_version");

		lib.bindSymbol(cast(void**)&al_create_native_file_dialog, "al_create_native_file_dialog");
		lib.bindSymbol(cast(void**)&al_show_native_file_dialog, "al_show_native_file_dialog");
		lib.bindSymbol(cast(void**)&al_get_native_file_dialog_count, "al_get_native_file_dialog_count");
		lib.bindSymbol(cast(void**)&al_get_native_file_dialog_path, "al_get_native_file_dialog_path");
		lib.bindSymbol(cast(void**)&al_destroy_native_file_dialog, "al_destroy_native_file_dialog");

		lib.bindSymbol(cast(void**)&al_show_native_message_box, "al_show_native_message_box");

		lib.bindSymbol(cast(void**)&al_open_native_text_log, "al_open_native_text_log");
		lib.bindSymbol(cast(void**)&al_close_native_text_log, "al_close_native_text_log");
		lib.bindSymbol(cast(void**)&al_append_native_text_log, "al_append_native_text_log");
		lib.bindSymbol(cast(void**)&al_get_native_text_log_event_source, "al_get_native_text_log_event_source");

		lib.bindSymbol(cast(void**)&al_create_menu, "al_create_menu");
		lib.bindSymbol(cast(void**)&al_create_popup_menu, "al_create_popup_menu");
		lib.bindSymbol(cast(void**)&al_build_menu, "al_build_menu");
		lib.bindSymbol(cast(void**)&al_append_menu_item, "al_append_menu_item");
		lib.bindSymbol(cast(void**)&al_insert_menu_item, "al_insert_menu_item");
		lib.bindSymbol(cast(void**)&al_remove_menu_item, "al_remove_menu_item");
		lib.bindSymbol(cast(void**)&al_clone_menu, "al_clone_menu");
		lib.bindSymbol(cast(void**)&al_clone_menu_for_popup, "al_clone_menu_for_popup");
		lib.bindSymbol(cast(void**)&al_destroy_menu, "al_destroy_menu");

		lib.bindSymbol(cast(void**)&al_get_menu_item_caption, "al_get_menu_item_caption");
		lib.bindSymbol(cast(void**)&al_set_menu_item_caption, "al_set_menu_item_caption");
		lib.bindSymbol(cast(void**)&al_get_menu_item_flags, "al_get_menu_item_flags");
		lib.bindSymbol(cast(void**)&al_set_menu_item_flags, "al_set_menu_item_flags");
		lib.bindSymbol(cast(void**)&al_get_menu_item_icon, "al_get_menu_item_icon");
		lib.bindSymbol(cast(void**)&al_set_menu_item_icon, "al_set_menu_item_icon");

		lib.bindSymbol(cast(void**)&al_find_menu, "al_find_menu");
		lib.bindSymbol(cast(void**)&al_find_menu_item, "al_find_menu_item");
		 
		lib.bindSymbol(cast(void**)&al_get_default_menu_event_source, "al_get_default_menu_event_source");
		lib.bindSymbol(cast(void**)&al_enable_menu_event_source, "al_enable_menu_event_source");
		lib.bindSymbol(cast(void**)&al_disable_menu_event_source, "al_disable_menu_event_source");
		 
		lib.bindSymbol(cast(void**)&al_get_display_menu, "al_get_display_menu");
		lib.bindSymbol(cast(void**)&al_set_display_menu, "al_set_display_menu");
		lib.bindSymbol(cast(void**)&al_popup_menu, "al_popup_menu");
		lib.bindSymbol(cast(void**)&al_remove_display_menu, "al_remove_display_menu");


		version (ALLEGRO_UNSTABLE) {
			lib.bindSymbol(cast(void**)&al_toggle_menu_item_flags, "al_toggle_menu_item_flags");
		}

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&al_is_native_dialog_addon_initialized, "al_is_native_dialog_addon_initialized");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_5;
			}
		}

		return allegroSupport;
	}
}
