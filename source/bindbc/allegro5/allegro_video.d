module bindbc.allegro5.allegro_video;

import bindbc.allegro5.config;

static if (allegroVideo):
static assert (allegroAudio, "`allegro_video` depends on `allegro_audio`");

import bindbc.allegro5.allegro_audio : ALLEGRO_VOICE, ALLEGRO_MIXER;
import bindbc.allegro5.bind.events : ALLEGRO_EVENT_SOURCE;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import bindbc.allegro5.bind.file : ALLEGRO_FILE;

enum ALLEGRO_VIDEO_EVENT_TYPE {
	ALLEGRO_EVENT_VIDEO_FRAME_SHOW   = 550,
	ALLEGRO_EVENT_VIDEO_FINISHED     = 551,
	_ALLEGRO_EVENT_VIDEO_SEEK        = 552,
}
mixin ExpandEnum!ALLEGRO_VIDEO_EVENT_TYPE;

enum ALLEGRO_VIDEO_POSITION_TYPE {
	ALLEGRO_VIDEO_POSITION_ACTUAL        = 0,
	ALLEGRO_VIDEO_POSITION_VIDEO_DECODE  = 1,
	ALLEGRO_VIDEO_POSITION_AUDIO_DECODE  = 2,
}
mixin ExpandEnum!ALLEGRO_VIDEO_POSITION_TYPE;

struct ALLEGRO_VIDEO;

