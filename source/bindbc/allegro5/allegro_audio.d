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
mixin ExpandEnum!ALLEGRO_AUDIO_EVENT_TYPE;

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
mixin ExpandEnum!ALLEGRO_AUDIO_DEPTH;

enum ALLEGRO_CHANNEL_CONF {
	ALLEGRO_CHANNEL_CONF_1   = 0x10,
	ALLEGRO_CHANNEL_CONF_2   = 0x20,
	ALLEGRO_CHANNEL_CONF_3   = 0x30,
	ALLEGRO_CHANNEL_CONF_4   = 0x40,
	ALLEGRO_CHANNEL_CONF_5_1 = 0x51,
	ALLEGRO_CHANNEL_CONF_6_1 = 0x61,
	ALLEGRO_CHANNEL_CONF_7_1 = 0x71,
}
mixin ExpandEnum!ALLEGRO_CHANNEL_CONF;

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
mixin ExpandEnum!ALLEGRO_PLAYMODE;

enum ALLEGRO_MIXER_QUALITY {
	ALLEGRO_MIXER_QUALITY_POINT   = 0x110,
	ALLEGRO_MIXER_QUALITY_LINEAR  = 0x111,
	ALLEGRO_MIXER_QUALITY_CUBIC   = 0x112,
}
mixin ExpandEnum!ALLEGRO_MIXER_QUALITY;


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

