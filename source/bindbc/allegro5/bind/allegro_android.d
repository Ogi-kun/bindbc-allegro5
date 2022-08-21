module bindbc.allegro5.bind.allegro_android;

import bindbc.allegro5.config;

version (Android):

version (ALLEGRO_UNSTABLE) static if (allegro5Support >= AllegroSupport.v5_2_2) {
	struct JNIEnv;
	alias jobject = void*;
}

static if (staticBinding) {
	extern(C) @nogc nothrow:

	void al_android_set_apk_file_interface();
	const(char)* al_android_get_os_version();
	void al_android_set_apk_fs_interface();
	void _al_android_set_capture_volume_keys(ALLEGRO_DISPLAY* display, bool onoff);

	version (ALLEGRO_UNSTABLE) static if (allegro5Support >= AllegroSupport.v5_2_2) {
		JNIEnv* al_android_get_jni_env();
		jobject al_android_get_activity();
	}
}
else {
	extern(C) @nogc nothrow {
		alias pal_android_set_apk_file_interface = void function();
		alias pal_android_get_os_version = const(char)* function();
		alias pal_android_set_apk_fs_interface = void function();
		alias p_al_android_set_capture_volume_keys = void function();
		
		version (ALLEGRO_UNSTABLE) static if (allegro5Support >= AllegroSupport.v5_2_2) {
			alias pal_android_get_jni_env = JNIEnv* function();
			alias pal_android_get_activity = jobject function();
		}
	}

	__gshared {
		pal_android_set_apk_file_interface al_android_set_apk_file_interface;
		pal_android_get_os_version al_android_get_os_version;
		pal_android_set_apk_fs_interface al_android_set_apk_fs_interface;
		p_al_android_set_capture_volume_keys _al_android_set_capture_volume_keys;
		
		version (ALLEGRO_UNSTABLE) static if (allegro5Support >= AllegroSupport.v5_2_2) {
			pal_android_get_jni_env al_android_get_jni_env;
			pal_android_get_activity al_android_get_activity;
		}
	}
}
