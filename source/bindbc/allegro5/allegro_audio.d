module bindbc.allegro5.allegro_audio;

import bindbc.allegro5.config;

static if (allegroAudio):

import bindbc.allegro5.bind.events;
import bindbc.allegro5.bind.file : ALLEGRO_FILE;

enum ALLEGRO_AUDIO_PAN_NONE = -1000.0f;

mixin(q{
	enum ALLEGRO_AUDIO_EVENT_TYPE } ~ `{` ~ q{
		_KCM_STREAM_FEEDER_QUIT_EVENT_TYPE    = 512,
		ALLEGRO_EVENT_AUDIO_STREAM_FRAGMENT   = 513,
		ALLEGRO_EVENT_AUDIO_STREAM_FINISHED   = 514,
	} ~ () {
			version (ALLEGRO_UNSTABLE) {
				return q{ALLEGRO_EVENT_AUDIO_RECORDER_FRAGMENT = 515, };
			}
			else {
				return q{ };
			}
		}() ~
	`}`
);

enum ALLEGRO_AUDIO_DEPTH {
	ALLEGRO_AUDIO_DEPTH_INT8      = 0x00,
	ALLEGRO_AUDIO_DEPTH_INT16     = 0x01,
	ALLEGRO_AUDIO_DEPTH_INT24     = 0x02,
	ALLEGRO_AUDIO_DEPTH_FLOAT32   = 0x03,

	ALLEGRO_AUDIO_DEPTH_UNSIGNED  = 0x08,

	ALLEGRO_AUDIO_DEPTH_UINT8  = ALLEGRO_AUDIO_DEPTH_INT8 |
											ALLEGRO_AUDIO_DEPTH_UNSIGNED,
	ALLEGRO_AUDIO_DEPTH_UINT16 = ALLEGRO_AUDIO_DEPTH_INT16 |
											ALLEGRO_AUDIO_DEPTH_UNSIGNED,
	ALLEGRO_AUDIO_DEPTH_UINT24 = ALLEGRO_AUDIO_DEPTH_INT24 |
											ALLEGRO_AUDIO_DEPTH_UNSIGNED,
}


enum ALLEGRO_CHANNEL_CONF {
	ALLEGRO_CHANNEL_CONF_1   = 0x10,
	ALLEGRO_CHANNEL_CONF_2   = 0x20,
	ALLEGRO_CHANNEL_CONF_3   = 0x30,
	ALLEGRO_CHANNEL_CONF_4   = 0x40,
	ALLEGRO_CHANNEL_CONF_5_1 = 0x51,
	ALLEGRO_CHANNEL_CONF_6_1 = 0x61,
	ALLEGRO_CHANNEL_CONF_7_1 = 0x71,
}

enum ALLEGRO_MAX_CHANNELS = 8;

enum ALLEGRO_PLAYMODE {
	ALLEGRO_PLAYMODE_ONCE   = 0x100,
	ALLEGRO_PLAYMODE_LOOP   = 0x101,
	ALLEGRO_PLAYMODE_BIDIR  = 0x102,
	_ALLEGRO_PLAYMODE_STREAM_ONCE   = 0x103,
	_ALLEGRO_PLAYMODE_STREAM_ONEDIR = 0x104,
	ALLEGRO_PLAYMODE_LOOP_ONCE = 0x105,
	_ALLEGRO_PLAYMODE_STREAM_LOOP_ONCE = 0x106,
}


enum ALLEGRO_MIXER_QUALITY {
	ALLEGRO_MIXER_QUALITY_POINT   = 0x110,
	ALLEGRO_MIXER_QUALITY_LINEAR  = 0x111,
	ALLEGRO_MIXER_QUALITY_CUBIC   = 0x112,
}

struct ALLEGRO_SAMPLE_ID {
	int _index;
	int _id;
}

struct ALLEGRO_SAMPLE;
struct ALLEGRO_SAMPLE_INSTANCE;
struct ALLEGRO_AUDIO_STREAM;
struct ALLEGRO_MIXER;
struct ALLEGRO_VOICE;
struct ALLEGRO_AUDIO_DEVICE;

version (ALLEGRO_UNSTABLE) {
	struct ALLEGRO_AUDIO_RECORDER;
	struct ALLEGRO_AUDIO_RECORDER_EVENT {
		mixin _AL_EVENT_HEADER!ALLEGRO_AUDIO_RECORDER;
		ALLEGRO_USER_EVENT_DESCRIPTOR* __internal__descr;
		void* buffer;
		uint samples;
	}
}


