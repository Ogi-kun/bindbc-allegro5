module bindbc.allegro5.bind.allegro_android;

import bindbc.allegro5.config;

version (Android):

version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_2) {
	struct JNIEnv;
	alias jobject = void*;
}

static if (staticBinding) {
	extern(C) @nogc nothrow:

	void al_android_set_apk_file_interface();
	const(char)* al_android_get_os_version();
	void al_android_set_apk_fs_interface();
	void _al_android_set_capture_volume_keys(ALLEGRO_DISPLAY* display, bool onoff);

	static if (allegroSupport >= AllegroSupport.v5_2_10) {
		int al_android_open_fd(const(char)* uri, const(char)* mode);
	}

	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_2) {
		JNIEnv* al_android_get_jni_env();
		jobject al_android_get_activity();
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	void al_android_set_apk_file_interface() => ptr_al_android_set_apk_file_interface();
	const(char)* al_android_get_os_version() => ptr_al_android_get_os_version();
	void al_android_set_apk_fs_interface() => ptr_al_android_set_apk_fs_interface();
	void _al_android_set_capture_volume_keys(ALLEGRO_DISPLAY* display, bool onoff) => ptr__al_android_set_capture_volume_keys(display, onoff);

	static if (allegroSupport >= AllegroSupport.v5_2_10) {
		int al_android_open_fd(const(char)* uri, const(char)* mode) => ptr_al_android_open_fd(uri, mode);
	}

	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_2) {
		JNIEnv* al_android_get_jni_env() => ptr_al_android_get_jni_env();
		jobject al_android_get_activity() => ptr_al_android_get_activity();
	}
	package(bindbc.allegro5) __gshared {
		typeof(&al_android_set_apk_file_interface) ptr_al_android_set_apk_file_interface;
		typeof(&al_android_get_os_version) ptr_al_android_get_os_version;
		typeof(&al_android_set_apk_fs_interface) ptr_al_android_set_apk_fs_interface;
		typeof(&_al_android_set_capture_volume_keys) ptr__al_android_set_capture_volume_keys;

		static if (allegroSupport >= AllegroSupport.v5_2_10) {
			typeof(al_android_open_fd) ptr_al_android_open_fd;
		}

		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_2) {
			typeof(&al_android_get_jni_env) ptr_al_android_get_jni_env;
			typeof(&al_android_get_activity) ptr_al_android_get_activity;
		}
	}
}
