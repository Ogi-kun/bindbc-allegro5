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

	void al_compose_transform(ALLEGRO_TRANSFORM* trans, const(ALLEGRO_TRANSFORM)* other);
	const(ALLEGRO_TRANSFORM)* al_get_current_transform();
	const(ALLEGRO_TRANSFORM)* al_get_current_inverse_transform();
	const(ALLEGRO_TRANSFORM)* al_get_current_projection_transform();
	void al_invert_transform(ALLEGRO_TRANSFORM* trans);
	int al_check_inverse(const(ALLEGRO_TRANSFORM)* trans, float tol);
	void al_orthographic_transform(ALLEGRO_TRANSFORM* trans, float left, float top, float n, float right, float bottom, float f);
	void al_perspective_transform(ALLEGRO_TRANSFORM* trans, float left, float top, float n, float right, float bottom, float f);
	void al_horizontal_shear_transform(ALLEGRO_TRANSFORM* trans, float theta);
	void al_vertical_shear_transform(ALLEGRO_TRANSFORM* trans, float theta);

	static if (allegroSupport >= AllegroSupport.v5_2_4) {
		void al_transform_coordinates_4d(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y, float* z, float* w);
		void al_transform_coordinates_3d_projective(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y, float* z);
	}
	static if (allegroSupport >= AllegroSupport.v5_2_5) {
		void al_transpose_transform(ALLEGRO_TRANSFORM* trans);
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	void al_use_transform(const(ALLEGRO_TRANSFORM)* trans) => ptr_al_use_transform(trans);
	void al_use_projection_transform(const(ALLEGRO_TRANSFORM)* trans) => ptr_al_use_projection_transform(trans);
	void al_copy_transform(ALLEGRO_TRANSFORM* dest, const(ALLEGRO_TRANSFORM)* src) => ptr_al_copy_transform(dest, src);
	void al_identity_transform(ALLEGRO_TRANSFORM* trans) => ptr_al_identity_transform(trans);
	void al_build_transform(ALLEGRO_TRANSFORM* trans, float x, float y, float sx, float sy, float theta) => ptr_al_build_transform(trans, x, y, sx, sy, theta);
	void al_build_camera_transform(ALLEGRO_TRANSFORM* trans, float position_x, float position_y, float position_z, float look_x, float look_y, float look_z, 
			float up_x, float up_y, float up_z) => ptr_al_build_camera_transform(trans, position_x, position_y, position_z, look_x, look_y, look_z, up_x, up_y, up_z);
	void al_translate_transform(ALLEGRO_TRANSFORM* trans, float x, float y) => ptr_al_translate_transform(trans, x, y);
	void al_translate_transform_3d(ALLEGRO_TRANSFORM* trans, float x, float y, float z) => ptr_al_translate_transform_3d(trans, x, y, z);
	void al_rotate_transform(ALLEGRO_TRANSFORM* trans, float theta) => ptr_al_rotate_transform(trans, theta);
	void al_rotate_transform_3d(ALLEGRO_TRANSFORM* trans, float x, float y, float z, float angle) => ptr_al_rotate_transform_3d(trans, x, y, z, angle);
	void al_scale_transform(ALLEGRO_TRANSFORM* trans, float sx, float sy) => ptr_al_scale_transform(trans, sx, sy);
	void al_scale_transform_3d(ALLEGRO_TRANSFORM* trans, float sx, float sy, float sz) => ptr_al_scale_transform_3d(trans, sx, sy, sz);
	void al_transform_coordinates(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y) => ptr_al_transform_coordinates(trans, x, y);
	void al_transform_coordinates_3d(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y, float* z) => ptr_al_transform_coordinates_3d(trans, x, y, z);

	void al_compose_transform(ALLEGRO_TRANSFORM* trans, const(ALLEGRO_TRANSFORM)* other) => ptr_al_compose_transform(trans, other);
	const(ALLEGRO_TRANSFORM)* al_get_current_transform() => ptr_al_get_current_transform();
	const(ALLEGRO_TRANSFORM)* al_get_current_inverse_transform() => ptr_al_get_current_inverse_transform();
	const(ALLEGRO_TRANSFORM)* al_get_current_projection_transform() => ptr_al_get_current_projection_transform();
	void al_invert_transform(ALLEGRO_TRANSFORM* trans) => ptr_al_invert_transform(trans);
	int al_check_inverse(const(ALLEGRO_TRANSFORM)* trans, float tol) => ptr_al_check_inverse(trans, tol);
	void al_orthographic_transform(ALLEGRO_TRANSFORM* trans, float left, float top, float n, float right, float bottom, float f) =>
			ptr_al_orthographic_transform(trans, left, top, n, right, bottom, f);
	void al_perspective_transform(ALLEGRO_TRANSFORM* trans, float left, float top, float n, float right, float bottom, float f) =>
			ptr_al_perspective_transform(trans, left, top, n, right, bottom, f);
	void al_horizontal_shear_transform(ALLEGRO_TRANSFORM* trans, float theta) => ptr_al_horizontal_shear_transform(trans, theta);
	void al_vertical_shear_transform(ALLEGRO_TRANSFORM* trans, float theta) => ptr_al_vertical_shear_transform(trans, theta);

	static if (allegroSupport >= AllegroSupport.v5_2_4) {
		void al_transform_coordinates_4d(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y, float* z, float* w) => ptr_al_transform_coordinates_4d(trans, x, y, z, w);
		void al_transform_coordinates_3d_projective(const(ALLEGRO_TRANSFORM)* trans, float* x, float* y, float* z) => ptr_al_transform_coordinates_3d_projective(trans, x, y, z);
	}
	static if (allegroSupport >= AllegroSupport.v5_2_5) {
		void al_transpose_transform(ALLEGRO_TRANSFORM* trans) => ptr_al_transpose_transform(trans);
	}

	package(bindbc.allegro5) __gshared {
		typeof(&al_use_transform) ptr_al_use_transform;
		typeof(&al_use_projection_transform) ptr_al_use_projection_transform;
		typeof(&al_copy_transform) ptr_al_copy_transform;
		typeof(&al_identity_transform) ptr_al_identity_transform;
		typeof(&al_build_transform) ptr_al_build_transform;
		typeof(&al_build_camera_transform) ptr_al_build_camera_transform;
		typeof(&al_translate_transform) ptr_al_translate_transform;
		typeof(&al_translate_transform_3d) ptr_al_translate_transform_3d;
		typeof(&al_rotate_transform) ptr_al_rotate_transform;
		typeof(&al_rotate_transform_3d) ptr_al_rotate_transform_3d;
		typeof(&al_scale_transform) ptr_al_scale_transform;
		typeof(&al_scale_transform_3d) ptr_al_scale_transform_3d;
		typeof(&al_transform_coordinates) ptr_al_transform_coordinates;
		typeof(&al_transform_coordinates_3d) ptr_al_transform_coordinates_3d;
		typeof(&al_compose_transform) ptr_al_compose_transform;
		typeof(&al_get_current_transform) ptr_al_get_current_transform;
		typeof(&al_get_current_inverse_transform) ptr_al_get_current_inverse_transform;
		typeof(&al_get_current_projection_transform) ptr_al_get_current_projection_transform;
		typeof(&al_invert_transform) ptr_al_invert_transform;
		typeof(&al_check_inverse) ptr_al_check_inverse;
		typeof(&al_orthographic_transform) ptr_al_orthographic_transform;
		typeof(&al_perspective_transform) ptr_al_perspective_transform;
		typeof(&al_horizontal_shear_transform) ptr_al_horizontal_shear_transform;
		typeof(&al_vertical_shear_transform) ptr_al_vertical_shear_transform;

		static if (allegroSupport >= AllegroSupport.v5_2_5) {
			typeof(&al_transform_coordinates_4d) ptr_al_transform_coordinates_4d;
			typeof(&al_transform_coordinates_3d_projective) ptr_al_transform_coordinates_3d_projective;
		}
		static if (allegroSupport >= AllegroSupport.v5_2_5) {
			typeof(&al_transpose_transform) ptr_al_transpose_transform;
		}
	}
}
