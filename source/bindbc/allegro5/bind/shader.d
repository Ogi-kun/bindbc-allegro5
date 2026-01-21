module bindbc.allegro5.bind.shader;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import bindbc.allegro5.bind.transformations : ALLEGRO_TRANSFORM;

struct ALLEGRO_SHADER;

enum ALLEGRO_SHADER_TYPE {
	ALLEGRO_VERTEX_SHADER = 1,
	ALLEGRO_PIXEL_SHADER = 2,
}
mixin ExpandEnum!ALLEGRO_SHADER_TYPE;

enum ALLEGRO_SHADER_PLATFORM {
	ALLEGRO_SHADER_AUTO = 0,
	ALLEGRO_SHADER_GLSL = 1,
	ALLEGRO_SHADER_HLSL = 2,
	ALLEGRO_SHADER_AUTO_MINIMAL = 3,
	ALLEGRO_SHADER_GLSL_MINIMAL = 4,
	ALLEGRO_SHADER_HLSL_MINIMAL = 5,
	ALLEGRO_SHADER_HLSL_SM_3_0 = 6,
}
mixin ExpandEnum!ALLEGRO_SHADER_PLATFORM;

enum ALLEGRO_SHADER_VAR_COLOR             = "al_color";
enum ALLEGRO_SHADER_VAR_POS               = "al_pos";
enum ALLEGRO_SHADER_VAR_PROJVIEW_MATRIX   = "al_projview_matrix";
enum ALLEGRO_SHADER_VAR_TEX               = "al_tex";
enum ALLEGRO_SHADER_VAR_TEXCOORD          = "al_texcoord";
enum ALLEGRO_SHADER_VAR_TEX_MATRIX        = "al_tex_matrix";
enum ALLEGRO_SHADER_VAR_USER_ATTR         = "al_user_attr_";
enum ALLEGRO_SHADER_VAR_USE_TEX           = "al_use_tex";
enum ALLEGRO_SHADER_VAR_USE_TEX_MATRIX    = "al_use_tex_matrix";
enum ALLEGRO_SHADER_VAR_ALPHA_TEST        = "al_alpha_test";
enum ALLEGRO_SHADER_VAR_ALPHA_FUNCTION    = "al_alpha_func";
enum ALLEGRO_SHADER_VAR_ALPHA_TEST_VALUE  = "al_alpha_test_val";

