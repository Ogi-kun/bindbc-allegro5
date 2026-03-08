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

	static if (allegroSupport >= AllegroSupport.v5_2_11) {
		ALLEGRO_VIDEO* al_open_video_f(ALLEGRO_FILE* fp, const(char)* ident);
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow {

		bool al_init_video_addon() => ptr_al_init_video_addon();
		void al_shutdown_video_addon() => ptr_al_shutdown_video_addon();
		uint al_get_allegro_video_version() => ptr_al_get_allegro_video_version();

		ALLEGRO_VIDEO* al_open_video(const(char)* filename) => ptr_al_open_video(filename);
		void al_close_video(ALLEGRO_VIDEO* video) => ptr_al_close_video(video);
		void al_start_video(ALLEGRO_VIDEO* video, ALLEGRO_MIXER* mixer) => ptr_al_start_video(video, mixer);
		void al_start_video_with_voice(ALLEGRO_VIDEO* video, ALLEGRO_VOICE* voice) => ptr_al_start_video_with_voice(video, voice);
		ALLEGRO_EVENT_SOURCE* al_get_video_event_source(ALLEGRO_VIDEO* video) => ptr_al_get_video_event_source(video);
		void al_set_video_playing(ALLEGRO_VIDEO* video, bool playing) => ptr_al_set_video_playing(video, playing);
		bool al_is_video_playing(ALLEGRO_VIDEO* video) => ptr_al_is_video_playing(video);
		double al_get_video_audio_rate(ALLEGRO_VIDEO* video) => ptr_al_get_video_audio_rate(video);
		double al_get_video_fps(ALLEGRO_VIDEO* video) => ptr_al_get_video_fps(video);
		float al_get_video_scaled_width(ALLEGRO_VIDEO* video) => ptr_al_get_video_scaled_width(video);
		float al_get_video_scaled_height(ALLEGRO_VIDEO* video) => ptr_al_get_video_scaled_height(video);
		ALLEGRO_BITMAP* al_get_video_frame(ALLEGRO_VIDEO* video) => ptr_al_get_video_frame(video);
		double al_get_video_position(ALLEGRO_VIDEO* video, ALLEGRO_VIDEO_POSITION_TYPE which) => ptr_al_get_video_position(video, which);
		bool al_seek_video(ALLEGRO_VIDEO* video, double pos_in_seconds) => ptr_al_seek_video(video, pos_in_seconds);

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			bool al_is_video_addon_initialized() => ptr_al_is_video_addon_initialized();
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			const(char)* al_identify_video_f(ALLEGRO_FILE* fp) => ptr_al_identify_video_f(fp);
			const(char)* al_identify_video(const(char)* filename) => ptr_al_identify_video(filename);
		}

		static if (allegroSupport >= AllegroSupport.v5_2_11) {
			ALLEGRO_VIDEO* al_open_video_f(ALLEGRO_FILE* fp, const(char)* ident) => ptr_al_open_video_f(fp, ident);
		}
	}

	private __gshared {

		typeof(&al_init_video_addon) ptr_al_init_video_addon;
		typeof(&al_shutdown_video_addon) ptr_al_shutdown_video_addon;
		typeof(&al_get_allegro_video_version) ptr_al_get_allegro_video_version;

		typeof(&al_open_video) ptr_al_open_video;
		typeof(&al_close_video) ptr_al_close_video;
		typeof(&al_start_video) ptr_al_start_video;
		typeof(&al_start_video_with_voice) ptr_al_start_video_with_voice;
		typeof(&al_get_video_event_source) ptr_al_get_video_event_source;
		typeof(&al_set_video_playing) ptr_al_set_video_playing;
		typeof(&al_is_video_playing) ptr_al_is_video_playing;
		typeof(&al_get_video_audio_rate) ptr_al_get_video_audio_rate;
		typeof(&al_get_video_fps) ptr_al_get_video_fps;
		typeof(&al_get_video_scaled_width) ptr_al_get_video_scaled_width;
		typeof(&al_get_video_scaled_height) ptr_al_get_video_scaled_height;
		typeof(&al_get_video_frame) ptr_al_get_video_frame;
		typeof(&al_get_video_position) ptr_al_get_video_position;
		typeof(&al_seek_video) ptr_al_seek_video;

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			typeof(&al_is_video_addon_initialized) ptr_al_is_video_addon_initialized;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			typeof(&al_identify_video_f) ptr_al_identify_video_f;
			typeof(&al_identify_video) ptr_al_identify_video;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_11) {
			typeof(&al_open_video_f) ptr_al_open_video_f;
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
				dynlibFilename!"video",
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

		lib.bindSymbol(cast(void**)&ptr_al_init_video_addon, "al_init_video_addon");
		lib.bindSymbol(cast(void**)&ptr_al_shutdown_video_addon, "al_shutdown_video_addon");
		lib.bindSymbol(cast(void**)&ptr_al_get_allegro_video_version, "al_get_allegro_video_version");

		lib.bindSymbol(cast(void**)&ptr_al_open_video, "al_open_video");
		lib.bindSymbol(cast(void**)&ptr_al_close_video, "al_close_video");
		lib.bindSymbol(cast(void**)&ptr_al_start_video, "al_start_video");
		lib.bindSymbol(cast(void**)&ptr_al_start_video_with_voice, "al_start_video_with_voice");
		lib.bindSymbol(cast(void**)&ptr_al_get_video_event_source, "al_get_video_event_source");
		lib.bindSymbol(cast(void**)&ptr_al_set_video_playing, "al_set_video_playing");
		lib.bindSymbol(cast(void**)&ptr_al_is_video_playing, "al_is_video_playing");
		lib.bindSymbol(cast(void**)&ptr_al_get_video_audio_rate, "al_get_video_audio_rate");
		lib.bindSymbol(cast(void**)&ptr_al_get_video_fps, "al_get_video_fps");
		lib.bindSymbol(cast(void**)&ptr_al_get_video_scaled_width, "al_get_video_scaled_width");
		lib.bindSymbol(cast(void**)&ptr_al_get_video_scaled_height, "al_get_video_scaled_height");
		lib.bindSymbol(cast(void**)&ptr_al_get_video_frame, "al_get_video_frame");
		lib.bindSymbol(cast(void**)&ptr_al_get_video_position, "al_get_video_position");
		lib.bindSymbol(cast(void**)&ptr_al_seek_video, "al_seek_video");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&ptr_al_is_video_addon_initialized, "al_is_video_addon_initialized");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			lib.bindSymbol(cast(void**)&ptr_al_identify_video_f, "al_identify_video_f");
			lib.bindSymbol(cast(void**)&ptr_al_identify_video, "al_identify_video");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
		}

		static if (allegroSupport >= AllegroSupport.v5_2_11) {
			lib.bindSymbol(cast(void**)&ptr_al_open_video_f, "al_open_video_f");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
		}

		return allegroSupport;

	}
}