static if (staticBinding) {
	extern(C) @nogc nothrow:

	bool al_init_video_addon();
	void al_shutdown_video_addon();
	uint al_get_allegro_video_version();

	ALLEGRO_VIDEO* al_open_video(const(char)* filename);
	void al_close_video(ALLEGRO_VIDEO* video);
	void al_start_video(ALLEGRO_VIDEO* video, ALLEGRO_MIXER* mixer);
	void al_start_video_with_voice(ALLEGRO_VIDEO* video, ALLEGRO_VOICE* voice);
	ALLEGRO_EVENT_SOURCE* al_get_video_event_source(ALLEGRO_VIDEO* video);
	void al_set_video_playing(ALLEGRO_VIDEO* video, bool playing);
	bool al_is_video_playing(ALLEGRO_VIDEO* video);
	double al_get_video_audio_rate(ALLEGRO_VIDEO* video);
	double al_get_video_fps(ALLEGRO_VIDEO* video);
	float al_get_video_scaled_width(ALLEGRO_VIDEO* video);
	float al_get_video_scaled_height(ALLEGRO_VIDEO* video);
	ALLEGRO_BITMAP* al_get_video_frame(ALLEGRO_VIDEO* video);
	double al_get_video_position(ALLEGRO_VIDEO* video, ALLEGRO_VIDEO_POSITION_TYPE which);
	bool al_seek_video(ALLEGRO_VIDEO* video, double pos_in_seconds);

	static if (allegroSupport >= AllegroSupport.v5_2_6) {
		bool al_is_video_addon_initialized();
	}

	static if (allegroSupport >= AllegroSupport.v5_2_8) {
		const(char)* al_identify_video_f(ALLEGRO_FILE* fp);
		const(char)* al_identify_video(const(char)* filename);
	}
}
else {
	extern(C) @nogc nothrow {
	
		alias pal_init_video_addon = bool function();
		alias pal_shutdown_video_addon = void function();
		alias pal_get_allegro_video_version = uint function();
	
		alias pal_open_video = ALLEGRO_VIDEO* function(const(char)* filename);
		alias pal_close_video = void function(ALLEGRO_VIDEO* video);
		alias pal_start_video = void function(ALLEGRO_VIDEO* video, ALLEGRO_MIXER* mixer);
		alias pal_start_video_with_voice = void function(ALLEGRO_VIDEO* video, ALLEGRO_VOICE* voice);
		alias pal_get_video_event_source = ALLEGRO_EVENT_SOURCE* function(ALLEGRO_VIDEO* video);
		alias pal_set_video_playing = void function(ALLEGRO_VIDEO* video, bool playing);
		alias pal_is_video_playing = bool function(ALLEGRO_VIDEO* video);
		alias pal_get_video_audio_rate = double function(ALLEGRO_VIDEO* video);
		alias pal_get_video_fps = double function(ALLEGRO_VIDEO* video);
		alias pal_get_video_scaled_width = float function(ALLEGRO_VIDEO* video);
		alias pal_get_video_scaled_height = float function(ALLEGRO_VIDEO* video);
		alias pal_get_video_frame = ALLEGRO_BITMAP* function(ALLEGRO_VIDEO* video);
		alias pal_get_video_position = double function(ALLEGRO_VIDEO* video, ALLEGRO_VIDEO_POSITION_TYPE which);
		alias pal_seek_video = bool function(ALLEGRO_VIDEO* video, double pos_in_seconds);
	
		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			alias pal_is_video_addon_initialized = bool function();
		}
	
		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			alias pal_identify_video_f = const(char)* function(ALLEGRO_FILE* fp);
			alias pal_identify_video = const(char)* function(const(char)* filename);
		}
	}
	__gshared {
	
		pal_init_video_addon al_init_video_addon;
		pal_shutdown_video_addon al_shutdown_video_addon;
		pal_get_allegro_video_version al_get_allegro_video_version;
	
		pal_open_video al_open_video;
		pal_close_video al_close_video;
		pal_start_video al_start_video;
		pal_start_video_with_voice al_start_video_with_voice;
		pal_get_video_event_source al_get_video_event_source;
		pal_set_video_playing al_set_video_playing;
		pal_is_video_playing al_is_video_playing;
		pal_get_video_audio_rate al_get_video_audio_rate;
		pal_get_video_fps al_get_video_fps;
		pal_get_video_scaled_width al_get_video_scaled_width;
		pal_get_video_scaled_height al_get_video_scaled_height;
		pal_get_video_frame al_get_video_frame;
		pal_get_video_position al_get_video_position;
		pal_seek_video al_seek_video;
	
		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			pal_is_video_addon_initialized al_is_video_addon_initialized;
		}
	
		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			pal_identify_video_f al_identify_video_f;
			pal_identify_video al_identify_video;
		}
	}

	import bindbc.loader;

	@nogc nothrow:

	version (Allegro_Monolith) {} else {

		private {
			__gshared SharedLib lib;
			__gshared AllegroSupport loadedVersion;
		}
	
		void unloadAllegroVideo() {
			if (lib != invalidHandle) {
				lib.unload();
			}
		}
	
		AllegroSupport loadedAllegroVideoVersion() {
			return loadedVersion; 
		}
	
		bool isAllegroVideoLoaded() {
			return lib != invalidHandle;
		}
	
		AllegroSupport loadAllegroVideo() {
			const(char)[][1] libNames = [
				libName!"video",
			];
	
			typeof(return) result;
			foreach (i; 0..libNames.length) {
				result = loadAllegroVideo(libNames[i].ptr);
				if (result != AllegroSupport.noLibrary) {
					break;
				}
			}
			return result;
		}

		AllegroSupport loadAllegroVideo(const(char)* libName) {
			lib = load(libName);
			if (lib == invalidHandle) {
				return AllegroSupport.noLibrary;
			}
			loadedVersion = bindAllegroVideo(lib);
			return loadedVersion == allegroSupport ? allegroSupport : AllegroSupport.badLibrary;
		}
	}

	package AllegroSupport bindAllegroVideo(SharedLib lib) {

		auto lastErrorCount = errorCount();

		lib.bindSymbol(cast(void**)&al_init_video_addon, "al_init_video_addon");
		lib.bindSymbol(cast(void**)&al_shutdown_video_addon, "al_shutdown_video_addon");
		lib.bindSymbol(cast(void**)&al_get_allegro_video_version, "al_get_allegro_video_version");
	
		lib.bindSymbol(cast(void**)&al_open_video, "al_open_video");
		lib.bindSymbol(cast(void**)&al_close_video, "al_close_video");
		lib.bindSymbol(cast(void**)&al_start_video, "al_start_video");
		lib.bindSymbol(cast(void**)&al_start_video_with_voice, "al_start_video_with_voice");
		lib.bindSymbol(cast(void**)&al_get_video_event_source, "al_get_video_event_source");
		lib.bindSymbol(cast(void**)&al_set_video_playing, "al_set_video_playing");
		lib.bindSymbol(cast(void**)&al_is_video_playing, "al_is_video_playing");
		lib.bindSymbol(cast(void**)&al_get_video_audio_rate, "al_get_video_audio_rate");
		lib.bindSymbol(cast(void**)&al_get_video_fps, "al_get_video_fps");
		lib.bindSymbol(cast(void**)&al_get_video_scaled_width, "al_get_video_scaled_width");
		lib.bindSymbol(cast(void**)&al_get_video_scaled_height, "al_get_video_scaled_height");
		lib.bindSymbol(cast(void**)&al_get_video_frame, "al_get_video_frame");
		lib.bindSymbol(cast(void**)&al_get_video_position, "al_get_video_position");
		lib.bindSymbol(cast(void**)&al_seek_video, "al_seek_video");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}
	
		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&al_is_video_addon_initialized, "al_is_video_addon_initialized");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
		}
	
		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			lib.bindSymbol(cast(void**)&al_identify_video_f, "al_identify_video_f");
			lib.bindSymbol(cast(void**)&al_identify_video, "al_identify_video");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
		}

		return allegroSupport;

	}
}