extern(C) @nogc nothrow {
	alias al_audio_mixer_callback = void function(void* buf, uint samples, void* data);

	alias al_audio_sample_loader = ALLEGRO_SAMPLE* function(const(char)* filename);
	alias al_audio_sample_saver = bool function(const(char)* filename, ALLEGRO_SAMPLE* spl);
	alias al_audio_stream_loader = ALLEGRO_AUDIO_STREAM* function(const(char)* filename,size_t buffer_count, uint samples);

	alias al_audio_sample_loader_f = ALLEGRO_SAMPLE* function(ALLEGRO_FILE* fp);
	alias al_audio_sample_saver_f = bool function(ALLEGRO_FILE* fp, ALLEGRO_SAMPLE* spl);
	alias al_audio_stream_loader_f = ALLEGRO_AUDIO_STREAM* function(ALLEGRO_FILE* fp, size_t buffer_count, uint samples);

	alias al_sample_identifier = bool function(ALLEGRO_FILE* fp);
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
	bool al_set_mixer_postprocess_callback(ALLEGRO_MIXER* mixer, al_audio_mixer_callback cb, void* data);

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

	bool al_register_sample_loader(const(char)* ext, al_audio_sample_loader loader);
	bool al_register_sample_saver(const(char)* ext, al_audio_sample_saver saver);
	bool al_register_audio_stream_loader(const(char)* ext, al_audio_stream_loader stream_loader);

	bool al_register_sample_loader_f(const(char)* ext, al_audio_sample_loader_f loader);
	bool al_register_sample_saver_f(const(char)* ext, al_audio_sample_saver_f saver);
	bool al_register_audio_stream_loader_f(const(char)* ext, al_audio_stream_loader_f stream_loader);

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
		bool al_register_sample_identifier(const(char)* ext, al_sample_identifier identifier);

		version(ALLEGRO_UNSTABLE) {
			ALLEGRO_AUDIO_STREAM* al_play_audio_stream(const(char)* filename);
			ALLEGRO_AUDIO_STREAM* al_play_audio_stream_f(ALLEGRO_FILE* fp, const(char)* ident);
		}
	}

	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		bool al_mixer_has_attachments(const ALLEGRO_MIXER *mixer);
		bool al_voice_has_attachments(const ALLEGRO_VOICE* voice);
	}
}
else {

	pragma(inline, true) extern(C) @nogc nothrow {
		ALLEGRO_SAMPLE* al_create_sample(void* buf,uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf, bool free_buf) =>
				ptr_al_create_sample(buf,samples, freq, depth, chan_conf, free_buf);
		void al_destroy_sample(ALLEGRO_SAMPLE* spl) => ptr_al_destroy_sample(spl);

		ALLEGRO_SAMPLE_INSTANCE* al_create_sample_instance(ALLEGRO_SAMPLE* data) => ptr_al_create_sample_instance(data);
		void al_destroy_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl) => ptr_al_destroy_sample_instance(spl);
		uint al_get_sample_frequency(const(ALLEGRO_SAMPLE)* spl) => ptr_al_get_sample_frequency(spl);
		uint al_get_sample_length(const(ALLEGRO_SAMPLE)* spl) => ptr_al_get_sample_length(spl);
		ALLEGRO_AUDIO_DEPTH al_get_sample_depth(const(ALLEGRO_SAMPLE)* spl) => ptr_al_get_sample_depth(spl);
		ALLEGRO_CHANNEL_CONF al_get_sample_channels(const(ALLEGRO_SAMPLE)* spl) => ptr_al_get_sample_channels(spl);
		void* al_get_sample_data(const(ALLEGRO_SAMPLE)* spl) => ptr_al_get_sample_data(spl);

		uint al_get_sample_instance_frequency(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_frequency(spl);
		uint al_get_sample_instance_length(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_length(spl);
		uint al_get_sample_instance_position(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_position(spl);

		float al_get_sample_instance_speed(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_speed(spl);
		float al_get_sample_instance_gain(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_gain(spl);
		float al_get_sample_instance_pan(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_pan(spl);
		float al_get_sample_instance_time(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_time(spl);

		ALLEGRO_AUDIO_DEPTH al_get_sample_instance_depth(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_depth(spl);
		ALLEGRO_CHANNEL_CONF al_get_sample_instance_channels(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_channels(spl);
		ALLEGRO_PLAYMODE al_get_sample_instance_playmode(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_playmode(spl);

		bool al_get_sample_instance_playing(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_playing(spl);
		bool al_get_sample_instance_attached(const(ALLEGRO_SAMPLE_INSTANCE)* spl) => ptr_al_get_sample_instance_attached(spl);

		bool al_set_sample_instance_position(ALLEGRO_SAMPLE_INSTANCE* spl, uint val) => ptr_al_set_sample_instance_position(spl, val);
		bool al_set_sample_instance_length(ALLEGRO_SAMPLE_INSTANCE* spl, uint val) => ptr_al_set_sample_instance_length(spl, val);

		bool al_set_sample_instance_speed(ALLEGRO_SAMPLE_INSTANCE* spl, float val) => ptr_al_set_sample_instance_speed(spl, val);
		bool al_set_sample_instance_gain(ALLEGRO_SAMPLE_INSTANCE* spl, float val) => ptr_al_set_sample_instance_gain(spl, val);
		bool al_set_sample_instance_pan(ALLEGRO_SAMPLE_INSTANCE* spl, float val) => ptr_al_set_sample_instance_pan(spl, val);

		bool al_set_sample_instance_playmode(ALLEGRO_SAMPLE_INSTANCE* spl, ALLEGRO_PLAYMODE val) => ptr_al_set_sample_instance_playmode(spl, val);

		bool al_set_sample_instance_playing(ALLEGRO_SAMPLE_INSTANCE* spl, bool val) => ptr_al_set_sample_instance_playing(spl, val);
		bool al_detach_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl) => ptr_al_detach_sample_instance(spl);

		bool al_set_sample(ALLEGRO_SAMPLE_INSTANCE* spl, ALLEGRO_SAMPLE* data) => ptr_al_set_sample(spl, data);
		ALLEGRO_SAMPLE* al_get_sample(ALLEGRO_SAMPLE_INSTANCE* spl) => ptr_al_get_sample(spl);
		bool al_play_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl) => ptr_al_play_sample_instance(spl);
		bool al_stop_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl) => ptr_al_stop_sample_instance(spl);

		ALLEGRO_AUDIO_STREAM* al_create_audio_stream(size_t buffer_count, uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf) =>
				ptr_al_create_audio_stream(buffer_count, samples, freq, depth, chan_conf);
		void al_destroy_audio_stream(ALLEGRO_AUDIO_STREAM* stream) => ptr_al_destroy_audio_stream(stream);
		void al_drain_audio_stream(ALLEGRO_AUDIO_STREAM* stream) => ptr_al_drain_audio_stream(stream);

		uint al_get_audio_stream_frequency(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_audio_stream_frequency(stream);
		uint al_get_audio_stream_length(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_audio_stream_length(stream);
		uint al_get_audio_stream_fragments(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_audio_stream_fragments(stream);
		uint al_get_available_audio_stream_fragments(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_available_audio_stream_fragments(stream);

		float al_get_audio_stream_speed(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_audio_stream_speed(stream);
		float al_get_audio_stream_gain(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_audio_stream_gain(stream);
		float al_get_audio_stream_pan(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_audio_stream_pan(stream);

		ALLEGRO_CHANNEL_CONF al_get_audio_stream_channels(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_audio_stream_channels(stream);
		ALLEGRO_AUDIO_DEPTH al_get_audio_stream_depth(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_audio_stream_depth(stream);
		ALLEGRO_PLAYMODE al_get_audio_stream_playmode(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_audio_stream_playmode(stream);

		bool al_get_audio_stream_playing(const(ALLEGRO_AUDIO_STREAM)* spl) => ptr_al_get_audio_stream_playing(spl);
		bool al_get_audio_stream_attached(const(ALLEGRO_AUDIO_STREAM)* spl) => ptr_al_get_audio_stream_attached(spl);
		ulong al_get_audio_stream_played_samples(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_audio_stream_played_samples(stream);

		void* al_get_audio_stream_fragment(const(ALLEGRO_AUDIO_STREAM)* stream) => ptr_al_get_audio_stream_fragment(stream);

		bool al_set_audio_stream_speed(ALLEGRO_AUDIO_STREAM* stream, float val) => ptr_al_set_audio_stream_speed(stream, val);
		bool al_set_audio_stream_gain(ALLEGRO_AUDIO_STREAM* stream, float val) => ptr_al_set_audio_stream_gain(stream, val);
		bool al_set_audio_stream_pan(ALLEGRO_AUDIO_STREAM* stream, float val) => ptr_al_set_audio_stream_pan(stream, val);

		bool al_set_audio_stream_playmode(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_PLAYMODE val) => ptr_al_set_audio_stream_playmode(stream, val);

		bool al_set_audio_stream_playing(ALLEGRO_AUDIO_STREAM* stream, bool val) => ptr_al_set_audio_stream_playing(stream, val);
		bool al_detach_audio_stream(ALLEGRO_AUDIO_STREAM* stream) => ptr_al_detach_audio_stream(stream);
		bool al_set_audio_stream_fragment(ALLEGRO_AUDIO_STREAM* stream, void* val) => ptr_al_set_audio_stream_fragment(stream, val);

		bool al_rewind_audio_stream(ALLEGRO_AUDIO_STREAM* stream) => ptr_al_rewind_audio_stream(stream);
		bool al_seek_audio_stream_secs(ALLEGRO_AUDIO_STREAM* stream, double time) => ptr_al_seek_audio_stream_secs(stream, time);
		double al_get_audio_stream_position_secs(ALLEGRO_AUDIO_STREAM* stream) => ptr_al_get_audio_stream_position_secs(stream);
		double al_get_audio_stream_length_secs(ALLEGRO_AUDIO_STREAM* stream) => ptr_al_get_audio_stream_length_secs(stream);
		bool al_set_audio_stream_loop_secs(ALLEGRO_AUDIO_STREAM* stream, double start, double end) => ptr_al_set_audio_stream_loop_secs(stream, start, end);

		ALLEGRO_EVENT_SOURCE* al_get_audio_stream_event_source(ALLEGRO_AUDIO_STREAM* stream) => ptr_al_get_audio_stream_event_source(stream);

		ALLEGRO_MIXER* al_create_mixer(uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf) => ptr_al_create_mixer(freq, depth, chan_conf);
		void al_destroy_mixer(ALLEGRO_MIXER* mixer) => ptr_al_destroy_mixer(mixer);
		bool al_attach_sample_instance_to_mixer( ALLEGRO_SAMPLE_INSTANCE* stream, ALLEGRO_MIXER* mixer) => ptr_al_attach_sample_instance_to_mixer(stream, mixer);
		bool al_attach_audio_stream_to_mixer(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_MIXER* mixer) => ptr_al_attach_audio_stream_to_mixer(stream, mixer);
		bool al_attach_mixer_to_mixer(ALLEGRO_MIXER* stream, ALLEGRO_MIXER* mixer) => ptr_al_attach_mixer_to_mixer(stream, mixer);
		bool al_set_mixer_postprocess_callback(ALLEGRO_MIXER* mixer, al_audio_mixer_callback cb, void* data) => ptr_al_set_mixer_postprocess_callback(mixer, cb, data);

		uint al_get_mixer_frequency(const(ALLEGRO_MIXER)* mixer) => ptr_al_get_mixer_frequency(mixer);
		ALLEGRO_CHANNEL_CONF al_get_mixer_channels(const(ALLEGRO_MIXER)* mixer) => ptr_al_get_mixer_channels(mixer);
		ALLEGRO_AUDIO_DEPTH al_get_mixer_depth(const(ALLEGRO_MIXER)* mixer) => ptr_al_get_mixer_depth(mixer);
		ALLEGRO_MIXER_QUALITY al_get_mixer_quality(const(ALLEGRO_MIXER)* mixer) => ptr_al_get_mixer_quality(mixer);
		float al_get_mixer_gain(const(ALLEGRO_MIXER)* mixer) => ptr_al_get_mixer_gain(mixer);
		bool al_get_mixer_playing(const(ALLEGRO_MIXER)* mixer) => ptr_al_get_mixer_playing(mixer);
		bool al_get_mixer_attached(const(ALLEGRO_MIXER)* mixer) => ptr_al_get_mixer_attached(mixer);
		bool al_set_mixer_frequency(ALLEGRO_MIXER* mixer, uint val) => ptr_al_set_mixer_frequency(mixer, val);
		bool al_set_mixer_quality(ALLEGRO_MIXER* mixer, ALLEGRO_MIXER_QUALITY val) => ptr_al_set_mixer_quality(mixer, val);
		bool al_set_mixer_gain(ALLEGRO_MIXER* mixer, float gain) => ptr_al_set_mixer_gain(mixer, gain);
		bool al_set_mixer_playing(ALLEGRO_MIXER* mixer, bool val) => ptr_al_set_mixer_playing(mixer, val);
		bool al_detach_mixer(ALLEGRO_MIXER* mixer) => ptr_al_detach_mixer(mixer);

		ALLEGRO_VOICE* al_create_voice(uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf) => ptr_al_create_voice(freq, depth, chan_conf);
		void al_destroy_voice(ALLEGRO_VOICE* voice) => ptr_al_destroy_voice(voice);
		bool al_attach_sample_instance_to_voice(ALLEGRO_SAMPLE_INSTANCE* stream, ALLEGRO_VOICE* voice) => ptr_al_attach_sample_instance_to_voice(stream, voice);
		bool al_attach_audio_stream_to_voice(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_VOICE* voice ) => ptr_al_attach_audio_stream_to_voice(stream, voice );
		bool al_attach_mixer_to_voice(ALLEGRO_MIXER* mixer, ALLEGRO_VOICE* voice) => ptr_al_attach_mixer_to_voice(mixer, voice);
		void al_detach_voice(ALLEGRO_VOICE* voice) => ptr_al_detach_voice(voice);

		uint al_get_voice_frequency(const(ALLEGRO_VOICE)* voice) => ptr_al_get_voice_frequency(voice);
		uint al_get_voice_position(const(ALLEGRO_VOICE)* voice) => ptr_al_get_voice_position(voice);
		ALLEGRO_CHANNEL_CONF al_get_voice_channels(const(ALLEGRO_VOICE)* voice) => ptr_al_get_voice_channels(voice);
		ALLEGRO_AUDIO_DEPTH al_get_voice_depth(const(ALLEGRO_VOICE)* voice) => ptr_al_get_voice_depth(voice);
		bool al_get_voice_playing(const(ALLEGRO_VOICE)* voice) => ptr_al_get_voice_playing(voice);
		bool al_set_voice_position(ALLEGRO_VOICE* voice, uint val) => ptr_al_set_voice_position(voice, val);
		bool al_set_voice_playing(ALLEGRO_VOICE* voice, bool val) => ptr_al_set_voice_playing(voice, val);

		bool al_install_audio() => ptr_al_install_audio();
		void al_uninstall_audio() => ptr_al_uninstall_audio();
		bool al_is_audio_installed() => ptr_al_is_audio_installed();
		uint al_get_allegro_audio_version() => ptr_al_get_allegro_audio_version();

		size_t al_get_channel_count(ALLEGRO_CHANNEL_CONF conf) => ptr_al_get_channel_count(conf);
		size_t al_get_audio_depth_size(ALLEGRO_AUDIO_DEPTH conf) => ptr_al_get_audio_depth_size(conf);

		void al_fill_silence(void* buf, uint samples, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf) => ptr_al_fill_silence(buf, samples, depth, chan_conf);

		bool al_reserve_samples(int reserve_samples) => ptr_al_reserve_samples(reserve_samples);
		ALLEGRO_MIXER* al_get_default_mixer() => ptr_al_get_default_mixer();
		bool al_set_default_mixer(ALLEGRO_MIXER* mixer) => ptr_al_set_default_mixer(mixer);
		bool al_restore_default_mixer() => ptr_al_restore_default_mixer();
		bool al_play_sample(ALLEGRO_SAMPLE* data, float gain, float pan, float speed, ALLEGRO_PLAYMODE loop, ALLEGRO_SAMPLE_ID* ret_id) =>
				ptr_al_play_sample(data, gain, pan, speed, loop, ret_id);
		void al_stop_sample(ALLEGRO_SAMPLE_ID* spl_id) => ptr_al_stop_sample(spl_id);
		void al_stop_samples() => ptr_al_stop_samples();
		ALLEGRO_VOICE* al_get_default_voice() => ptr_al_get_default_voice();
		void al_set_default_voice(ALLEGRO_VOICE* voice) => ptr_al_set_default_voice(voice);

		bool al_register_sample_loader(const(char)* ext, al_audio_sample_loader loader) => ptr_al_register_sample_loader(ext, loader);
		bool al_register_sample_saver(const(char)* ext, al_audio_sample_saver saver) => ptr_al_register_sample_saver(ext, saver);
		bool al_register_audio_stream_loader(const(char)* ext, al_audio_stream_loader stream_loader) => ptr_al_register_audio_stream_loader(ext, stream_loader);

		bool al_register_sample_loader_f(const(char)* ext, al_audio_sample_loader_f loader) => ptr_al_register_sample_loader_f(ext, loader);
		bool al_register_sample_saver_f(const(char)* ext, al_audio_sample_saver_f saver) => ptr_al_register_sample_saver_f(ext, saver);
		bool al_register_audio_stream_loader_f(const(char)* ext, al_audio_stream_loader_f stream_loader) => ptr_al_register_audio_stream_loader_f(ext, stream_loader);

		ALLEGRO_SAMPLE* al_load_sample(const(char)* filename) => ptr_al_load_sample(filename);
		bool al_save_sample(const(char)* filename,ALLEGRO_SAMPLE* spl) => ptr_al_save_sample(filename,spl);
		ALLEGRO_AUDIO_STREAM* al_load_audio_stream(const(char)* filename, size_t buffer_count, uint samples) => ptr_al_load_audio_stream(filename, buffer_count, samples);

		ALLEGRO_SAMPLE* al_load_sample_f(ALLEGRO_FILE* fp, const(char)* ident) => ptr_al_load_sample_f(fp, ident);
		bool al_save_sample_f(ALLEGRO_FILE* fp, const(char)* ident, ALLEGRO_SAMPLE* spl) => ptr_al_save_sample_f(fp, ident,spl);
		ALLEGRO_AUDIO_STREAM* al_load_audio_stream_f(ALLEGRO_FILE* fp, const(char)* ident,size_t buffer_count, uint samples) =>
				ptr_al_load_audio_stream_f(fp, ident, buffer_count, samples);


		version (ALLEGRO_UNSTABLE) {
			ALLEGRO_AUDIO_RECORDER* al_create_audio_recorder(size_t fragment_count, uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf) =>
					ptr_al_create_audio_recorder(fragment_count, samples, freq, depth, chan_conf);
			bool al_start_audio_recorder(ALLEGRO_AUDIO_RECORDER* r) => ptr_al_start_audio_recorder(r);
			void al_stop_audio_recorder(ALLEGRO_AUDIO_RECORDER* r) => ptr_al_stop_audio_recorder(r);
			bool al_is_audio_recorder_recording(ALLEGRO_AUDIO_RECORDER* r) => ptr_al_is_audio_recorder_recording(r);
			ALLEGRO_EVENT_SOURCE* al_get_audio_recorder_event_source(ALLEGRO_AUDIO_RECORDER* r) => ptr_al_get_audio_recorder_event_source(r);
			ALLEGRO_AUDIO_RECORDER_EVENT* al_get_audio_recorder_event(ALLEGRO_EVENT* event) => ptr_al_get_audio_recorder_event(event);
			void al_destroy_audio_recorder(ALLEGRO_AUDIO_RECORDER* r) => ptr_al_destroy_audio_recorder(r);
		}

		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
			bool al_set_sample_instance_channel_matrix(ALLEGRO_SAMPLE_INSTANCE* spl, const(float)* matrix) => ptr_al_set_sample_instance_channel_matrix(spl, matrix);
			bool al_set_audio_stream_channel_matrix(ALLEGRO_AUDIO_STREAM* stream, const(float)* matrix) => ptr_al_set_audio_stream_channel_matrix(stream, matrix);

			ALLEGRO_SAMPLE_INSTANCE* al_lock_sample_id(ALLEGRO_SAMPLE_ID* spl_id) => ptr_al_lock_sample_id(spl_id);
			void al_unlock_sample_id(ALLEGRO_SAMPLE_ID* spl_id) => ptr_al_unlock_sample_id(spl_id);
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			const(char)* al_identify_sample_f(ALLEGRO_FILE* fp) => ptr_al_identify_sample_f(fp);
			const(char)* al_identify_sample(const(char)* filename) => ptr_al_identify_sample(filename);
			int al_get_num_audio_output_devices() => ptr_al_get_num_audio_output_devices();
			const(ALLEGRO_AUDIO_DEVICE)* al_get_audio_output_device(int index) => ptr_al_get_audio_output_device(index);
			const(char)* al_get_audio_device_name(const(ALLEGRO_AUDIO_DEVICE)* device) => ptr_al_get_audio_device_name(device);
			bool al_register_sample_identifier(const(char)* ext, al_sample_identifier identifier) => ptr_al_register_sample_identifier(ext, identifier);

			version(ALLEGRO_UNSTABLE) {
				ALLEGRO_AUDIO_STREAM* al_play_audio_stream(const(char)* filename) => ptr_al_play_audio_stream(filename);
				ALLEGRO_AUDIO_STREAM* al_play_audio_stream_f(ALLEGRO_FILE* fp, const(char)* ident) => ptr_al_play_audio_stream_f(fp, ident);
			}
		}

		static if (allegroSupport >= AllegroSupport.v5_2_9) {
			bool al_mixer_has_attachments(const ALLEGRO_MIXER *mixer) => ptr_al_mixer_has_attachments(mixer);
			bool al_voice_has_attachments(const ALLEGRO_VOICE* voice) => ptr_al_voice_has_attachments(voice);
		}
	}

	private __gshared {
		typeof(&al_create_sample) ptr_al_create_sample;
		typeof(&al_destroy_sample) ptr_al_destroy_sample;

		typeof(&al_create_sample_instance) ptr_al_create_sample_instance;
		typeof(&al_destroy_sample_instance) ptr_al_destroy_sample_instance;

		typeof(&al_get_sample_frequency) ptr_al_get_sample_frequency;
		typeof(&al_get_sample_length) ptr_al_get_sample_length;
		typeof(&al_get_sample_depth) ptr_al_get_sample_depth;
		typeof(&al_get_sample_channels) ptr_al_get_sample_channels;
		typeof(&al_get_sample_data) ptr_al_get_sample_data;

		typeof(&al_get_sample_instance_frequency) ptr_al_get_sample_instance_frequency;
		typeof(&al_get_sample_instance_length) ptr_al_get_sample_instance_length;
		typeof(&al_get_sample_instance_position) ptr_al_get_sample_instance_position;

		typeof(&al_get_sample_instance_speed) ptr_al_get_sample_instance_speed;
		typeof(&al_get_sample_instance_gain) ptr_al_get_sample_instance_gain;
		typeof(&al_get_sample_instance_pan) ptr_al_get_sample_instance_pan;
		typeof(&al_get_sample_instance_time) ptr_al_get_sample_instance_time;

		typeof(&al_get_sample_instance_depth) ptr_al_get_sample_instance_depth;
		typeof(&al_get_sample_instance_channels) ptr_al_get_sample_instance_channels;
		typeof(&al_get_sample_instance_playmode) ptr_al_get_sample_instance_playmode;

		typeof(&al_get_sample_instance_playing) ptr_al_get_sample_instance_playing;
		typeof(&al_get_sample_instance_attached) ptr_al_get_sample_instance_attached;

		typeof(&al_set_sample_instance_position) ptr_al_set_sample_instance_position;
		typeof(&al_set_sample_instance_length) ptr_al_set_sample_instance_length;

		typeof(&al_set_sample_instance_speed) ptr_al_set_sample_instance_speed;
		typeof(&al_set_sample_instance_gain) ptr_al_set_sample_instance_gain;
		typeof(&al_set_sample_instance_pan) ptr_al_set_sample_instance_pan;

		typeof(&al_set_sample_instance_playmode) ptr_al_set_sample_instance_playmode;

		typeof(&al_set_sample_instance_playing) ptr_al_set_sample_instance_playing;
		typeof(&al_detach_sample_instance) ptr_al_detach_sample_instance;

		typeof(&al_set_sample) ptr_al_set_sample;
		typeof(&al_get_sample) ptr_al_get_sample;
		typeof(&al_play_sample_instance) ptr_al_play_sample_instance;
		typeof(&al_stop_sample_instance) ptr_al_stop_sample_instance;

		typeof(&al_create_audio_stream) ptr_al_create_audio_stream;
		typeof(&al_destroy_audio_stream) ptr_al_destroy_audio_stream;
		typeof(&al_drain_audio_stream) ptr_al_drain_audio_stream;

		typeof(&al_get_audio_stream_frequency) ptr_al_get_audio_stream_frequency;
		typeof(&al_get_audio_stream_length) ptr_al_get_audio_stream_length;
		typeof(&al_get_audio_stream_fragments) ptr_al_get_audio_stream_fragments;
		typeof(&al_get_available_audio_stream_fragments) ptr_al_get_available_audio_stream_fragments;

		typeof(&al_get_audio_stream_speed) ptr_al_get_audio_stream_speed;
		typeof(&al_get_audio_stream_gain) ptr_al_get_audio_stream_gain;
		typeof(&al_get_audio_stream_pan) ptr_al_get_audio_stream_pan;

		typeof(&al_get_audio_stream_channels) ptr_al_get_audio_stream_channels;
		typeof(&al_get_audio_stream_depth) ptr_al_get_audio_stream_depth;
		typeof(&al_get_audio_stream_playmode) ptr_al_get_audio_stream_playmode;

		typeof(&al_get_audio_stream_playing) ptr_al_get_audio_stream_playing;
		typeof(&al_get_audio_stream_attached) ptr_al_get_audio_stream_attached;
		typeof(&al_get_audio_stream_played_samples) ptr_al_get_audio_stream_played_samples;

		typeof(&al_get_audio_stream_fragment) ptr_al_get_audio_stream_fragment;

		typeof(&al_set_audio_stream_speed) ptr_al_set_audio_stream_speed;
		typeof(&al_set_audio_stream_gain) ptr_al_set_audio_stream_gain;
		typeof(&al_set_audio_stream_pan) ptr_al_set_audio_stream_pan;

		typeof(&al_set_audio_stream_playmode) ptr_al_set_audio_stream_playmode;

		typeof(&al_set_audio_stream_playing) ptr_al_set_audio_stream_playing;
		typeof(&al_detach_audio_stream) ptr_al_detach_audio_stream;
		typeof(&al_set_audio_stream_fragment) ptr_al_set_audio_stream_fragment;

		typeof(&al_rewind_audio_stream) ptr_al_rewind_audio_stream;
		typeof(&al_seek_audio_stream_secs) ptr_al_seek_audio_stream_secs;
		typeof(&al_get_audio_stream_position_secs) ptr_al_get_audio_stream_position_secs;
		typeof(&al_get_audio_stream_length_secs) ptr_al_get_audio_stream_length_secs;
		typeof(&al_set_audio_stream_loop_secs) ptr_al_set_audio_stream_loop_secs;

		typeof(&al_get_audio_stream_event_source) ptr_al_get_audio_stream_event_source;

		typeof(&al_create_mixer) ptr_al_create_mixer;
		typeof(&al_destroy_mixer) ptr_al_destroy_mixer;
		typeof(&al_attach_sample_instance_to_mixer) ptr_al_attach_sample_instance_to_mixer;
		typeof(&al_attach_audio_stream_to_mixer) ptr_al_attach_audio_stream_to_mixer;
		typeof(&al_attach_mixer_to_mixer) ptr_al_attach_mixer_to_mixer;
		typeof(&al_set_mixer_postprocess_callback) ptr_al_set_mixer_postprocess_callback;

		typeof(&al_get_mixer_frequency) ptr_al_get_mixer_frequency;
		typeof(&al_get_mixer_channels) ptr_al_get_mixer_channels;
		typeof(&al_get_mixer_depth) ptr_al_get_mixer_depth;
		typeof(&al_get_mixer_quality) ptr_al_get_mixer_quality;
		typeof(&al_get_mixer_gain) ptr_al_get_mixer_gain;
		typeof(&al_get_mixer_playing) ptr_al_get_mixer_playing;
		typeof(&al_get_mixer_attached) ptr_al_get_mixer_attached;
		typeof(&al_set_mixer_frequency) ptr_al_set_mixer_frequency;
		typeof(&al_set_mixer_quality) ptr_al_set_mixer_quality;
		typeof(&al_set_mixer_gain) ptr_al_set_mixer_gain;
		typeof(&al_set_mixer_playing) ptr_al_set_mixer_playing;
		typeof(&al_detach_mixer) ptr_al_detach_mixer;

		typeof(&al_create_voice) ptr_al_create_voice;
		typeof(&al_destroy_voice) ptr_al_destroy_voice;
		typeof(&al_attach_sample_instance_to_voice) ptr_al_attach_sample_instance_to_voice;
		typeof(&al_attach_audio_stream_to_voice) ptr_al_attach_audio_stream_to_voice;
		typeof(&al_attach_mixer_to_voice) ptr_al_attach_mixer_to_voice;
		typeof(&al_detach_voice) ptr_al_detach_voice;

		typeof(&al_get_voice_frequency) ptr_al_get_voice_frequency;
		typeof(&al_get_voice_position) ptr_al_get_voice_position;
		typeof(&al_get_voice_channels) ptr_al_get_voice_channels;
		typeof(&al_get_voice_depth) ptr_al_get_voice_depth;
		typeof(&al_get_voice_playing) ptr_al_get_voice_playing;
		typeof(&al_set_voice_position) ptr_al_set_voice_position;
		typeof(&al_set_voice_playing) ptr_al_set_voice_playing;

		typeof(&al_install_audio) ptr_al_install_audio;
		typeof(&al_uninstall_audio) ptr_al_uninstall_audio;
		typeof(&al_is_audio_installed) ptr_al_is_audio_installed;
		typeof(&al_get_allegro_audio_version) ptr_al_get_allegro_audio_version;

		typeof(&al_get_channel_count) ptr_al_get_channel_count;
		typeof(&al_get_audio_depth_size) ptr_al_get_audio_depth_size;

		typeof(&al_fill_silence) ptr_al_fill_silence;

		typeof(&al_reserve_samples) ptr_al_reserve_samples;
		typeof(&al_get_default_mixer) ptr_al_get_default_mixer;
		typeof(&al_set_default_mixer) ptr_al_set_default_mixer;
		typeof(&al_restore_default_mixer) ptr_al_restore_default_mixer;
		typeof(&al_play_sample) ptr_al_play_sample;
		typeof(&al_stop_sample) ptr_al_stop_sample;
		typeof(&al_stop_samples) ptr_al_stop_samples;
		typeof(&al_get_default_voice) ptr_al_get_default_voice;
		typeof(&al_set_default_voice) ptr_al_set_default_voice;

		typeof(&al_register_sample_loader) ptr_al_register_sample_loader;
		typeof(&al_register_sample_saver) ptr_al_register_sample_saver;
		typeof(&al_register_audio_stream_loader) ptr_al_register_audio_stream_loader;

		typeof(&al_register_sample_loader_f) ptr_al_register_sample_loader_f;
		typeof(&al_register_sample_saver_f) ptr_al_register_sample_saver_f;
		typeof(&al_register_audio_stream_loader_f) ptr_al_register_audio_stream_loader_f;

		typeof(&al_load_sample) ptr_al_load_sample;
		typeof(&al_save_sample) ptr_al_save_sample;
		typeof(&al_load_audio_stream) ptr_al_load_audio_stream;

		typeof(&al_load_sample_f) ptr_al_load_sample_f;
		typeof(&al_save_sample_f) ptr_al_save_sample_f;
		typeof(&al_load_audio_stream_f) ptr_al_load_audio_stream_f;


		version (ALLEGRO_UNSTABLE) {
			/* “The API may need a slight redesign” */
			typeof(&al_create_audio_recorder) ptr_al_create_audio_recorder;
			typeof(&al_start_audio_recorder) ptr_al_start_audio_recorder;
			typeof(&al_stop_audio_recorder) ptr_al_stop_audio_recorder;
			typeof(&al_is_audio_recorder_recording) ptr_al_is_audio_recorder_recording;
			typeof(&al_get_audio_recorder_event_source) ptr_al_get_audio_recorder_event_source;
			typeof(&al_get_audio_recorder_event) ptr_al_get_audio_recorder_event;
			typeof(&al_destroy_audio_recorder) ptr_al_destroy_audio_recorder;
		}

		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
			typeof(&al_set_sample_instance_channel_matrix) ptr_al_set_sample_instance_channel_matrix;
			typeof(&al_set_audio_stream_channel_matrix) ptr_al_set_audio_stream_channel_matrix;

			typeof(&al_lock_sample_id) ptr_al_lock_sample_id;
			typeof(&al_unlock_sample_id) ptr_al_unlock_sample_id;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			typeof(&al_identify_sample_f) ptr_al_identify_sample_f;
			typeof(&al_identify_sample) ptr_al_identify_sample;
			typeof(&al_get_num_audio_output_devices) ptr_al_get_num_audio_output_devices;
			typeof(&al_get_audio_output_device) ptr_al_get_audio_output_device;
			typeof(&al_get_audio_device_name) ptr_al_get_audio_device_name;
			typeof(&al_register_sample_identifier) ptr_al_register_sample_identifier;

			version(ALLEGRO_UNSTABLE) {
				typeof(&al_play_audio_stream) ptr_al_play_audio_stream;
				typeof(&al_play_audio_stream_f) ptr_al_play_audio_stream_f;
			}
		}

		static if (allegroSupport >= AllegroSupport.v5_2_9) {
			typeof(&al_mixer_has_attachments) ptr_al_mixer_has_attachments;
			typeof(&al_voice_has_attachments) ptr_al_voice_has_attachments;
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
				dynlibFilename!"audio",
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
			loadedVersion = bindAllegroAudio(lib);
			return loadedVersion == allegroSupport ? allegroSupport : AllegroSupport.badLibrary;
		}
	}

	package AllegroSupport bindAllegroAudio(SharedLib lib) {

		auto lastErrorCount = errorCount();

		lib.bindSymbol(cast(void**)&ptr_al_create_sample, "al_create_sample");
		lib.bindSymbol(cast(void**)&ptr_al_destroy_sample, "al_destroy_sample");

		lib.bindSymbol(cast(void**)&ptr_al_create_sample_instance, "al_create_sample_instance");
		lib.bindSymbol(cast(void**)&ptr_al_destroy_sample_instance, "al_destroy_sample_instance");

		lib.bindSymbol(cast(void**)&ptr_al_get_sample_frequency, "al_get_sample_frequency");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_length, "al_get_sample_length");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_depth, "al_get_sample_depth");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_channels, "al_get_sample_channels");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_data, "al_get_sample_data");

		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_frequency, "al_get_sample_instance_frequency");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_length, "al_get_sample_instance_length");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_position, "al_get_sample_instance_position");

		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_speed, "al_get_sample_instance_speed");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_gain, "al_get_sample_instance_gain");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_pan, "al_get_sample_instance_pan");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_time, "al_get_sample_instance_time");

		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_depth, "al_get_sample_instance_depth");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_channels, "al_get_sample_instance_channels");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_playmode, "al_get_sample_instance_playmode");

		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_playing, "al_get_sample_instance_playing");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample_instance_attached, "al_get_sample_instance_attached");

		lib.bindSymbol(cast(void**)&ptr_al_set_sample_instance_position, "al_set_sample_instance_position");
		lib.bindSymbol(cast(void**)&ptr_al_set_sample_instance_length, "al_set_sample_instance_length");

		lib.bindSymbol(cast(void**)&ptr_al_set_sample_instance_speed, "al_set_sample_instance_speed");
		lib.bindSymbol(cast(void**)&ptr_al_set_sample_instance_gain, "al_set_sample_instance_gain");
		lib.bindSymbol(cast(void**)&ptr_al_set_sample_instance_pan, "al_set_sample_instance_pan");

		lib.bindSymbol(cast(void**)&ptr_al_set_sample_instance_playmode, "al_set_sample_instance_playmode");

		lib.bindSymbol(cast(void**)&ptr_al_set_sample_instance_playing, "al_set_sample_instance_playing");
		lib.bindSymbol(cast(void**)&ptr_al_detach_sample_instance, "al_detach_sample_instance");

		lib.bindSymbol(cast(void**)&ptr_al_set_sample, "al_set_sample");
		lib.bindSymbol(cast(void**)&ptr_al_get_sample, "al_get_sample");
		lib.bindSymbol(cast(void**)&ptr_al_play_sample_instance, "al_play_sample_instance");
		lib.bindSymbol(cast(void**)&ptr_al_stop_sample_instance, "al_stop_sample_instance");

		lib.bindSymbol(cast(void**)&ptr_al_create_audio_stream, "al_create_audio_stream");
		lib.bindSymbol(cast(void**)&ptr_al_destroy_audio_stream, "al_destroy_audio_stream");
		lib.bindSymbol(cast(void**)&ptr_al_drain_audio_stream, "al_drain_audio_stream");

		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_frequency, "al_get_audio_stream_frequency");
		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_length, "al_get_audio_stream_length");
		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_fragments, "al_get_audio_stream_fragments");
		lib.bindSymbol(cast(void**)&ptr_al_get_available_audio_stream_fragments, "al_get_available_audio_stream_fragments");

		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_speed, "al_get_audio_stream_speed");
		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_gain, "al_get_audio_stream_gain");
		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_pan, "al_get_audio_stream_pan");

		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_channels, "al_get_audio_stream_channels");
		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_depth, "al_get_audio_stream_depth");
		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_playmode, "al_get_audio_stream_playmode");

		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_playing, "al_get_audio_stream_playing");
		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_attached, "al_get_audio_stream_attached");
		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_played_samples, "al_get_audio_stream_played_samples");

		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_fragment, "al_get_audio_stream_fragment");

		lib.bindSymbol(cast(void**)&ptr_al_set_audio_stream_speed, "al_set_audio_stream_speed");
		lib.bindSymbol(cast(void**)&ptr_al_set_audio_stream_gain, "al_set_audio_stream_gain");
		lib.bindSymbol(cast(void**)&ptr_al_set_audio_stream_pan, "al_set_audio_stream_pan");

		lib.bindSymbol(cast(void**)&ptr_al_set_audio_stream_playmode, "al_set_audio_stream_playmode");

		lib.bindSymbol(cast(void**)&ptr_al_set_audio_stream_playing, "al_set_audio_stream_playing");
		lib.bindSymbol(cast(void**)&ptr_al_detach_audio_stream, "al_detach_audio_stream");
		lib.bindSymbol(cast(void**)&ptr_al_set_audio_stream_fragment, "al_set_audio_stream_fragment");

		lib.bindSymbol(cast(void**)&ptr_al_rewind_audio_stream, "al_rewind_audio_stream");
		lib.bindSymbol(cast(void**)&ptr_al_seek_audio_stream_secs, "al_seek_audio_stream_secs");
		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_position_secs, "al_get_audio_stream_position_secs");
		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_length_secs, "al_get_audio_stream_length_secs");
		lib.bindSymbol(cast(void**)&ptr_al_set_audio_stream_loop_secs, "al_set_audio_stream_loop_secs");

		lib.bindSymbol(cast(void**)&ptr_al_get_audio_stream_event_source, "al_get_audio_stream_event_source");

		lib.bindSymbol(cast(void**)&ptr_al_create_mixer, "al_create_mixer");
		lib.bindSymbol(cast(void**)&ptr_al_destroy_mixer, "al_destroy_mixer");
		lib.bindSymbol(cast(void**)&ptr_al_attach_sample_instance_to_mixer, "al_attach_sample_instance_to_mixer");
		lib.bindSymbol(cast(void**)&ptr_al_attach_audio_stream_to_mixer, "al_attach_audio_stream_to_mixer");
		lib.bindSymbol(cast(void**)&ptr_al_attach_mixer_to_mixer, "al_attach_mixer_to_mixer");
		lib.bindSymbol(cast(void**)&ptr_al_set_mixer_postprocess_callback, "al_set_mixer_postprocess_callback");

		lib.bindSymbol(cast(void**)&ptr_al_get_mixer_frequency, "al_get_mixer_frequency");
		lib.bindSymbol(cast(void**)&ptr_al_get_mixer_channels, "al_get_mixer_channels");
		lib.bindSymbol(cast(void**)&ptr_al_get_mixer_depth, "al_get_mixer_depth");
		lib.bindSymbol(cast(void**)&ptr_al_get_mixer_quality, "al_get_mixer_quality");
		lib.bindSymbol(cast(void**)&ptr_al_get_mixer_gain, "al_get_mixer_gain");
		lib.bindSymbol(cast(void**)&ptr_al_get_mixer_playing, "al_get_mixer_playing");
		lib.bindSymbol(cast(void**)&ptr_al_get_mixer_attached, "al_get_mixer_attached");
		lib.bindSymbol(cast(void**)&ptr_al_set_mixer_frequency, "al_set_mixer_frequency");
		lib.bindSymbol(cast(void**)&ptr_al_set_mixer_quality, "al_set_mixer_quality");
		lib.bindSymbol(cast(void**)&ptr_al_set_mixer_gain, "al_set_mixer_gain");
		lib.bindSymbol(cast(void**)&ptr_al_set_mixer_playing, "al_set_mixer_playing");
		lib.bindSymbol(cast(void**)&ptr_al_detach_mixer, "al_detach_mixer");

		lib.bindSymbol(cast(void**)&ptr_al_create_voice, "al_create_voice");
		lib.bindSymbol(cast(void**)&ptr_al_destroy_voice, "al_destroy_voice");
		lib.bindSymbol(cast(void**)&ptr_al_attach_sample_instance_to_voice, "al_attach_sample_instance_to_voice");
		lib.bindSymbol(cast(void**)&ptr_al_attach_audio_stream_to_voice, "al_attach_audio_stream_to_voice");
		lib.bindSymbol(cast(void**)&ptr_al_attach_mixer_to_voice, "al_attach_mixer_to_voice");
		lib.bindSymbol(cast(void**)&ptr_al_detach_voice, "al_detach_voice");

		lib.bindSymbol(cast(void**)&ptr_al_get_voice_frequency, "al_get_voice_frequency");
		lib.bindSymbol(cast(void**)&ptr_al_get_voice_position, "al_get_voice_position");
		lib.bindSymbol(cast(void**)&ptr_al_get_voice_channels, "al_get_voice_channels");
		lib.bindSymbol(cast(void**)&ptr_al_get_voice_depth, "al_get_voice_depth");
		lib.bindSymbol(cast(void**)&ptr_al_get_voice_playing, "al_get_voice_playing");
		lib.bindSymbol(cast(void**)&ptr_al_set_voice_position, "al_set_voice_position");
		lib.bindSymbol(cast(void**)&ptr_al_set_voice_playing, "al_set_voice_playing");

		lib.bindSymbol(cast(void**)&ptr_al_install_audio, "al_install_audio");
		lib.bindSymbol(cast(void**)&ptr_al_uninstall_audio, "al_uninstall_audio");
		lib.bindSymbol(cast(void**)&ptr_al_is_audio_installed, "al_is_audio_installed");
		lib.bindSymbol(cast(void**)&ptr_al_get_allegro_audio_version, "al_get_allegro_audio_version");

		lib.bindSymbol(cast(void**)&ptr_al_get_channel_count, "al_get_channel_count");
		lib.bindSymbol(cast(void**)&ptr_al_get_audio_depth_size, "al_get_audio_depth_size");

		lib.bindSymbol(cast(void**)&ptr_al_fill_silence, "al_fill_silence");

		lib.bindSymbol(cast(void**)&ptr_al_reserve_samples, "al_reserve_samples");
		lib.bindSymbol(cast(void**)&ptr_al_get_default_mixer, "al_get_default_mixer");
		lib.bindSymbol(cast(void**)&ptr_al_set_default_mixer, "al_set_default_mixer");
		lib.bindSymbol(cast(void**)&ptr_al_restore_default_mixer, "al_restore_default_mixer");
		lib.bindSymbol(cast(void**)&ptr_al_play_sample, "al_play_sample");
		lib.bindSymbol(cast(void**)&ptr_al_stop_sample, "al_stop_sample");
		lib.bindSymbol(cast(void**)&ptr_al_stop_samples, "al_stop_samples");
		lib.bindSymbol(cast(void**)&ptr_al_get_default_voice, "al_get_default_voice");
		lib.bindSymbol(cast(void**)&ptr_al_set_default_voice, "al_set_default_voice");

		lib.bindSymbol(cast(void**)&ptr_al_register_sample_loader, "al_register_sample_loader");
		lib.bindSymbol(cast(void**)&ptr_al_register_sample_saver, "al_register_sample_saver");
		lib.bindSymbol(cast(void**)&ptr_al_register_audio_stream_loader, "al_register_audio_stream_loader");

		lib.bindSymbol(cast(void**)&ptr_al_register_sample_loader_f, "al_register_sample_loader_f");
		lib.bindSymbol(cast(void**)&ptr_al_register_sample_saver_f, "al_register_sample_saver_f");
		lib.bindSymbol(cast(void**)&ptr_al_register_audio_stream_loader_f, "al_register_audio_stream_loader_f");

		lib.bindSymbol(cast(void**)&ptr_al_load_sample, "al_load_sample");
		lib.bindSymbol(cast(void**)&ptr_al_save_sample, "al_save_sample");
		lib.bindSymbol(cast(void**)&ptr_al_load_audio_stream, "al_load_audio_stream");

		lib.bindSymbol(cast(void**)&ptr_al_load_sample_f, "al_load_sample_f");
		lib.bindSymbol(cast(void**)&ptr_al_save_sample_f, "al_save_sample_f");
		lib.bindSymbol(cast(void**)&ptr_al_load_audio_stream_f, "al_load_audio_stream_f");


		version (ALLEGRO_UNSTABLE) {
			lib.bindSymbol(cast(void**)&ptr_al_create_audio_recorder, "al_create_audio_recorder");
			lib.bindSymbol(cast(void**)&ptr_al_start_audio_recorder, "al_start_audio_recorder");
			lib.bindSymbol(cast(void**)&ptr_al_stop_audio_recorder, "al_stop_audio_recorder");
			lib.bindSymbol(cast(void**)&ptr_al_is_audio_recorder_recording, "al_is_audio_recorder_recording");
			lib.bindSymbol(cast(void**)&ptr_al_get_audio_recorder_event_source, "al_get_audio_recorder_event_source");
			lib.bindSymbol(cast(void**)&ptr_al_get_audio_recorder_event, "al_get_audio_recorder_event");
			lib.bindSymbol(cast(void**)&ptr_al_destroy_audio_recorder, "al_destroy_audio_recorder");
		}

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}

		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_3) {
			lib.bindSymbol(cast(void**)&ptr_al_set_sample_instance_channel_matrix, "al_set_sample_instance_channel_matrix");
			lib.bindSymbol(cast(void**)&ptr_al_set_audio_stream_channel_matrix, "al_set_audio_stream_channel_matrix");

			lib.bindSymbol(cast(void**)&ptr_al_lock_sample_id, "al_lock_sample_id");
			lib.bindSymbol(cast(void**)&ptr_al_unlock_sample_id, "al_unlock_sample_id");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_2;
			}
		}

		static if (allegroSupport >= AllegroSupport.v5_2_8) {
			lib.bindSymbol(cast(void**)&ptr_al_identify_sample_f, "al_identify_sample_f");
			lib.bindSymbol(cast(void**)&ptr_al_identify_sample, "al_identify_sample");
			lib.bindSymbol(cast(void**)&ptr_al_get_num_audio_output_devices, "al_get_num_audio_output_devices");
			lib.bindSymbol(cast(void**)&ptr_al_get_audio_output_device, "al_get_audio_output_device");
			lib.bindSymbol(cast(void**)&ptr_al_get_audio_device_name, "al_get_audio_device_name");
			lib.bindSymbol(cast(void**)&ptr_al_register_sample_identifier, "al_register_sample_identifier");

			version(ALLEGRO_UNSTABLE) {
				lib.bindSymbol(cast(void**)&ptr_al_play_audio_stream, "al_play_audio_stream");
				lib.bindSymbol(cast(void**)&ptr_al_play_audio_stream_f, "al_play_audio_stream_f");
			}

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_7;
			}
		}

		static if (allegroSupport >= AllegroSupport.v5_2_9) {
			lib.bindSymbol(cast(void**)&ptr_al_mixer_has_attachments, "al_mixer_has_attachments");
			lib.bindSymbol(cast(void**)&ptr_al_voice_has_attachments, "al_voice_has_attachments");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_8;
			}
		}

		return allegroSupport;
	}
}