static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_SAMPLE* al_create_sample(void* buf,uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf, bool free_buf);
	void al_destroy_sample(ALLEGRO_SAMPLE* spl);

	ALLEGRO_SAMPLE_INSTANCE* al_create_sample_instance(ALLEGRO_SAMPLE* data);
	void al_destroy_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl);

	uint al_get_sample_frequency(const(ALLEGRO_SAMPLE)* spl);
	uint al_get_sample_length(const(ALLEGRO_SAMPLE)* spl);
	ALLEGRO_AUDIO_DEPTH al_get_sample_depth(const(ALLEGRO_SAMPLE)* spl);
	ALLEGRO_CHANNEL_CONF al_get_sample_channels(const(ALLEGRO_SAMPLE)* spl);
	void* al_get_sample_data(const(ALLEGRO_SAMPLE)* spl);

	uint al_get_sample_instance_frequency(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
	uint al_get_sample_instance_length(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
	uint al_get_sample_instance_position(const(ALLEGRO_SAMPLE_INSTANCE)* spl);

	float al_get_sample_instance_speed(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
	float al_get_sample_instance_gain(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
	float al_get_sample_instance_pan(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
	float al_get_sample_instance_time(const(ALLEGRO_SAMPLE_INSTANCE)* spl);

	ALLEGRO_AUDIO_DEPTH al_get_sample_instance_depth(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
	ALLEGRO_CHANNEL_CONF al_get_sample_instance_channels(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
	ALLEGRO_PLAYMODE al_get_sample_instance_playmode(const(ALLEGRO_SAMPLE_INSTANCE)* spl);

	bool al_get_sample_instance_playing(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
	bool al_get_sample_instance_attached(const(ALLEGRO_SAMPLE_INSTANCE)* spl);

	bool al_set_sample_instance_position(ALLEGRO_SAMPLE_INSTANCE* spl, uint val);
	bool al_set_sample_instance_length(ALLEGRO_SAMPLE_INSTANCE* spl, uint val);

	bool al_set_sample_instance_speed(ALLEGRO_SAMPLE_INSTANCE* spl, float val);
	bool al_set_sample_instance_gain(ALLEGRO_SAMPLE_INSTANCE* spl, float val);
	bool al_set_sample_instance_pan(ALLEGRO_SAMPLE_INSTANCE* spl, float val);

	bool al_set_sample_instance_playmode(ALLEGRO_SAMPLE_INSTANCE* spl, ALLEGRO_PLAYMODE val);

	bool al_set_sample_instance_playing(ALLEGRO_SAMPLE_INSTANCE* spl, bool val);
	bool al_detach_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl);

	bool al_set_sample(ALLEGRO_SAMPLE_INSTANCE* spl, ALLEGRO_SAMPLE* data);
	ALLEGRO_SAMPLE* al_get_sample(ALLEGRO_SAMPLE_INSTANCE* spl);
	bool al_play_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl);
	bool al_stop_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl);

	ALLEGRO_AUDIO_STREAM* al_create_audio_stream(size_t buffer_count, uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);
	void al_destroy_audio_stream(ALLEGRO_AUDIO_STREAM* stream);
	void al_drain_audio_stream(ALLEGRO_AUDIO_STREAM* stream);

	uint al_get_audio_stream_frequency(const(ALLEGRO_AUDIO_STREAM)* stream);
	uint al_get_audio_stream_length(const(ALLEGRO_AUDIO_STREAM)* stream);
	uint al_get_audio_stream_fragments(const(ALLEGRO_AUDIO_STREAM)* stream);
	uint al_get_available_audio_stream_fragments(const(ALLEGRO_AUDIO_STREAM)* stream);

	float al_get_audio_stream_speed(const(ALLEGRO_AUDIO_STREAM)* stream);
	float al_get_audio_stream_gain(const(ALLEGRO_AUDIO_STREAM)* stream);
	float al_get_audio_stream_pan(const(ALLEGRO_AUDIO_STREAM)* stream);

	ALLEGRO_CHANNEL_CONF al_get_audio_stream_channels(const(ALLEGRO_AUDIO_STREAM)* stream);
	ALLEGRO_AUDIO_DEPTH al_get_audio_stream_depth(const(ALLEGRO_AUDIO_STREAM)* stream);
	ALLEGRO_PLAYMODE al_get_audio_stream_playmode(const(ALLEGRO_AUDIO_STREAM)* stream);

	bool al_get_audio_stream_playing(const(ALLEGRO_AUDIO_STREAM)* spl);
	bool al_get_audio_stream_attached(const(ALLEGRO_AUDIO_STREAM)* spl);
	ulong al_get_audio_stream_played_samples(const(ALLEGRO_AUDIO_STREAM)* stream);

	void* al_get_audio_stream_fragment(const(ALLEGRO_AUDIO_STREAM)* stream);

	bool al_set_audio_stream_speed(ALLEGRO_AUDIO_STREAM* stream, float val);
	bool al_set_audio_stream_gain(ALLEGRO_AUDIO_STREAM* stream, float val);
	bool al_set_audio_stream_pan(ALLEGRO_AUDIO_STREAM* stream, float val);

	bool al_set_audio_stream_playmode(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_PLAYMODE val);

	bool al_set_audio_stream_playing(ALLEGRO_AUDIO_STREAM* stream, bool val);
	bool al_detach_audio_stream(ALLEGRO_AUDIO_STREAM* stream);
	bool al_set_audio_stream_fragment(ALLEGRO_AUDIO_STREAM* stream, void* val);

	bool al_rewind_audio_stream(ALLEGRO_AUDIO_STREAM* stream);
	bool al_seek_audio_stream_secs(ALLEGRO_AUDIO_STREAM* stream, double time);
	double al_get_audio_stream_position_secs(ALLEGRO_AUDIO_STREAM* stream);
	double al_get_audio_stream_length_secs(ALLEGRO_AUDIO_STREAM* stream);
	bool al_set_audio_stream_loop_secs(ALLEGRO_AUDIO_STREAM* stream, double start, double end);

	ALLEGRO_EVENT_SOURCE* al_get_audio_stream_event_source(ALLEGRO_AUDIO_STREAM* stream);

	ALLEGRO_MIXER* al_create_mixer(uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);
	void al_destroy_mixer(ALLEGRO_MIXER* mixer);
	bool al_attach_sample_instance_to_mixer( ALLEGRO_SAMPLE_INSTANCE* stream, ALLEGRO_MIXER* mixer);
	bool al_attach_audio_stream_to_mixer(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_MIXER* mixer);
	bool al_attach_mixer_to_mixer(ALLEGRO_MIXER* stream, ALLEGRO_MIXER* mixer);
	bool al_set_mixer_postprocess_callback(ALLEGRO_MIXER* mixer, void function(void* buf, uint samples, void* data)cb, void* data);

	uint al_get_mixer_frequency(const(ALLEGRO_MIXER)* mixer);
	ALLEGRO_CHANNEL_CONF al_get_mixer_channels(const(ALLEGRO_MIXER)* mixer);
	ALLEGRO_AUDIO_DEPTH al_get_mixer_depth(const(ALLEGRO_MIXER)* mixer);
	ALLEGRO_MIXER_QUALITY al_get_mixer_quality(const(ALLEGRO_MIXER)* mixer);
	float al_get_mixer_gain(const(ALLEGRO_MIXER)* mixer);
	bool al_get_mixer_playing(const(ALLEGRO_MIXER)* mixer);
	bool al_get_mixer_attached(const(ALLEGRO_MIXER)* mixer);
	bool al_set_mixer_frequency(ALLEGRO_MIXER* mixer, uint val);
	bool al_set_mixer_quality(ALLEGRO_MIXER* mixer, ALLEGRO_MIXER_QUALITY val);
	bool al_set_mixer_gain(ALLEGRO_MIXER* mixer, float gain);
	bool al_set_mixer_playing(ALLEGRO_MIXER* mixer, bool val);
	bool al_detach_mixer(ALLEGRO_MIXER* mixer);

	ALLEGRO_VOICE* al_create_voice(uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);
	void al_destroy_voice(ALLEGRO_VOICE* voice);
	bool al_attach_sample_instance_to_voice(ALLEGRO_SAMPLE_INSTANCE* stream, ALLEGRO_VOICE* voice);
	bool al_attach_audio_stream_to_voice(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_VOICE* voice );
	bool al_attach_mixer_to_voice(ALLEGRO_MIXER* mixer, ALLEGRO_VOICE* voice);
	void al_detach_voice(ALLEGRO_VOICE* voice);

	uint al_get_voice_frequency(const(ALLEGRO_VOICE)* voice);
	uint al_get_voice_position(const(ALLEGRO_VOICE)* voice);
	ALLEGRO_CHANNEL_CONF al_get_voice_channels(const(ALLEGRO_VOICE)* voice);
	ALLEGRO_AUDIO_DEPTH al_get_voice_depth(const(ALLEGRO_VOICE)* voice);
	bool al_get_voice_playing(const(ALLEGRO_VOICE)* voice);
	bool al_set_voice_position(ALLEGRO_VOICE* voice, uint val);
	bool al_set_voice_playing(ALLEGRO_VOICE* voice, bool val);

	bool al_install_audio();
	void al_uninstall_audio();
	bool al_is_audio_installed();
	uint al_get_allegro_audio_version();

	size_t al_get_channel_count(ALLEGRO_CHANNEL_CONF conf);
	size_t al_get_audio_depth_size(ALLEGRO_AUDIO_DEPTH conf);

	void al_fill_silence(void* buf, uint samples,ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);

	bool al_reserve_samples(int reserve_samples);
	ALLEGRO_MIXER* al_get_default_mixer();
	bool al_set_default_mixer(ALLEGRO_MIXER* mixer);
	bool al_restore_default_mixer();
	bool al_play_sample(ALLEGRO_SAMPLE* data,float gain, float pan, float speed, ALLEGRO_PLAYMODE loop, ALLEGRO_SAMPLE_ID* ret_id);
	void al_stop_sample(ALLEGRO_SAMPLE_ID* spl_id);
	void al_stop_samples();
	ALLEGRO_VOICE* al_get_default_voice();
	void al_set_default_voice(ALLEGRO_VOICE* voice);

	bool al_register_sample_loader(const(char)* ext,ALLEGRO_SAMPLE* function(const(char)* filename) loader);
	bool al_register_sample_saver(const(char)* ext,bool function(const(char)* filename, ALLEGRO_SAMPLE* spl) saver);
	bool al_register_audio_stream_loader(const(char)* ext,ALLEGRO_AUDIO_STREAM* function(const(char)* filename,size_t buffer_count, uint samples) stream_loader);
			 
	bool al_register_sample_loader_f(const(char)* ext,ALLEGRO_SAMPLE* function(ALLEGRO_FILE* fp) loader);
	bool al_register_sample_saver_f(const(char)* ext,bool function(ALLEGRO_FILE* fp, ALLEGRO_SAMPLE* spl) saver);
	bool al_register_audio_stream_loader_f(const(char)* ext,ALLEGRO_AUDIO_STREAM* function(ALLEGRO_FILE* fp, size_t buffer_count, uint samples) stream_loader);

	ALLEGRO_SAMPLE* al_load_sample(const(char)* filename);
	bool al_save_sample(const(char)* filename,ALLEGRO_SAMPLE* spl);
	ALLEGRO_AUDIO_STREAM* al_load_audio_stream(const(char)* filename,size_t buffer_count, uint samples);
		
	ALLEGRO_SAMPLE* al_load_sample_f(ALLEGRO_FILE* fp, const(char)* ident);
	bool al_save_sample_f(ALLEGRO_FILE* fp, const(char)* ident,ALLEGRO_SAMPLE* spl);
	ALLEGRO_AUDIO_STREAM* al_load_audio_stream_f(ALLEGRO_FILE* fp, const(char)* ident,size_t buffer_count, uint samples);


	version (ALLEGRO_UNSTABLE) {
		ALLEGRO_AUDIO_RECORDER* al_create_audio_recorder(size_t fragment_count,uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);
		bool al_start_audio_recorder(ALLEGRO_AUDIO_RECORDER* r);
		void al_stop_audio_recorder(ALLEGRO_AUDIO_RECORDER* r);
		bool al_is_audio_recorder_recording(ALLEGRO_AUDIO_RECORDER* r);
		ALLEGRO_EVENT_SOURCE* al_get_audio_recorder_event_source(ALLEGRO_AUDIO_RECORDER* r);
		ALLEGRO_AUDIO_RECORDER_EVENT* al_get_audio_recorder_event(ALLEGRO_EVENT* event);
		void al_destroy_audio_recorder(ALLEGRO_AUDIO_RECORDER* r);
	}

	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
		bool al_set_sample_instance_channel_matrix(ALLEGRO_SAMPLE_INSTANCE* spl, const(float)* matrix);
		bool al_set_audio_stream_channel_matrix(ALLEGRO_AUDIO_STREAM* stream, const(float)* matrix);

		ALLEGRO_SAMPLE_INSTANCE* al_lock_sample_id(ALLEGRO_SAMPLE_ID* spl_id);
		void al_unlock_sample_id(ALLEGRO_SAMPLE_ID* spl_id);
	}

	static if (allegroSupport >= AllegroSupport.v5_2_8) {
		const(char)* al_identify_sample_f(ALLEGRO_FILE* fp);
		const(char)* al_identify_sample(const(char)* filename);
		int al_get_num_audio_output_devices();
		const(ALLEGRO_AUDIO_DEVICE)* al_get_audio_output_device(int index);
		const(char)* al_get_audio_device_name(const(ALLEGRO_AUDIO_DEVICE)* device);
		bool al_register_sample_identifier(const(char)* ext,bool function(ALLEGRO_FILE* fp) identifier);

		version(ALLEGRO_UNSTABLE) {
			ALLEGRO_AUDIO_STREAM* al_play_audio_stream(const(char)* filename);
			ALLEGRO_AUDIO_STREAM* al_play_audio_stream_f(ALLEGRO_FILE* fp, const(char)* ident);
		}
	}
}
else {
	extern(C) @nogc nothrow {
		alias pal_create_sample = ALLEGRO_SAMPLE* function(void* buf,uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf, bool free_buf);
		alias pal_destroy_sample = void function(ALLEGRO_SAMPLE* spl);

		alias pal_create_sample_instance = ALLEGRO_SAMPLE_INSTANCE* function(ALLEGRO_SAMPLE* data);
		alias pal_destroy_sample_instance = void function(ALLEGRO_SAMPLE_INSTANCE* spl);

		alias pal_get_sample_frequency = uint function(const(ALLEGRO_SAMPLE)* spl);
		alias pal_get_sample_length = uint function(const(ALLEGRO_SAMPLE)* spl);
		alias pal_get_sample_depth = ALLEGRO_AUDIO_DEPTH function(const(ALLEGRO_SAMPLE)* spl);
		alias pal_get_sample_channels = ALLEGRO_CHANNEL_CONF function(const(ALLEGRO_SAMPLE)* spl);
		alias pal_get_sample_data = void* function(const(ALLEGRO_SAMPLE)* spl);

		alias pal_get_sample_instance_frequency = uint function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
		alias pal_get_sample_instance_length = uint function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
		alias pal_get_sample_instance_position = uint function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);

		alias pal_get_sample_instance_speed = float function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
		alias pal_get_sample_instance_gain = float function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
		alias pal_get_sample_instance_pan = float function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
		alias pal_get_sample_instance_time = float function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);

		alias pal_get_sample_instance_depth = ALLEGRO_AUDIO_DEPTH function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
		alias pal_get_sample_instance_channels = ALLEGRO_CHANNEL_CONF function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
		alias pal_get_sample_instance_playmode = ALLEGRO_PLAYMODE function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);

		alias pal_get_sample_instance_playing = bool function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);
		alias pal_get_sample_instance_attached = bool function(const(ALLEGRO_SAMPLE_INSTANCE)* spl);

		alias pal_set_sample_instance_position = bool function(ALLEGRO_SAMPLE_INSTANCE* spl, uint val);
		alias pal_set_sample_instance_length = bool function(ALLEGRO_SAMPLE_INSTANCE* spl, uint val);

		alias pal_set_sample_instance_speed = bool function(ALLEGRO_SAMPLE_INSTANCE* spl, float val);
		alias pal_set_sample_instance_gain = bool function(ALLEGRO_SAMPLE_INSTANCE* spl, float val);
		alias pal_set_sample_instance_pan = bool function(ALLEGRO_SAMPLE_INSTANCE* spl, float val);

		alias pal_set_sample_instance_playmode = bool function(ALLEGRO_SAMPLE_INSTANCE* spl, ALLEGRO_PLAYMODE val);

		alias pal_set_sample_instance_playing = bool function(ALLEGRO_SAMPLE_INSTANCE* spl, bool val);
		alias pal_detach_sample_instance = bool function(ALLEGRO_SAMPLE_INSTANCE* spl);

		alias pal_set_sample = bool function(ALLEGRO_SAMPLE_INSTANCE* spl, ALLEGRO_SAMPLE* data);
		alias pal_get_sample = ALLEGRO_SAMPLE* function(ALLEGRO_SAMPLE_INSTANCE* spl);
		alias pal_play_sample_instance = bool function(ALLEGRO_SAMPLE_INSTANCE* spl);
		alias pal_stop_sample_instance = bool function(ALLEGRO_SAMPLE_INSTANCE* spl);

		alias pal_create_audio_stream = ALLEGRO_AUDIO_STREAM* function(size_t buffer_count, uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);
		alias pal_destroy_audio_stream = void function(ALLEGRO_AUDIO_STREAM* stream);
		alias pal_drain_audio_stream = void function(ALLEGRO_AUDIO_STREAM* stream);

		alias pal_get_audio_stream_frequency = uint function(const(ALLEGRO_AUDIO_STREAM)* stream);
		alias pal_get_audio_stream_length = uint function(const(ALLEGRO_AUDIO_STREAM)* stream);
		alias pal_get_audio_stream_fragments = uint function(const(ALLEGRO_AUDIO_STREAM)* stream);
		alias pal_get_available_audio_stream_fragments = uint function(const(ALLEGRO_AUDIO_STREAM)* stream);

		alias pal_get_audio_stream_speed = float function(const(ALLEGRO_AUDIO_STREAM)* stream);
		alias pal_get_audio_stream_gain = float function(const(ALLEGRO_AUDIO_STREAM)* stream);
		alias pal_get_audio_stream_pan = float function(const(ALLEGRO_AUDIO_STREAM)* stream);

		alias pal_get_audio_stream_channels = ALLEGRO_CHANNEL_CONF function(const(ALLEGRO_AUDIO_STREAM)* stream);
		alias pal_get_audio_stream_depth = ALLEGRO_AUDIO_DEPTH function(const(ALLEGRO_AUDIO_STREAM)* stream);
		alias pal_get_audio_stream_playmode = ALLEGRO_PLAYMODE function(const(ALLEGRO_AUDIO_STREAM)* stream);

		alias pal_get_audio_stream_playing = bool function(const(ALLEGRO_AUDIO_STREAM)* spl);
		alias pal_get_audio_stream_attached = bool function(const(ALLEGRO_AUDIO_STREAM)* spl);
		alias pal_get_audio_stream_played_samples = ulong function(const(ALLEGRO_AUDIO_STREAM)* stream);

		alias pal_get_audio_stream_fragment = void* function(const(ALLEGRO_AUDIO_STREAM)* stream);

		alias pal_set_audio_stream_speed = bool function(ALLEGRO_AUDIO_STREAM* stream, float val);
		alias pal_set_audio_stream_gain = bool function(ALLEGRO_AUDIO_STREAM* stream, float val);
		alias pal_set_audio_stream_pan = bool function(ALLEGRO_AUDIO_STREAM* stream, float val);

		alias pal_set_audio_stream_playmode = bool function(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_PLAYMODE val);

		alias pal_set_audio_stream_playing = bool function(ALLEGRO_AUDIO_STREAM* stream, bool val);
		alias pal_detach_audio_stream = bool function(ALLEGRO_AUDIO_STREAM* stream);
		alias pal_set_audio_stream_fragment = bool function(ALLEGRO_AUDIO_STREAM* stream, void* val);

		alias pal_rewind_audio_stream = bool function(ALLEGRO_AUDIO_STREAM* stream);
		alias pal_seek_audio_stream_secs = bool function(ALLEGRO_AUDIO_STREAM* stream, double time);
		alias pal_get_audio_stream_position_secs = double function(ALLEGRO_AUDIO_STREAM* stream);
		alias pal_get_audio_stream_length_secs = double function(ALLEGRO_AUDIO_STREAM* stream);
		alias pal_set_audio_stream_loop_secs = bool function(ALLEGRO_AUDIO_STREAM* stream, double start, double end);

		alias pal_get_audio_stream_event_source = ALLEGRO_EVENT_SOURCE* function(ALLEGRO_AUDIO_STREAM* stream);

		alias pal_create_mixer = ALLEGRO_MIXER* function(uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);
		alias pal_destroy_mixer = void function(ALLEGRO_MIXER* mixer);
		alias pal_attach_sample_instance_to_mixer = bool function( ALLEGRO_SAMPLE_INSTANCE* stream, ALLEGRO_MIXER* mixer);
		alias pal_attach_audio_stream_to_mixer = bool function(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_MIXER* mixer);
		alias pal_attach_mixer_to_mixer = bool function(ALLEGRO_MIXER* stream, ALLEGRO_MIXER* mixer);
		alias pal_set_mixer_postprocess_callback = bool function(ALLEGRO_MIXER* mixer, void function(void* buf, uint samples, void* data)cb, void* data);

		alias pal_get_mixer_frequency = uint function(const(ALLEGRO_MIXER)* mixer);
		alias pal_get_mixer_channels = ALLEGRO_CHANNEL_CONF function(const(ALLEGRO_MIXER)* mixer);
		alias pal_get_mixer_depth = ALLEGRO_AUDIO_DEPTH function(const(ALLEGRO_MIXER)* mixer);
		alias pal_get_mixer_quality = ALLEGRO_MIXER_QUALITY function(const(ALLEGRO_MIXER)* mixer);
		alias pal_get_mixer_gain = float function(const(ALLEGRO_MIXER)* mixer);
		alias pal_get_mixer_playing = bool function(const(ALLEGRO_MIXER)* mixer);
		alias pal_get_mixer_attached = bool function(const(ALLEGRO_MIXER)* mixer);
		alias pal_set_mixer_frequency = bool function(ALLEGRO_MIXER* mixer, uint val);
		alias pal_set_mixer_quality = bool function(ALLEGRO_MIXER* mixer, ALLEGRO_MIXER_QUALITY val);
		alias pal_set_mixer_gain = bool function(ALLEGRO_MIXER* mixer, float gain);
		alias pal_set_mixer_playing = bool function(ALLEGRO_MIXER* mixer, bool val);
		alias pal_detach_mixer = bool function(ALLEGRO_MIXER* mixer);

		alias pal_create_voice = ALLEGRO_VOICE* function(uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);
		alias pal_destroy_voice = void function(ALLEGRO_VOICE* voice);
		alias pal_attach_sample_instance_to_voice = bool function(ALLEGRO_SAMPLE_INSTANCE* stream, ALLEGRO_VOICE* voice);
		alias pal_attach_audio_stream_to_voice = bool function(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_VOICE* voice );
		alias pal_attach_mixer_to_voice = bool function(ALLEGRO_MIXER* mixer, ALLEGRO_VOICE* voice);
		alias pal_detach_voice = void function(ALLEGRO_VOICE* voice);

		alias pal_get_voice_frequency = uint function(const(ALLEGRO_VOICE)* voice);
		alias pal_get_voice_position = uint function(const(ALLEGRO_VOICE)* voice);
		alias pal_get_voice_channels = ALLEGRO_CHANNEL_CONF function(const(ALLEGRO_VOICE)* voice);
		alias pal_get_voice_depth = ALLEGRO_AUDIO_DEPTH function(const(ALLEGRO_VOICE)* voice);
		alias pal_get_voice_playing = bool function(const(ALLEGRO_VOICE)* voice);
		alias pal_set_voice_position = bool function(ALLEGRO_VOICE* voice, uint val);
		alias pal_set_voice_playing = bool function(ALLEGRO_VOICE* voice, bool val);

		alias pal_install_audio = bool function();
		alias pal_uninstall_audio = void function();
		alias pal_is_audio_installed = bool function();
		alias pal_get_allegro_audio_version = uint function();

		alias pal_get_channel_count = size_t function(ALLEGRO_CHANNEL_CONF conf);
		alias pal_get_audio_depth_size = size_t function(ALLEGRO_AUDIO_DEPTH conf);

		alias pal_fill_silence = void function(void* buf, uint samples,ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);

		alias pal_reserve_samples = bool function(int reserve_samples);
		alias pal_get_default_mixer = ALLEGRO_MIXER* function();
		alias pal_set_default_mixer = bool function(ALLEGRO_MIXER* mixer);
		alias pal_restore_default_mixer = bool function();
		alias pal_play_sample = bool function(ALLEGRO_SAMPLE* data,float gain, float pan, float speed, ALLEGRO_PLAYMODE loop, ALLEGRO_SAMPLE_ID* ret_id);
		alias pal_stop_sample = void function(ALLEGRO_SAMPLE_ID* spl_id);
		alias pal_stop_samples = void function();
		alias pal_get_default_voice = ALLEGRO_VOICE* function();
		alias pal_set_default_voice = void function(ALLEGRO_VOICE* voice);

		alias pal_register_sample_loader = bool function(const(char)* ext,ALLEGRO_SAMPLE* function(const(char)* filename) loader);
		alias pal_register_sample_saver = bool function(const(char)* ext,bool function(const(char)* filename, ALLEGRO_SAMPLE* spl) saver);
		alias pal_register_audio_stream_loader = bool function(const(char)* ext,ALLEGRO_AUDIO_STREAM* function(const(char)* filename,size_t buffer_count, uint samples) stream_loader);
				 
		alias pal_register_sample_loader_f = bool function(const(char)* ext,ALLEGRO_SAMPLE* function(ALLEGRO_FILE* fp) loader);
		alias pal_register_sample_saver_f = bool function(const(char)* ext,bool function(ALLEGRO_FILE* fp, ALLEGRO_SAMPLE* spl) saver);
		alias pal_register_audio_stream_loader_f = bool function(const(char)* ext,ALLEGRO_AUDIO_STREAM* function(ALLEGRO_FILE* fp, size_t buffer_count, uint samples) stream_loader);

		alias pal_load_sample = ALLEGRO_SAMPLE* function(const(char)* filename);
		alias pal_save_sample = bool function(const(char)* filename,ALLEGRO_SAMPLE* spl);
		alias pal_load_audio_stream = ALLEGRO_AUDIO_STREAM* function(const(char)* filename,size_t buffer_count, uint samples);
			
		alias pal_load_sample_f = ALLEGRO_SAMPLE* function(ALLEGRO_FILE* fp, const(char)* ident);
		alias pal_save_sample_f = bool function(ALLEGRO_FILE* fp, const(char)* ident,ALLEGRO_SAMPLE* spl);
		alias pal_load_audio_stream_f = ALLEGRO_AUDIO_STREAM* function(ALLEGRO_FILE* fp, const(char)* ident,size_t buffer_count, uint samples);


		version (ALLEGRO_UNSTABLE) {
			alias pal_create_audio_recorder = ALLEGRO_AUDIO_RECORDER* function(size_t fragment_count,uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);
			alias pal_start_audio_recorder = bool function(ALLEGRO_AUDIO_RECORDER* r);
			alias pal_stop_audio_recorder = void function(ALLEGRO_AUDIO_RECORDER* r);
			alias pal_is_audio_recorder_recording = bool function(ALLEGRO_AUDIO_RECORDER* r);
			alias pal_get_audio_recorder_event_source = ALLEGRO_EVENT_SOURCE* function(ALLEGRO_AUDIO_RECORDER* r);
			alias pal_get_audio_recorder_event = ALLEGRO_AUDIO_RECORDER_EVENT* function(ALLEGRO_EVENT* event);
			alias pal_destroy_audio_recorder = void function(ALLEGRO_AUDIO_RECORDER* r);
		}

		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
			alias pal_set_sample_instance_channel_matrix = bool function(ALLEGRO_SAMPLE_INSTANCE* spl, const(float)* matrix);
			alias pal_set_audio_stream_channel_matrix = bool function(ALLEGRO_AUDIO_STREAM* stream, const(float)* matrix);

			alias pal_lock_sample_id = ALLEGRO_SAMPLE_INSTANCE* function(ALLEGRO_SAMPLE_ID* spl_id);
			alias pal_unlock_sample_id = void function(ALLEGRO_SAMPLE_ID* spl_id);
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			alias pal_identify_sample_f = const(char)* function(ALLEGRO_FILE* fp);
			alias pal_identify_sample = const(char)* function(const(char)* filename);
			alias pal_get_num_audio_output_devices = int function();
			alias pal_get_audio_output_device = const(ALLEGRO_AUDIO_DEVICE)* function(int index);
			alias pal_get_audio_device_name = const(char)* function(const(ALLEGRO_AUDIO_DEVICE)* device);
			alias pal_register_sample_identifier = bool function(const(char)* ext,bool function(ALLEGRO_FILE* fp) identifier);

			version(ALLEGRO_UNSTABLE) {
				alias pal_play_audio_stream = ALLEGRO_AUDIO_STREAM* function(const(char)* filename);
				alias pal_play_audio_stream_f = ALLEGRO_AUDIO_STREAM* function(ALLEGRO_FILE* fp, const(char)* ident);
			}
		}
	}
	__gshared {
		pal_create_sample al_create_sample;
		pal_destroy_sample al_destroy_sample;

		pal_create_sample_instance al_create_sample_instance;
		pal_destroy_sample_instance al_destroy_sample_instance;

		pal_get_sample_frequency al_get_sample_frequency;
		pal_get_sample_length al_get_sample_length;
		pal_get_sample_depth al_get_sample_depth;
		pal_get_sample_channels al_get_sample_channels;
		pal_get_sample_data al_get_sample_data;

		pal_get_sample_instance_frequency al_get_sample_instance_frequency;
		pal_get_sample_instance_length al_get_sample_instance_length;
		pal_get_sample_instance_position al_get_sample_instance_position;

		pal_get_sample_instance_speed al_get_sample_instance_speed;
		pal_get_sample_instance_gain al_get_sample_instance_gain;
		pal_get_sample_instance_pan al_get_sample_instance_pan;
		pal_get_sample_instance_time al_get_sample_instance_time;

		pal_get_sample_instance_depth al_get_sample_instance_depth;
		pal_get_sample_instance_channels al_get_sample_instance_channels;
		pal_get_sample_instance_playmode al_get_sample_instance_playmode;

		pal_get_sample_instance_playing al_get_sample_instance_playing;
		pal_get_sample_instance_attached al_get_sample_instance_attached;

		pal_set_sample_instance_position al_set_sample_instance_position;
		pal_set_sample_instance_length al_set_sample_instance_length;

		pal_set_sample_instance_speed al_set_sample_instance_speed;
		pal_set_sample_instance_gain al_set_sample_instance_gain;
		pal_set_sample_instance_pan al_set_sample_instance_pan;

		pal_set_sample_instance_playmode al_set_sample_instance_playmode;

		pal_set_sample_instance_playing al_set_sample_instance_playing;
		pal_detach_sample_instance al_detach_sample_instance;

		pal_set_sample al_set_sample;
		pal_get_sample al_get_sample;
		pal_play_sample_instance al_play_sample_instance;
		pal_stop_sample_instance al_stop_sample_instance;

		pal_create_audio_stream al_create_audio_stream;
		pal_destroy_audio_stream al_destroy_audio_stream;
		pal_drain_audio_stream al_drain_audio_stream;

		pal_get_audio_stream_frequency al_get_audio_stream_frequency;
		pal_get_audio_stream_length al_get_audio_stream_length;
		pal_get_audio_stream_fragments al_get_audio_stream_fragments;
		pal_get_available_audio_stream_fragments al_get_available_audio_stream_fragments;

		pal_get_audio_stream_speed al_get_audio_stream_speed;
		pal_get_audio_stream_gain al_get_audio_stream_gain;
		pal_get_audio_stream_pan al_get_audio_stream_pan;

		pal_get_audio_stream_channels al_get_audio_stream_channels;
		pal_get_audio_stream_depth al_get_audio_stream_depth;
		pal_get_audio_stream_playmode al_get_audio_stream_playmode;

		pal_get_audio_stream_playing al_get_audio_stream_playing;
		pal_get_audio_stream_attached al_get_audio_stream_attached;
		pal_get_audio_stream_played_samples al_get_audio_stream_played_samples;

		pal_get_audio_stream_fragment al_get_audio_stream_fragment;

		pal_set_audio_stream_speed al_set_audio_stream_speed;
		pal_set_audio_stream_gain al_set_audio_stream_gain;
		pal_set_audio_stream_pan al_set_audio_stream_pan;

		pal_set_audio_stream_playmode al_set_audio_stream_playmode;

		pal_set_audio_stream_playing al_set_audio_stream_playing;
		pal_detach_audio_stream al_detach_audio_stream;
		pal_set_audio_stream_fragment al_set_audio_stream_fragment;

		pal_rewind_audio_stream al_rewind_audio_stream;
		pal_seek_audio_stream_secs al_seek_audio_stream_secs;
		pal_get_audio_stream_position_secs al_get_audio_stream_position_secs;
		pal_get_audio_stream_length_secs al_get_audio_stream_length_secs;
		pal_set_audio_stream_loop_secs al_set_audio_stream_loop_secs;

		pal_get_audio_stream_event_source al_get_audio_stream_event_source;

		pal_create_mixer al_create_mixer;
		pal_destroy_mixer al_destroy_mixer;
		pal_attach_sample_instance_to_mixer al_attach_sample_instance_to_mixer;
		pal_attach_audio_stream_to_mixer al_attach_audio_stream_to_mixer;
		pal_attach_mixer_to_mixer al_attach_mixer_to_mixer;
		pal_set_mixer_postprocess_callback al_set_mixer_postprocess_callback;

		pal_get_mixer_frequency al_get_mixer_frequency;
		pal_get_mixer_channels al_get_mixer_channels;
		pal_get_mixer_depth al_get_mixer_depth;
		pal_get_mixer_quality al_get_mixer_quality;
		pal_get_mixer_gain al_get_mixer_gain;
		pal_get_mixer_playing al_get_mixer_playing;
		pal_get_mixer_attached al_get_mixer_attached;
		pal_set_mixer_frequency al_set_mixer_frequency;
		pal_set_mixer_quality al_set_mixer_quality;
		pal_set_mixer_gain al_set_mixer_gain;
		pal_set_mixer_playing al_set_mixer_playing;
		pal_detach_mixer al_detach_mixer;

		pal_create_voice al_create_voice;
		pal_destroy_voice al_destroy_voice;
		pal_attach_sample_instance_to_voice al_attach_sample_instance_to_voice;
		pal_attach_audio_stream_to_voice al_attach_audio_stream_to_voice;
		pal_attach_mixer_to_voice al_attach_mixer_to_voice;
		pal_detach_voice al_detach_voice;

		pal_get_voice_frequency al_get_voice_frequency;
		pal_get_voice_position al_get_voice_position;
		pal_get_voice_channels al_get_voice_channels;
		pal_get_voice_depth al_get_voice_depth;
		pal_get_voice_playing al_get_voice_playing;
		pal_set_voice_position al_set_voice_position;
		pal_set_voice_playing al_set_voice_playing;

		pal_install_audio al_install_audio;
		pal_uninstall_audio al_uninstall_audio;
		pal_is_audio_installed al_is_audio_installed;
		pal_get_allegro_audio_version al_get_allegro_audio_version;

		pal_get_channel_count al_get_channel_count;
		pal_get_audio_depth_size al_get_audio_depth_size;

		pal_fill_silence al_fill_silence;

		pal_reserve_samples al_reserve_samples;
		pal_get_default_mixer al_get_default_mixer;
		pal_set_default_mixer al_set_default_mixer;
		pal_restore_default_mixer al_restore_default_mixer;
		pal_play_sample al_play_sample;
		pal_stop_sample al_stop_sample;
		pal_stop_samples al_stop_samples;
		pal_get_default_voice al_get_default_voice;
		pal_set_default_voice al_set_default_voice;

		pal_register_sample_loader al_register_sample_loader;
		pal_register_sample_saver al_register_sample_saver;
		pal_register_audio_stream_loader al_register_audio_stream_loader;
				 
		pal_register_sample_loader_f al_register_sample_loader_f;
		pal_register_sample_saver_f al_register_sample_saver_f;
		pal_register_audio_stream_loader_f al_register_audio_stream_loader_f;

		pal_load_sample al_load_sample;
		pal_save_sample al_save_sample;
		pal_load_audio_stream al_load_audio_stream;
			
		pal_load_sample_f al_load_sample_f;
		pal_save_sample_f al_save_sample_f;
		pal_load_audio_stream_f al_load_audio_stream_f;


		version (ALLEGRO_UNSTABLE) {
			/* “The API may need a slight redesign” */
			pal_create_audio_recorder al_create_audio_recorder;
			pal_start_audio_recorder al_start_audio_recorder;
			pal_stop_audio_recorder al_stop_audio_recorder;
			pal_is_audio_recorder_recording al_is_audio_recorder_recording;
			pal_get_audio_recorder_event_source al_get_audio_recorder_event_source;
			pal_get_audio_recorder_event al_get_audio_recorder_event;
			pal_destroy_audio_recorder al_destroy_audio_recorder;
		}

		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
			pal_set_sample_instance_channel_matrix al_set_sample_instance_channel_matrix;
			pal_set_audio_stream_channel_matrix al_set_audio_stream_channel_matrix;

			pal_lock_sample_id al_lock_sample_id;
			pal_unlock_sample_id al_unlock_sample_id;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			pal_identify_sample_f al_identify_sample_f;
			pal_identify_sample al_identify_sample;
			pal_get_num_audio_output_devices al_get_num_audio_output_devices;
			pal_get_audio_output_device al_get_audio_output_device;
			pal_get_audio_device_name al_get_audio_device_name;
			pal_register_sample_identifier al_register_sample_identifier;

			version(ALLEGRO_UNSTABLE) {
				pal_play_audio_stream al_play_audio_stream;
				pal_play_audio_stream_f al_play_audio_stream_f;
			}
		}
	}

	import bindbc.loader;

	@nogc nothrow:

	version (Allegro_Monolith) {} else { 

		private {
			__gshared SharedLib lib;
			__gshared AllegroSupport loadedVersion;
		}

		void unloadAllegroAudio() {
			if (lib != invalidHandle) {
				lib.unload();
			}
		}

		AllegroSupport loadedAllegroAudioVersion() {
			return loadedVersion; 
		}

		bool isAllegroAudioLoaded() {
			return lib != invalidHandle;
		}

		AllegroSupport loadAllegroAudio() {

			const(char)[][1] libNames = [
				libName!"audio",
			];

			typeof(return) result;
			foreach (i; 0..libNames.length) {
				result = loadAllegroAudio(libNames[i].ptr);
				if (result != AllegroSupport.noLibrary) {
					break;
				}
			}
			return result;
		}

		AllegroSupport loadAllegroAudio(const(char)* libName) {
			lib = load(libName);
			if (lib == invalidHandle) {
				return AllegroSupport.noLibrary;
			}
			loadedVersion = bindAllegroAudio(lib, libName);
			return loadedVersion;
		}
	}

	package AllegroSupport bindAllegroAudio(SharedLib lib, const(char)* libName) {

		auto lastErrorCount = errorCount();
		auto loadedVersion = AllegroSupport.badLibrary;

		lib.bindSymbol(cast(void**)&al_create_sample, "al_create_sample");
		lib.bindSymbol(cast(void**)&al_destroy_sample, "al_destroy_sample");

		lib.bindSymbol(cast(void**)&al_create_sample_instance, "al_create_sample_instance");
		lib.bindSymbol(cast(void**)&al_destroy_sample_instance, "al_destroy_sample_instance");

		lib.bindSymbol(cast(void**)&al_get_sample_frequency, "al_get_sample_frequency");
		lib.bindSymbol(cast(void**)&al_get_sample_length, "al_get_sample_length");
		lib.bindSymbol(cast(void**)&al_get_sample_depth, "al_get_sample_depth");
		lib.bindSymbol(cast(void**)&al_get_sample_channels, "al_get_sample_channels");
		lib.bindSymbol(cast(void**)&al_get_sample_data, "al_get_sample_data");

		lib.bindSymbol(cast(void**)&al_get_sample_instance_frequency, "al_get_sample_instance_frequency");
		lib.bindSymbol(cast(void**)&al_get_sample_instance_length, "al_get_sample_instance_length");
		lib.bindSymbol(cast(void**)&al_get_sample_instance_position, "al_get_sample_instance_position");

		lib.bindSymbol(cast(void**)&al_get_sample_instance_speed, "al_get_sample_instance_speed");
		lib.bindSymbol(cast(void**)&al_get_sample_instance_gain, "al_get_sample_instance_gain");
		lib.bindSymbol(cast(void**)&al_get_sample_instance_pan, "al_get_sample_instance_pan");
		lib.bindSymbol(cast(void**)&al_get_sample_instance_time, "al_get_sample_instance_time");

		lib.bindSymbol(cast(void**)&al_get_sample_instance_depth, "al_get_sample_instance_depth");
		lib.bindSymbol(cast(void**)&al_get_sample_instance_channels, "al_get_sample_instance_channels");
		lib.bindSymbol(cast(void**)&al_get_sample_instance_playmode, "al_get_sample_instance_playmode");

		lib.bindSymbol(cast(void**)&al_get_sample_instance_playing, "al_get_sample_instance_playing");
		lib.bindSymbol(cast(void**)&al_get_sample_instance_attached, "al_get_sample_instance_attached");

		lib.bindSymbol(cast(void**)&al_set_sample_instance_position, "al_set_sample_instance_position");
		lib.bindSymbol(cast(void**)&al_set_sample_instance_length, "al_set_sample_instance_length");

		lib.bindSymbol(cast(void**)&al_set_sample_instance_speed, "al_set_sample_instance_speed");
		lib.bindSymbol(cast(void**)&al_set_sample_instance_gain, "al_set_sample_instance_gain");
		lib.bindSymbol(cast(void**)&al_set_sample_instance_pan, "al_set_sample_instance_pan");

		lib.bindSymbol(cast(void**)&al_set_sample_instance_playmode, "al_set_sample_instance_playmode");

		lib.bindSymbol(cast(void**)&al_set_sample_instance_playing, "al_set_sample_instance_playing");
		lib.bindSymbol(cast(void**)&al_detach_sample_instance, "al_detach_sample_instance");

		lib.bindSymbol(cast(void**)&al_set_sample, "al_set_sample");
		lib.bindSymbol(cast(void**)&al_get_sample, "al_get_sample");
		lib.bindSymbol(cast(void**)&al_play_sample_instance, "al_play_sample_instance");
		lib.bindSymbol(cast(void**)&al_stop_sample_instance, "al_stop_sample_instance");

		lib.bindSymbol(cast(void**)&al_create_audio_stream, "al_create_audio_stream");
		lib.bindSymbol(cast(void**)&al_destroy_audio_stream, "al_destroy_audio_stream");
		lib.bindSymbol(cast(void**)&al_drain_audio_stream, "al_drain_audio_stream");

		lib.bindSymbol(cast(void**)&al_get_audio_stream_frequency, "al_get_audio_stream_frequency");
		lib.bindSymbol(cast(void**)&al_get_audio_stream_length, "al_get_audio_stream_length");
		lib.bindSymbol(cast(void**)&al_get_audio_stream_fragments, "al_get_audio_stream_fragments");
		lib.bindSymbol(cast(void**)&al_get_available_audio_stream_fragments, "al_get_available_audio_stream_fragments");

		lib.bindSymbol(cast(void**)&al_get_audio_stream_speed, "al_get_audio_stream_speed");
		lib.bindSymbol(cast(void**)&al_get_audio_stream_gain, "al_get_audio_stream_gain");
		lib.bindSymbol(cast(void**)&al_get_audio_stream_pan, "al_get_audio_stream_pan");

		lib.bindSymbol(cast(void**)&al_get_audio_stream_channels, "al_get_audio_stream_channels");
		lib.bindSymbol(cast(void**)&al_get_audio_stream_depth, "al_get_audio_stream_depth");
		lib.bindSymbol(cast(void**)&al_get_audio_stream_playmode, "al_get_audio_stream_playmode");

		lib.bindSymbol(cast(void**)&al_get_audio_stream_playing, "al_get_audio_stream_playing");
		lib.bindSymbol(cast(void**)&al_get_audio_stream_attached, "al_get_audio_stream_attached");
		lib.bindSymbol(cast(void**)&al_get_audio_stream_played_samples, "al_get_audio_stream_played_samples");

		lib.bindSymbol(cast(void**)&al_get_audio_stream_fragment, "al_get_audio_stream_fragment");

		lib.bindSymbol(cast(void**)&al_set_audio_stream_speed, "al_set_audio_stream_speed");
		lib.bindSymbol(cast(void**)&al_set_audio_stream_gain, "al_set_audio_stream_gain");
		lib.bindSymbol(cast(void**)&al_set_audio_stream_pan, "al_set_audio_stream_pan");

		lib.bindSymbol(cast(void**)&al_set_audio_stream_playmode, "al_set_audio_stream_playmode");

		lib.bindSymbol(cast(void**)&al_set_audio_stream_playing, "al_set_audio_stream_playing");
		lib.bindSymbol(cast(void**)&al_detach_audio_stream, "al_detach_audio_stream");
		lib.bindSymbol(cast(void**)&al_set_audio_stream_fragment, "al_set_audio_stream_fragment");

		lib.bindSymbol(cast(void**)&al_rewind_audio_stream, "al_rewind_audio_stream");
		lib.bindSymbol(cast(void**)&al_seek_audio_stream_secs, "al_seek_audio_stream_secs");
		lib.bindSymbol(cast(void**)&al_get_audio_stream_position_secs, "al_get_audio_stream_position_secs");
		lib.bindSymbol(cast(void**)&al_get_audio_stream_length_secs, "al_get_audio_stream_length_secs");
		lib.bindSymbol(cast(void**)&al_set_audio_stream_loop_secs, "al_set_audio_stream_loop_secs");

		lib.bindSymbol(cast(void**)&al_get_audio_stream_event_source, "al_get_audio_stream_event_source");

		lib.bindSymbol(cast(void**)&al_create_mixer, "al_create_mixer");
		lib.bindSymbol(cast(void**)&al_destroy_mixer, "al_destroy_mixer");
		lib.bindSymbol(cast(void**)&al_attach_sample_instance_to_mixer, "al_attach_sample_instance_to_mixer");
		lib.bindSymbol(cast(void**)&al_attach_audio_stream_to_mixer, "al_attach_audio_stream_to_mixer");
		lib.bindSymbol(cast(void**)&al_attach_mixer_to_mixer, "al_attach_mixer_to_mixer");
		lib.bindSymbol(cast(void**)&al_set_mixer_postprocess_callback, "al_set_mixer_postprocess_callback");

		lib.bindSymbol(cast(void**)&al_get_mixer_frequency, "al_get_mixer_frequency");
		lib.bindSymbol(cast(void**)&al_get_mixer_channels, "al_get_mixer_channels");
		lib.bindSymbol(cast(void**)&al_get_mixer_depth, "al_get_mixer_depth");
		lib.bindSymbol(cast(void**)&al_get_mixer_quality, "al_get_mixer_quality");
		lib.bindSymbol(cast(void**)&al_get_mixer_gain, "al_get_mixer_gain");
		lib.bindSymbol(cast(void**)&al_get_mixer_playing, "al_get_mixer_playing");
		lib.bindSymbol(cast(void**)&al_get_mixer_attached, "al_get_mixer_attached");
		lib.bindSymbol(cast(void**)&al_set_mixer_frequency, "al_set_mixer_frequency");
		lib.bindSymbol(cast(void**)&al_set_mixer_quality, "al_set_mixer_quality");
		lib.bindSymbol(cast(void**)&al_set_mixer_gain, "al_set_mixer_gain");
		lib.bindSymbol(cast(void**)&al_set_mixer_playing, "al_set_mixer_playing");
		lib.bindSymbol(cast(void**)&al_detach_mixer, "al_detach_mixer");

		lib.bindSymbol(cast(void**)&al_create_voice, "al_create_voice");
		lib.bindSymbol(cast(void**)&al_destroy_voice, "al_destroy_voice");
		lib.bindSymbol(cast(void**)&al_attach_sample_instance_to_voice, "al_attach_sample_instance_to_voice");
		lib.bindSymbol(cast(void**)&al_attach_audio_stream_to_voice, "al_attach_audio_stream_to_voice");
		lib.bindSymbol(cast(void**)&al_attach_mixer_to_voice, "al_attach_mixer_to_voice");
		lib.bindSymbol(cast(void**)&al_detach_voice, "al_detach_voice");

		lib.bindSymbol(cast(void**)&al_get_voice_frequency, "al_get_voice_frequency");
		lib.bindSymbol(cast(void**)&al_get_voice_position, "al_get_voice_position");
		lib.bindSymbol(cast(void**)&al_get_voice_channels, "al_get_voice_channels");
		lib.bindSymbol(cast(void**)&al_get_voice_depth, "al_get_voice_depth");
		lib.bindSymbol(cast(void**)&al_get_voice_playing, "al_get_voice_playing");
		lib.bindSymbol(cast(void**)&al_set_voice_position, "al_set_voice_position");
		lib.bindSymbol(cast(void**)&al_set_voice_playing, "al_set_voice_playing");

		lib.bindSymbol(cast(void**)&al_install_audio, "al_install_audio");
		lib.bindSymbol(cast(void**)&al_uninstall_audio, "al_uninstall_audio");
		lib.bindSymbol(cast(void**)&al_is_audio_installed, "al_is_audio_installed");
		lib.bindSymbol(cast(void**)&al_get_allegro_audio_version, "al_get_allegro_audio_version");

		lib.bindSymbol(cast(void**)&al_get_channel_count, "al_get_channel_count");
		lib.bindSymbol(cast(void**)&al_get_audio_depth_size, "al_get_audio_depth_size");

		lib.bindSymbol(cast(void**)&al_fill_silence, "al_fill_silence");

		lib.bindSymbol(cast(void**)&al_reserve_samples, "al_reserve_samples");
		lib.bindSymbol(cast(void**)&al_get_default_mixer, "al_get_default_mixer");
		lib.bindSymbol(cast(void**)&al_set_default_mixer, "al_set_default_mixer");
		lib.bindSymbol(cast(void**)&al_restore_default_mixer, "al_restore_default_mixer");
		lib.bindSymbol(cast(void**)&al_play_sample, "al_play_sample");
		lib.bindSymbol(cast(void**)&al_stop_sample, "al_stop_sample");
		lib.bindSymbol(cast(void**)&al_stop_samples, "al_stop_samples");
		lib.bindSymbol(cast(void**)&al_get_default_voice, "al_get_default_voice");
		lib.bindSymbol(cast(void**)&al_set_default_voice, "al_set_default_voice");

		lib.bindSymbol(cast(void**)&al_register_sample_loader, "al_register_sample_loader");
		lib.bindSymbol(cast(void**)&al_register_sample_saver, "al_register_sample_saver");
		lib.bindSymbol(cast(void**)&al_register_audio_stream_loader, "al_register_audio_stream_loader");
				 
		lib.bindSymbol(cast(void**)&al_register_sample_loader_f, "al_register_sample_loader_f");
		lib.bindSymbol(cast(void**)&al_register_sample_saver_f, "al_register_sample_saver_f");
		lib.bindSymbol(cast(void**)&al_register_audio_stream_loader_f, "al_register_audio_stream_loader_f");

		lib.bindSymbol(cast(void**)&al_load_sample, "al_load_sample");
		lib.bindSymbol(cast(void**)&al_save_sample, "al_save_sample");
		lib.bindSymbol(cast(void**)&al_load_audio_stream, "al_load_audio_stream");
			
		lib.bindSymbol(cast(void**)&al_load_sample_f, "al_load_sample_f");
		lib.bindSymbol(cast(void**)&al_save_sample_f, "al_save_sample_f");
		lib.bindSymbol(cast(void**)&al_load_audio_stream_f, "al_load_audio_stream_f");


		version (ALLEGRO_UNSTABLE) {
			lib.bindSymbol(cast(void**)&al_create_audio_recorder, "al_create_audio_recorder");
			lib.bindSymbol(cast(void**)&al_start_audio_recorder, "al_start_audio_recorder");
			lib.bindSymbol(cast(void**)&al_stop_audio_recorder, "al_stop_audio_recorder");
			lib.bindSymbol(cast(void**)&al_is_audio_recorder_recording, "al_is_audio_recorder_recording");
			lib.bindSymbol(cast(void**)&al_get_audio_recorder_event_source, "al_get_audio_recorder_event_source");
			lib.bindSymbol(cast(void**)&al_get_audio_recorder_event, "al_get_audio_recorder_event");
			lib.bindSymbol(cast(void**)&al_destroy_audio_recorder, "al_destroy_audio_recorder");
		}

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}
		loadedVersion = AllegroSupport.v5_2_0;

		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
			lib.bindSymbol(cast(void**)&al_set_sample_instance_channel_matrix, "al_set_sample_instance_channel_matrix");
			lib.bindSymbol(cast(void**)&al_set_audio_stream_channel_matrix, "al_set_audio_stream_channel_matrix");

			lib.bindSymbol(cast(void**)&al_lock_sample_id, "al_lock_sample_id");
			lib.bindSymbol(cast(void**)&al_unlock_sample_id, "al_unlock_sample_id");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
			loadedVersion = AllegroSupport.v5_2_3;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			lib.bindSymbol(cast(void**)&al_identify_sample_f, "al_identify_sample_f");
			lib.bindSymbol(cast(void**)&al_identify_sample, "al_identify_sample");
			lib.bindSymbol(cast(void**)&al_get_num_audio_output_devices, "al_get_num_audio_output_devices");
			lib.bindSymbol(cast(void**)&al_get_audio_output_device, "al_get_audio_output_device");
			lib.bindSymbol(cast(void**)&al_get_audio_device_name, "al_get_audio_device_name");
			lib.bindSymbol(cast(void**)&al_register_sample_identifier, "al_register_sample_identifier");

			version(ALLEGRO_UNSTABLE) {
				lib.bindSymbol(cast(void**)&al_play_audio_stream, "al_play_audio_stream");
				lib.bindSymbol(cast(void**)&al_play_audio_stream_f, "al_play_audio_stream_f");
			}

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
			loadedVersion = AllegroSupport.v5_2_8;
		}

		return loadedVersion;
	}
}
