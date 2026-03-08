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
	pragma(inline, true) extern(C) @nogc nothrow:
	uint al_get_opengl_version() => ptr_al_get_opengl_version();
	bool al_have_opengl_extension(const(char)* extension) => ptr_al_have_opengl_extension(extension);
	void* al_get_opengl_proc_address(const(char)* name) => ptr_al_get_opengl_proc_address(name);
	ALLEGRO_OGL_EXT_LIST* al_get_opengl_extension_list() => ptr_al_get_opengl_extension_list();
	GLuint al_get_opengl_texture(ALLEGRO_BITMAP* bitmap) => ptr_al_get_opengl_texture(bitmap);
	void al_remove_opengl_fbo(ALLEGRO_BITMAP* bitmap) => ptr_al_remove_opengl_fbo(bitmap);
	GLuint al_get_opengl_fbo(ALLEGRO_BITMAP* bitmap) => ptr_al_get_opengl_fbo(bitmap);
	bool al_get_opengl_texture_size(ALLEGRO_BITMAP* bitmap, int* w, int* h) => ptr_al_get_opengl_texture_size(bitmap, w, h);
	void al_get_opengl_texture_position(ALLEGRO_BITMAP* bitmap, int* u, int* v) => ptr_al_get_opengl_texture_position(bitmap, u, v);
	GLuint al_get_opengl_program_object(ALLEGRO_SHADER* shader) => ptr_al_get_opengl_program_object(shader);
	void al_set_current_opengl_context(ALLEGRO_DISPLAY* display) => ptr_al_set_current_opengl_context(display);
	int al_get_opengl_variant() => ptr_al_get_opengl_variant();

	package(bindbc.allegro5) __gshared {
		typeof(&al_get_opengl_version) ptr_al_get_opengl_version;
		typeof(&al_have_opengl_extension) ptr_al_have_opengl_extension;
		typeof(&al_get_opengl_proc_address) ptr_al_get_opengl_proc_address;
		typeof(&al_get_opengl_extension_list) ptr_al_get_opengl_extension_list;
		typeof(&al_get_opengl_texture) ptr_al_get_opengl_texture;
		typeof(&al_remove_opengl_fbo) ptr_al_remove_opengl_fbo;
		typeof(&al_get_opengl_fbo) ptr_al_get_opengl_fbo;
		typeof(&al_get_opengl_texture_size) ptr_al_get_opengl_texture_size;
		typeof(&al_get_opengl_texture_position) ptr_al_get_opengl_texture_position;
		typeof(&al_get_opengl_program_object) ptr_al_get_opengl_program_object;
		typeof(&al_set_current_opengl_context) ptr_al_set_current_opengl_context;
		typeof(&al_get_opengl_variant) ptr_al_get_opengl_variant;
	}
}
