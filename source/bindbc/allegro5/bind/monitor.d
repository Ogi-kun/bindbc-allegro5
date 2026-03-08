module bindbc.allegro5.bind.monitor;

import bindbc.allegro5.config;

struct ALLEGRO_MONITOR_INFO {
	int x1;
	int y1;
	int x2;
	int y2;
}

enum {
	ALLEGRO_DEFAULT_DISPLAY_ADAPTER = -1,
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	int al_get_num_video_adapters();
	bool al_get_monitor_info(int adapter, ALLEGRO_MONITOR_INFO *info);
	static if (allegroSupport >= AllegroSupport.v5_2_5) {
		int al_get_monitor_dpi(int adapter);
	}
	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_6) {
		int al_get_monitor_refresh_rate(int adapter);
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	int al_get_num_video_adapters() => ptr_al_get_num_video_adapters();
	bool al_get_monitor_info(int adapter, ALLEGRO_MONITOR_INFO *info) => ptr_al_get_monitor_info(adapter, info);
	static if (allegroSupport >= AllegroSupport.v5_2_5) {
		int al_get_monitor_dpi(int adapter) => ptr_al_get_monitor_dpi(adapter);
	}
	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_6) {
		int al_get_monitor_refresh_rate(int adapter) => ptr_al_get_monitor_refresh_rate(adapter);
	}
	package(bindbc.allegro5) __gshared {
		typeof(&al_get_num_video_adapters) ptr_al_get_num_video_adapters;
		typeof(&al_get_monitor_info) ptr_al_get_monitor_info;
		static if (allegroSupport >= AllegroSupport.v5_2_5) {
			typeof(&al_get_monitor_dpi) ptr_al_get_monitor_dpi;
		}
		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_6) {
			typeof(&al_get_monitor_refresh_rate) ptr_al_get_monitor_refresh_rate;
		}
	}
}