static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_SHADER* al_create_shader(ALLEGRO_SHADER_PLATFORM platform);
	bool al_attach_shader_source(ALLEGRO_SHADER* shader, ALLEGRO_SHADER_TYPE type, const(char)* source);
	bool al_attach_shader_source_file(ALLEGRO_SHADER* shader, ALLEGRO_SHADER_TYPE type, const(char)* filename);
	bool al_build_shader(ALLEGRO_SHADER* shader);
	const(char)* al_get_shader_log(ALLEGRO_SHADER* shader);
	ALLEGRO_SHADER_PLATFORM al_get_shader_platform(ALLEGRO_SHADER* shader);
	bool al_use_shader(ALLEGRO_SHADER* shader);
	void al_destroy_shader(ALLEGRO_SHADER* shader);

	bool al_set_shader_sampler(const(char)* name, ALLEGRO_BITMAP* bitmap, int unit);
	bool al_set_shader_matrix(const(char)* name, const(ALLEGRO_TRANSFORM)* matrix);
	bool al_set_shader_int(const(char)* name, int i);
	bool al_set_shader_float(const(char)* name, float f);
	bool al_set_shader_int_vector(const(char)* name, int num_components, const(int)* i, int num_elems);
	bool al_set_shader_float_vector(const(char)* name, int num_components, const(float)* f, int num_elems);
	bool al_set_shader_bool(const(char)* name, bool b);

	const(char)* al_get_default_shader_source(ALLEGRO_SHADER_PLATFORM platform, ALLEGRO_SHADER_TYPE type);

	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		ALLEGRO_SHADER* al_get_current_shader();
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	ALLEGRO_SHADER* al_create_shader(ALLEGRO_SHADER_PLATFORM platform) => ptr_al_create_shader(platform);
	bool al_attach_shader_source(ALLEGRO_SHADER* shader, ALLEGRO_SHADER_TYPE type, const(char)* source) => ptr_al_attach_shader_source(shader, type, source);
	bool al_attach_shader_source_file(ALLEGRO_SHADER* shader, ALLEGRO_SHADER_TYPE type, const(char)* filename) => ptr_al_attach_shader_source_file(shader, type, filename);
	bool al_build_shader(ALLEGRO_SHADER* shader) => ptr_al_build_shader(shader);
	const(char)* al_get_shader_log(ALLEGRO_SHADER* shader) => ptr_al_get_shader_log(shader);
	ALLEGRO_SHADER_PLATFORM al_get_shader_platform(ALLEGRO_SHADER* shader) => ptr_al_get_shader_platform(shader);
	bool al_use_shader(ALLEGRO_SHADER* shader) => ptr_al_use_shader(shader);
	void al_destroy_shader(ALLEGRO_SHADER* shader) => ptr_al_destroy_shader(shader);

	bool al_set_shader_sampler(const(char)* name, ALLEGRO_BITMAP* bitmap, int unit) => ptr_al_set_shader_sampler(name, bitmap, unit);
	bool al_set_shader_matrix(const(char)* name, const(ALLEGRO_TRANSFORM)* matrix) => ptr_al_set_shader_matrix(name, matrix);
	bool al_set_shader_int(const(char)* name, int i) => ptr_al_set_shader_int(name, i);
	bool al_set_shader_float(const(char)* name, float f) => ptr_al_set_shader_float(name, f);
	bool al_set_shader_int_vector(const(char)* name, int num_components, const(int)* i, int num_elems) => ptr_al_set_shader_int_vector(name, num_components, i, num_elems);
	bool al_set_shader_float_vector(const(char)* name, int num_components, const(float)* f, int num_elems) => ptr_al_set_shader_float_vector(name, num_components, f, num_elems);
	bool al_set_shader_bool(const(char)* name, bool b) => ptr_al_set_shader_bool(name, b);

	const(char)* al_get_default_shader_source(ALLEGRO_SHADER_PLATFORM platform, ALLEGRO_SHADER_TYPE type) => ptr_al_get_default_shader_source(platform, type);

	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		ALLEGRO_SHADER* al_get_current_shader() => ptr_al_get_current_shader();
	}

	package(bindbc.allegro5) __gshared {
		typeof(&al_create_shader) ptr_al_create_shader;
		typeof(&al_attach_shader_source) ptr_al_attach_shader_source;
		typeof(&al_attach_shader_source_file) ptr_al_attach_shader_source_file;
		typeof(&al_build_shader) ptr_al_build_shader;
		typeof(&al_get_shader_log) ptr_al_get_shader_log;
		typeof(&al_get_shader_platform) ptr_al_get_shader_platform;
		typeof(&al_use_shader) ptr_al_use_shader;
		typeof(&al_destroy_shader) ptr_al_destroy_shader;

		typeof(&al_set_shader_sampler) ptr_al_set_shader_sampler;
		typeof(&al_set_shader_matrix) ptr_al_set_shader_matrix;
		typeof(&al_set_shader_int) ptr_al_set_shader_int;
		typeof(&al_set_shader_float) ptr_al_set_shader_float;
		typeof(&al_set_shader_int_vector) ptr_al_set_shader_int_vector;
		typeof(&al_set_shader_float_vector) ptr_al_set_shader_float_vector;
		typeof(&al_set_shader_bool) ptr_al_set_shader_bool;

		typeof(&al_get_default_shader_source) ptr_al_get_default_shader_source;

		static if (allegroSupport >= AllegroSupport.v5_2_9) {
			typeof(&al_get_current_shader) ptr_al_get_current_shader;
		}
	}
}
