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
	extern(C) @nogc nothrow {
		alias pal_get_num_video_adapters = int function();
		alias pal_get_monitor_info = bool function(int adapter, ALLEGRO_MONITOR_INFO* info);
		static if (allegroSupport >= AllegroSupport.v5_2_5) {
			alias pal_get_monitor_dpi = int function(int adapter);
		}
		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_6) {
			alias pal_get_monitor_refresh_rate = int function(int adapter);
		}
	}
	__gshared {
		pal_get_num_video_adapters al_get_num_video_adapters;
		pal_get_monitor_info al_get_monitor_info;
		static if (allegroSupport >= AllegroSupport.v5_2_5) {
			pal_get_monitor_dpi al_get_monitor_dpi;
		}
		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_6) {
			pal_get_monitor_refresh_rate al_get_monitor_refresh_rate;
		}
	}
}
