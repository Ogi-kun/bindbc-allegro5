module bindbc.allegro5.bind.transformations;

import bindbc.allegro5.config;

struct ALLEGRO_TRANSFORM {
   float[4][4] m;
}


static if (staticBinding) {
	extern(C) @nogc nothrow:
	void al_use_transform(const(ALLEGRO_TRANSFORM)* trans);
	void al_use_projection_transform(const(ALLEGRO_TRANSFORM)* trans);
	void al_copy_transform(ALLEGRO_TRANSFORM* dest, const(ALLEGRO_TRANSFORM)* src);
	void al_identity_transform(ALLEGRO_TRANSFORM* trans);
	void al_build_transform(ALLEGRO_TRANSFORM* trans, float x, float y, float sx, float sy, float theta);
	void al_build_camera_transform(ALLEGRO_TRANSFORM* trans, float position_x, float position_y, float position_z, 
			float look_x, float look_y, float look_z, float up_x, float up_y, float up_z);
	void al_translate_transform(ALLEGRO_TRANSFORM* trans, float x, float y);
	void al_translate_transform_3d(ALLEGRO_TRANSFORM* trans, float x, float y, float z);
	void al_rotate_transform(ALLEGRO_TRANSFORM* trans, float theta);
	void al_rotate_transform_3d(ALLEGRO_TRANSFORM* trans, float x, float y, float z, float angle);
	void al_scale_transform(ALLEGRO_TRANSFORM* trans, float sx, float sy);
	void al_scale_transform_3d(ALLEGRO_TRANSFORM* trans, float sx, float sy, float sz);
	void al_transform_coordinates(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y);
	void al_transform_coordinates_3d(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y, float* z);
	void al_transform_coordinates_4d(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y, float* z, float* w);
	void al_transform_coordinates_3d_projective(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y, float* z);
	void al_compose_transform(ALLEGRO_TRANSFORM* trans, const(ALLEGRO_TRANSFORM)* other);
	const(ALLEGRO_TRANSFORM)* al_get_current_transform();
	const(ALLEGRO_TRANSFORM)* al_get_current_inverse_transform();
	const(ALLEGRO_TRANSFORM)* al_get_current_projection_transform();
	void al_invert_transform(ALLEGRO_TRANSFORM* trans);
	void al_transpose_transform(ALLEGRO_TRANSFORM* trans);
	int al_check_inverse(const(ALLEGRO_TRANSFORM)* trans, float tol);
	void al_orthographic_transform(ALLEGRO_TRANSFORM* trans, float left, float top, float n, float right, float bottom, float f);
	void al_perspective_transform(ALLEGRO_TRANSFORM* trans, float left, float top, float n, float right, float bottom, float f);
	void al_horizontal_shear_transform(ALLEGRO_TRANSFORM* trans, float theta);
	void al_vertical_shear_transform(ALLEGRO_TRANSFORM* trans, float theta);
}
else {
	extern(C) @nogc nothrow {
		alias pal_use_transform = void function(const(ALLEGRO_TRANSFORM)* trans);
		alias pal_use_projection_transform = void function(const(ALLEGRO_TRANSFORM)* trans);
		alias pal_copy_transform = void function(ALLEGRO_TRANSFORM* dest, const(ALLEGRO_TRANSFORM)* src);
		alias pal_identity_transform = void function(ALLEGRO_TRANSFORM* trans);
		alias pal_build_transform = void function(ALLEGRO_TRANSFORM* trans, float x, float y, float sx, float sy, float theta);
		alias pal_build_camera_transform = void function(ALLEGRO_TRANSFORM* trans, float position_x, float position_y, float position_z, 
				float look_x, float look_y, float look_z, float up_x, float up_y, float up_z);
		alias pal_translate_transform = void function(ALLEGRO_TRANSFORM* trans, float x, float y);
		alias pal_translate_transform_3d = void function(ALLEGRO_TRANSFORM* trans, float x, float y, float z);
		alias pal_rotate_transform = void function(ALLEGRO_TRANSFORM* trans, float theta);
		alias pal_rotate_transform_3d = void function(ALLEGRO_TRANSFORM* trans, float x, float y, float z, float angle);
		alias pal_scale_transform = void function(ALLEGRO_TRANSFORM* trans, float sx, float sy);
		alias pal_scale_transform_3d = void function(ALLEGRO_TRANSFORM* trans, float sx, float sy, float sz);
		alias pal_transform_coordinates = void function(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y);
		alias pal_transform_coordinates_3d = void function(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y, float* z);
		alias pal_transform_coordinates_4d = void function(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y, float* z, float* w);
		alias pal_transform_coordinates_3d_projective = void function(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y, float* z);
		alias pal_compose_transform = void function(ALLEGRO_TRANSFORM* trans, const(ALLEGRO_TRANSFORM)* other);
		alias pal_get_current_transform = const(ALLEGRO_TRANSFORM)* function();
		alias pal_get_current_inverse_transform = const(ALLEGRO_TRANSFORM)* function();
		alias pal_get_current_projection_transform = const(ALLEGRO_TRANSFORM)* function();
		alias pal_invert_transform = void function(ALLEGRO_TRANSFORM* trans);
		alias pal_transpose_transform = void function(ALLEGRO_TRANSFORM* trans);
		alias pal_check_inverse = int function(const(ALLEGRO_TRANSFORM)* trans, float tol);
		alias pal_orthographic_transform = void function(ALLEGRO_TRANSFORM* trans, float left, float top, float n, float right, float bottom, float f);
		alias pal_perspective_transform = void function(ALLEGRO_TRANSFORM* trans, float left, float top, float n, float right, float bottom, float f);
		alias pal_horizontal_shear_transform = void function(ALLEGRO_TRANSFORM* trans, float theta);
		alias pal_vertical_shear_transform = void function(ALLEGRO_TRANSFORM* trans, float theta);
	}
	__gshared {
		pal_use_transform al_use_transform;
		pal_use_projection_transform al_use_projection_transform;
		pal_copy_transform al_copy_transform;
		pal_identity_transform al_identity_transform;
		pal_build_transform al_build_transform;
		pal_build_camera_transform al_build_camera_transform;
		pal_translate_transform al_translate_transform;
		pal_translate_transform_3d al_translate_transform_3d;
		pal_rotate_transform al_rotate_transform;
		pal_rotate_transform_3d al_rotate_transform_3d;
		pal_scale_transform al_scale_transform;
		pal_scale_transform_3d al_scale_transform_3d;
		pal_transform_coordinates al_transform_coordinates;
		pal_transform_coordinates_3d al_transform_coordinates_3d;
		pal_transform_coordinates_4d al_transform_coordinates_4d;
		pal_transform_coordinates_3d_projective al_transform_coordinates_3d_projective;
		pal_compose_transform al_compose_transform;
		pal_get_current_transform al_get_current_transform;
		pal_get_current_inverse_transform al_get_current_inverse_transform;
		pal_get_current_projection_transform al_get_current_projection_transform;
		pal_invert_transform al_invert_transform;
		pal_transpose_transform al_transpose_transform;
		pal_check_inverse al_check_inverse;
		pal_orthographic_transform al_orthographic_transform;
		pal_perspective_transform al_perspective_transform;
		pal_horizontal_shear_transform al_horizontal_shear_transform;
		pal_vertical_shear_transform al_vertical_shear_transform;
	}
}
