module bindbc.allegro5.bind.allegro_opengl;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.opengl.gl_ext : ALLEGRO_OGL_EXT_LIST;
import bindbc.allegro5.bind.display : ALLEGRO_DISPLAY;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import bindbc.allegro5.bind.shader : ALLEGRO_SHADER;

enum ALLEGRO_OPENGL_VARIANT {
	ALLEGRO_DESKTOP_OPENGL = 0,
	ALLEGRO_OPENGL_ES
}
mixin ExpandEnum!ALLEGRO_OPENGL_VARIANT;

alias GLuint = uint;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	uint al_get_opengl_version();
	bool al_have_opengl_extension(const(char)* extension);
	void* al_get_opengl_proc_address(const(char)* name);
	ALLEGRO_OGL_EXT_LIST* al_get_opengl_extension_list();
	GLuint al_get_opengl_texture(ALLEGRO_BITMAP* bitmap);
	void al_remove_opengl_fbo(ALLEGRO_BITMAP* bitmap);
	GLuint al_get_opengl_fbo(ALLEGRO_BITMAP* bitmap);
	bool al_get_opengl_texture_size(ALLEGRO_BITMAP* bitmap, int* w, int* h);
	void al_get_opengl_texture_position(ALLEGRO_BITMAP* bitmap, int* u, int* v);
	GLuint al_get_opengl_program_object(ALLEGRO_SHADER* shader);
	void al_set_current_opengl_context(ALLEGRO_DISPLAY* display);
	int al_get_opengl_variant();
}
else {
	extern(C) @nogc nothrow {
		alias pal_get_opengl_version = uint function();
		alias pal_have_opengl_extension = bool function(const(char)* extension);
		alias pal_get_opengl_proc_address = void* function(const(char)* name);
		alias pal_get_opengl_extension_list = ALLEGRO_OGL_EXT_LIST* function();
		alias pal_get_opengl_texture = GLuint function(ALLEGRO_BITMAP* bitmap);
		alias pal_remove_opengl_fbo = void function(ALLEGRO_BITMAP* bitmap);
		alias pal_get_opengl_fbo = GLuint function(ALLEGRO_BITMAP* bitmap);
		alias pal_get_opengl_texture_size = bool function(ALLEGRO_BITMAP* bitmap, int* w, int* h);
		alias pal_get_opengl_texture_position = void function(ALLEGRO_BITMAP* bitmap, int* u, int* v);
		alias pal_get_opengl_program_object = GLuint function(ALLEGRO_SHADER* shader);
		alias pal_set_current_opengl_context = void function(ALLEGRO_DISPLAY* display);
		alias pal_get_opengl_variant = int function();
	}
	
	__gshared {
		pal_get_opengl_version al_get_opengl_version;
		pal_have_opengl_extension al_have_opengl_extension;
		pal_get_opengl_proc_address al_get_opengl_proc_address;
		pal_get_opengl_extension_list al_get_opengl_extension_list;
		pal_get_opengl_texture al_get_opengl_texture;
		pal_remove_opengl_fbo al_remove_opengl_fbo;
		pal_get_opengl_fbo al_get_opengl_fbo;
		pal_get_opengl_texture_size al_get_opengl_texture_size;
		pal_get_opengl_texture_position al_get_opengl_texture_position;
		pal_get_opengl_program_object al_get_opengl_program_object;
		pal_set_current_opengl_context al_set_current_opengl_context;
		pal_get_opengl_variant al_get_opengl_variant;
	}
}
