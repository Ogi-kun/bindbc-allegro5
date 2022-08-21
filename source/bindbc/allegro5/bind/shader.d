module bindbc.allegro5.bind.shader;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import bindbc.allegro5.bind.transformations : ALLEGRO_TRANSFORM;

struct ALLEGRO_SHADER;

enum ALLEGRO_SHADER_TYPE {
   ALLEGRO_VERTEX_SHADER = 1,
   ALLEGRO_PIXEL_SHADER = 2,
}

enum ALLEGRO_SHADER_PLATFORM {
   ALLEGRO_SHADER_AUTO = 0,
   ALLEGRO_SHADER_GLSL = 1,
   ALLEGRO_SHADER_HLSL = 2,
   ALLEGRO_SHADER_AUTO_MINIMAL = 3,
   ALLEGRO_SHADER_GLSL_MINIMAL = 4,
   ALLEGRO_SHADER_HLSL_MINIMAL = 5,
   ALLEGRO_SHADER_HLSL_SM_3_0 = 6,
}

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
}
else {
	extern(C) @nogc nothrow {
		alias pal_create_shader = ALLEGRO_SHADER* function(ALLEGRO_SHADER_PLATFORM platform);
		alias pal_attach_shader_source = bool function(ALLEGRO_SHADER* shader, ALLEGRO_SHADER_TYPE type, const(char)* source);
		alias pal_attach_shader_source_file = bool function(ALLEGRO_SHADER* shader, ALLEGRO_SHADER_TYPE type, const(char)* filename);
		alias pal_build_shader = bool function(ALLEGRO_SHADER* shader);
		alias pal_get_shader_log = const(char)* function(ALLEGRO_SHADER* shader);
		alias pal_get_shader_platform = ALLEGRO_SHADER_PLATFORM function(ALLEGRO_SHADER* shader);
		alias pal_use_shader = bool function(ALLEGRO_SHADER* shader);
		alias pal_destroy_shader = void function(ALLEGRO_SHADER* shader);

		alias pal_set_shader_sampler = bool function(const(char)* name, ALLEGRO_BITMAP* bitmap, int unit);
		alias pal_set_shader_matrix = bool function(const(char)* name, const(ALLEGRO_TRANSFORM)* matrix);
		alias pal_set_shader_int = bool function(const(char)* name, int i);
		alias pal_set_shader_float = bool function(const(char)* name, float f);
		alias pal_set_shader_int_vector = bool function(const(char)* name, int num_components, const(int)* i, int num_elems);
		alias pal_set_shader_float_vector = bool function(const(char)* name, int num_components, const(float)* f, int num_elems);
		alias pal_set_shader_bool = bool function(const(char)* name, bool b);

		alias pal_get_default_shader_source = const(char)* function(ALLEGRO_SHADER_PLATFORM platform, ALLEGRO_SHADER_TYPE type);
	}
	__gshared {
		pal_create_shader al_create_shader;
		pal_attach_shader_source al_attach_shader_source;
		pal_attach_shader_source_file al_attach_shader_source_file;
		pal_build_shader al_build_shader;
		pal_get_shader_log al_get_shader_log;
		pal_get_shader_platform al_get_shader_platform;
		pal_use_shader al_use_shader;
		pal_destroy_shader al_destroy_shader;

		pal_set_shader_sampler al_set_shader_sampler;
		pal_set_shader_matrix al_set_shader_matrix;
		pal_set_shader_int al_set_shader_int;
		pal_set_shader_float al_set_shader_float;
		pal_set_shader_int_vector al_set_shader_int_vector;
		pal_set_shader_float_vector al_set_shader_float_vector;
		pal_set_shader_bool al_set_shader_bool;

		pal_get_default_shader_source al_get_default_shader_source;
	}
}
