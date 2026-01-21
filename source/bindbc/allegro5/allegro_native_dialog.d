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
	pragma(inline, true) extern(C) @nogc nothrow {

		bool al_init_native_dialog_addon() => ptr_al_init_native_dialog_addon();
		void al_shutdown_native_dialog_addon() => ptr_al_shutdown_native_dialog_addon();
		uint al_get_allegro_native_dialog_version() => ptr_al_get_allegro_native_dialog_version();

		ALLEGRO_FILECHOOSER* al_create_native_file_dialog(const(char)* initial_path, const(char)* title, const(char)* patterns, int mode) => ptr_al_create_native_file_dialog(initial_path, title, patterns, mode);
		bool al_show_native_file_dialog(ALLEGRO_DISPLAY* display, ALLEGRO_FILECHOOSER* dialog) => ptr_al_show_native_file_dialog(display, dialog);
		int al_get_native_file_dialog_count(const(ALLEGRO_FILECHOOSER)* dialog) => ptr_al_get_native_file_dialog_count(dialog);
		const(char)* al_get_native_file_dialog_path(const(ALLEGRO_FILECHOOSER)* dialog, size_t index) => ptr_al_get_native_file_dialog_path(dialog, index);
		void al_destroy_native_file_dialog(ALLEGRO_FILECHOOSER* dialog) => ptr_al_destroy_native_file_dialog(dialog);

		int al_show_native_message_box(ALLEGRO_DISPLAY* display, const(char)* title, const(char)* heading, const(char)* text, const(char)* buttons, int flags) => ptr_al_show_native_message_box(display, title, heading, text, buttons, flags);

		ALLEGRO_TEXTLOG* al_open_native_text_log(const(char)* title, int flags) => ptr_al_open_native_text_log(title, flags);
		void al_close_native_text_log(ALLEGRO_TEXTLOG* textlog) => ptr_al_close_native_text_log(textlog);
		void al_append_native_text_log(ALLEGRO_TEXTLOG* textlog, const(char)* format, ...) => ptr_al_append_native_text_log(__traits(parameters));
		ALLEGRO_EVENT_SOURCE* al_get_native_text_log_event_source(ALLEGRO_TEXTLOG* textlog) => ptr_al_get_native_text_log_event_source(textlog);

		ALLEGRO_MENU* al_create_menu() => ptr_al_create_menu();
		ALLEGRO_MENU* al_create_popup_menu() => ptr_al_create_popup_menu();
		ALLEGRO_MENU* al_build_menu(ALLEGRO_MENU_INFO* info) => ptr_al_build_menu(info);
		int al_append_menu_item(ALLEGRO_MENU* parent, const(char)* title, ushort id, int flags, ALLEGRO_BITMAP* icon, ALLEGRO_MENU* submenu) => ptr_al_append_menu_item(parent, title, id, flags, icon, submenu);
		int al_insert_menu_item(ALLEGRO_MENU* parent, int pos, const(char)* title, ushort id, int flags, ALLEGRO_BITMAP* icon, ALLEGRO_MENU* submenu) => ptr_al_insert_menu_item(parent, pos, title, id, flags, icon, submenu);
		bool al_remove_menu_item(ALLEGRO_MENU* menu, int pos) => ptr_al_remove_menu_item(menu, pos);
		ALLEGRO_MENU* al_clone_menu(ALLEGRO_MENU* menu) => ptr_al_clone_menu(menu);
		ALLEGRO_MENU* al_clone_menu_for_popup(ALLEGRO_MENU* menu) => ptr_al_clone_menu_for_popup(menu);
		void al_destroy_menu(ALLEGRO_MENU* menu) => ptr_al_destroy_menu(menu);

		const(char)* al_get_menu_item_caption(ALLEGRO_MENU* menu, int pos) => ptr_al_get_menu_item_caption(menu, pos);
		void al_set_menu_item_caption(ALLEGRO_MENU* menu, int pos, const(char)* caption) => ptr_al_set_menu_item_caption(menu, pos, caption);
		int al_get_menu_item_flags(ALLEGRO_MENU* menu, int pos) => ptr_al_get_menu_item_flags(menu, pos);
		void al_set_menu_item_flags(ALLEGRO_MENU* menu, int pos, int flags) => ptr_al_set_menu_item_flags(menu, pos, flags);
		ALLEGRO_BITMAP* al_get_menu_item_icon(ALLEGRO_MENU* menu, int pos) => ptr_al_get_menu_item_icon(menu, pos);
		void al_set_menu_item_icon(ALLEGRO_MENU* menu, int pos, ALLEGRO_BITMAP* icon) => ptr_al_set_menu_item_icon(menu, pos, icon);

		ALLEGRO_MENU* al_find_menu(ALLEGRO_MENU* haystack, ushort id) => ptr_al_find_menu(haystack, id);
		bool al_find_menu_item(ALLEGRO_MENU* haystack, ushort id, ALLEGRO_MENU** menu, int* index) => ptr_al_find_menu_item(haystack, id, menu, index);

		ALLEGRO_EVENT_SOURCE* al_get_default_menu_event_source() => ptr_al_get_default_menu_event_source();
		ALLEGRO_EVENT_SOURCE* al_enable_menu_event_source(ALLEGRO_MENU* menu) => ptr_al_enable_menu_event_source(menu);
		void al_disable_menu_event_source(ALLEGRO_MENU* menu) => ptr_al_disable_menu_event_source(menu);

		ALLEGRO_MENU* al_get_display_menu(ALLEGRO_DISPLAY* display) => ptr_al_get_display_menu(display);
		bool al_set_display_menu(ALLEGRO_DISPLAY* display, ALLEGRO_MENU* menu) => ptr_al_set_display_menu(display, menu);
		bool al_popup_menu(ALLEGRO_MENU* popup, ALLEGRO_DISPLAY* display) => ptr_al_popup_menu(popup, display);
		ALLEGRO_MENU* al_remove_display_menu(ALLEGRO_DISPLAY* display) => ptr_al_remove_display_menu(display);

		version (ALLEGRO_UNSTABLE) {
			int al_toggle_menu_item_flags(ALLEGRO_MENU* menu, int pos, int flags) => ptr_al_toggle_menu_item_flags(menu, pos, flags);
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			bool al_is_native_dialog_addon_initialized() => ptr_al_is_native_dialog_addon_initialized();
		}
	}

	private __gshared {
		typeof(&al_init_native_dialog_addon) ptr_al_init_native_dialog_addon;
		typeof(&al_shutdown_native_dialog_addon) ptr_al_shutdown_native_dialog_addon;
		typeof(&al_get_allegro_native_dialog_version) ptr_al_get_allegro_native_dialog_version;

		typeof(&al_create_native_file_dialog) ptr_al_create_native_file_dialog;
		typeof(&al_show_native_file_dialog) ptr_al_show_native_file_dialog;
		typeof(&al_get_native_file_dialog_count) ptr_al_get_native_file_dialog_count;
		typeof(&al_get_native_file_dialog_path) ptr_al_get_native_file_dialog_path;
		typeof(&al_destroy_native_file_dialog) ptr_al_destroy_native_file_dialog;

		typeof(&al_show_native_message_box) ptr_al_show_native_message_box;

		typeof(&al_open_native_text_log) ptr_al_open_native_text_log;
		typeof(&al_close_native_text_log) ptr_al_close_native_text_log;
		typeof(&al_append_native_text_log) ptr_al_append_native_text_log;
		typeof(&al_get_native_text_log_event_source) ptr_al_get_native_text_log_event_source;

		typeof(&al_create_menu) ptr_al_create_menu;
		typeof(&al_create_popup_menu) ptr_al_create_popup_menu;
		typeof(&al_build_menu) ptr_al_build_menu;
		typeof(&al_append_menu_item) ptr_al_append_menu_item;
		typeof(&al_insert_menu_item) ptr_al_insert_menu_item;
		typeof(&al_remove_menu_item) ptr_al_remove_menu_item;
		typeof(&al_clone_menu) ptr_al_clone_menu;
		typeof(&al_clone_menu_for_popup) ptr_al_clone_menu_for_popup;
		typeof(&al_destroy_menu) ptr_al_destroy_menu;

		typeof(&al_get_menu_item_caption) ptr_al_get_menu_item_caption;
		typeof(&al_set_menu_item_caption) ptr_al_set_menu_item_caption;
		typeof(&al_get_menu_item_flags) ptr_al_get_menu_item_flags;
		typeof(&al_set_menu_item_flags) ptr_al_set_menu_item_flags;
		typeof(&al_get_menu_item_icon) ptr_al_get_menu_item_icon;
		typeof(&al_set_menu_item_icon) ptr_al_set_menu_item_icon;

		typeof(&al_find_menu) ptr_al_find_menu;
		typeof(&al_find_menu_item) ptr_al_find_menu_item;

		typeof(&al_get_default_menu_event_source) ptr_al_get_default_menu_event_source;
		typeof(&al_enable_menu_event_source) ptr_al_enable_menu_event_source;
		typeof(&al_disable_menu_event_source) ptr_al_disable_menu_event_source;

		typeof(&al_get_display_menu) ptr_al_get_display_menu;
		typeof(&al_set_display_menu) ptr_al_set_display_menu;
		typeof(&al_popup_menu) ptr_al_popup_menu;
		typeof(&al_remove_display_menu) ptr_al_remove_display_menu;

		version (ALLEGRO_UNSTABLE) {
			typeof(&al_toggle_menu_item_flags) ptr_al_toggle_menu_item_flags;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			typeof(&al_is_native_dialog_addon_initialized) ptr_al_is_native_dialog_addon_initialized;
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
				dynlibFilename!"dialog",
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

		lib.bindSymbol(cast(void**)&ptr_al_init_native_dialog_addon, "al_init_native_dialog_addon");
		lib.bindSymbol(cast(void**)&ptr_al_shutdown_native_dialog_addon, "al_shutdown_native_dialog_addon");
		lib.bindSymbol(cast(void**)&ptr_al_get_allegro_native_dialog_version, "al_get_allegro_native_dialog_version");

		lib.bindSymbol(cast(void**)&ptr_al_create_native_file_dialog, "al_create_native_file_dialog");
		lib.bindSymbol(cast(void**)&ptr_al_show_native_file_dialog, "al_show_native_file_dialog");
		lib.bindSymbol(cast(void**)&ptr_al_get_native_file_dialog_count, "al_get_native_file_dialog_count");
		lib.bindSymbol(cast(void**)&ptr_al_get_native_file_dialog_path, "al_get_native_file_dialog_path");
		lib.bindSymbol(cast(void**)&ptr_al_destroy_native_file_dialog, "al_destroy_native_file_dialog");

		lib.bindSymbol(cast(void**)&ptr_al_show_native_message_box, "al_show_native_message_box");

		lib.bindSymbol(cast(void**)&ptr_al_open_native_text_log, "al_open_native_text_log");
		lib.bindSymbol(cast(void**)&ptr_al_close_native_text_log, "al_close_native_text_log");
		lib.bindSymbol(cast(void**)&ptr_al_append_native_text_log, "al_append_native_text_log");
		lib.bindSymbol(cast(void**)&ptr_al_get_native_text_log_event_source, "al_get_native_text_log_event_source");

		lib.bindSymbol(cast(void**)&ptr_al_create_menu, "al_create_menu");
		lib.bindSymbol(cast(void**)&ptr_al_create_popup_menu, "al_create_popup_menu");
		lib.bindSymbol(cast(void**)&ptr_al_build_menu, "al_build_menu");
		lib.bindSymbol(cast(void**)&ptr_al_append_menu_item, "al_append_menu_item");
		lib.bindSymbol(cast(void**)&ptr_al_insert_menu_item, "al_insert_menu_item");
		lib.bindSymbol(cast(void**)&ptr_al_remove_menu_item, "al_remove_menu_item");
		lib.bindSymbol(cast(void**)&ptr_al_clone_menu, "al_clone_menu");
		lib.bindSymbol(cast(void**)&ptr_al_clone_menu_for_popup, "al_clone_menu_for_popup");
		lib.bindSymbol(cast(void**)&ptr_al_destroy_menu, "al_destroy_menu");

		lib.bindSymbol(cast(void**)&ptr_al_get_menu_item_caption, "al_get_menu_item_caption");
		lib.bindSymbol(cast(void**)&ptr_al_set_menu_item_caption, "al_set_menu_item_caption");
		lib.bindSymbol(cast(void**)&ptr_al_get_menu_item_flags, "al_get_menu_item_flags");
		lib.bindSymbol(cast(void**)&ptr_al_set_menu_item_flags, "al_set_menu_item_flags");
		lib.bindSymbol(cast(void**)&ptr_al_get_menu_item_icon, "al_get_menu_item_icon");
		lib.bindSymbol(cast(void**)&ptr_al_set_menu_item_icon, "al_set_menu_item_icon");

		lib.bindSymbol(cast(void**)&ptr_al_find_menu, "al_find_menu");
		lib.bindSymbol(cast(void**)&ptr_al_find_menu_item, "al_find_menu_item");

		lib.bindSymbol(cast(void**)&ptr_al_get_default_menu_event_source, "al_get_default_menu_event_source");
		lib.bindSymbol(cast(void**)&ptr_al_enable_menu_event_source, "al_enable_menu_event_source");
		lib.bindSymbol(cast(void**)&ptr_al_disable_menu_event_source, "al_disable_menu_event_source");

		lib.bindSymbol(cast(void**)&ptr_al_get_display_menu, "al_get_display_menu");
		lib.bindSymbol(cast(void**)&ptr_al_set_display_menu, "al_set_display_menu");
		lib.bindSymbol(cast(void**)&ptr_al_popup_menu, "al_popup_menu");
		lib.bindSymbol(cast(void**)&ptr_al_remove_display_menu, "al_remove_display_menu");


		version (ALLEGRO_UNSTABLE) {
			lib.bindSymbol(cast(void**)&ptr_al_toggle_menu_item_flags, "al_toggle_menu_item_flags");
		}

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&ptr_al_is_native_dialog_addon_initialized, "al_is_native_dialog_addon_initialized");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_5;
			}
		}

		return allegroSupport;
	}
}
