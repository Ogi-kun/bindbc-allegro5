module bindbc.allegro5.allegro_primitives;

import bindbc.allegro5.config;

static if (allegroPrimitives):

import bindbc.allegro5.bind.color : ALLEGRO_COLOR;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import core.stdc.stdint : uintptr_t;

public import bindbc.allegro5.bind.internal.aintern_primitives_types;

enum ALLEGRO_LINE_JOIN {
	ALLEGRO_LINE_JOIN_NONE,
	ALLEGRO_LINE_JOIN_BEVEL,
	ALLEGRO_LINE_JOIN_ROUND,
	ALLEGRO_LINE_JOIN_MITER,
	ALLEGRO_LINE_JOIN_MITRE = ALLEGRO_LINE_JOIN_MITER,
}
mixin ExpandEnum!ALLEGRO_LINE_JOIN;

enum ALLEGRO_LINE_CAP {
	ALLEGRO_LINE_CAP_NONE,
	ALLEGRO_LINE_CAP_SQUARE,
	ALLEGRO_LINE_CAP_ROUND,
	ALLEGRO_LINE_CAP_TRIANGLE,
	ALLEGRO_LINE_CAP_CLOSED,
}
mixin ExpandEnum!ALLEGRO_LINE_CAP;

enum ALLEGRO_PRIM_QUALITY = 10;

extern(C) @nogc nothrow {
	alias al_emit_triangle_callback = void function(int, int, int, void*);

	alias al_soft_triangle_init = void function(uintptr_t, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*);
	alias al_soft_triangle_first = void function(uintptr_t, int, int, int, int);
	alias al_soft_triangle_step = void function(uintptr_t, int);
	alias al_soft_triangle_draw = void function(uintptr_t, int, int, int);

	alias al_soft_line_first = void function(uintptr_t, int, int, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*);
	alias al_soft_line_step = void function(uintptr_t, int);
	alias al_soft_line_draw = void function(uintptr_t, int, int);

}

static if (staticBinding) {
	extern(C) @nogc nothrow:

	bool al_init_primitives_addon();
	void al_shutdown_primitives_addon();
	uint al_get_allegro_primitives_version();

	int al_draw_prim(const(void)* vtxs, const(ALLEGRO_VERTEX_DECL)* decl, ALLEGRO_BITMAP* texture, int start, int end, int type);
	int al_draw_indexed_prim(const(void)* vtxs, const(ALLEGRO_VERTEX_DECL)* decl, ALLEGRO_BITMAP* texture, const(int)* indices, int num_vtx, int type);
	int al_draw_vertex_buffer(ALLEGRO_VERTEX_BUFFER* vertex_buffer, ALLEGRO_BITMAP* texture, int start, int end, int type);
	int al_draw_indexed_buffer(ALLEGRO_VERTEX_BUFFER* vertex_buffer, ALLEGRO_BITMAP* texture, ALLEGRO_INDEX_BUFFER* index_buffer, int start, int end, int type);

	ALLEGRO_VERTEX_DECL* al_create_vertex_decl(const(ALLEGRO_VERTEX_ELEMENT)* elements, int stride);
	void al_destroy_vertex_decl(ALLEGRO_VERTEX_DECL* decl);

	ALLEGRO_VERTEX_BUFFER* al_create_vertex_buffer(ALLEGRO_VERTEX_DECL* decl, const(void)* initial_data, int num_vertices, int flags);
	void al_destroy_vertex_buffer(ALLEGRO_VERTEX_BUFFER* buffer);
	void* al_lock_vertex_buffer(ALLEGRO_VERTEX_BUFFER* buffer, int offset, int length, int flags);
	void al_unlock_vertex_buffer(ALLEGRO_VERTEX_BUFFER* buffer);
	int al_get_vertex_buffer_size(ALLEGRO_VERTEX_BUFFER* buffer);

	ALLEGRO_INDEX_BUFFER* al_create_index_buffer(int index_size, const(void)* initial_data, int num_indices, int flags);
	void al_destroy_index_buffer(ALLEGRO_INDEX_BUFFER* buffer);
	void* al_lock_index_buffer(ALLEGRO_INDEX_BUFFER* buffer, int offset, int length, int flags);
	void al_unlock_index_buffer(ALLEGRO_INDEX_BUFFER* buffer);
	int al_get_index_buffer_size(ALLEGRO_INDEX_BUFFER* buffer);

	bool al_triangulate_polygon(const(float)* vertices, size_t vertex_stride, const(int)* vertex_counts, al_emit_triangle_callback emit_triangle, void* userdata);

	void al_draw_soft_triangle(ALLEGRO_VERTEX* v1, ALLEGRO_VERTEX* v2, ALLEGRO_VERTEX* v3, uintptr_t state,
			al_soft_triangle_init init,
			al_soft_triangle_first first,
			al_soft_triangle_step step,
			al_soft_triangle_draw draw);
	void al_draw_soft_line(ALLEGRO_VERTEX* v1, ALLEGRO_VERTEX* v2, uintptr_t state,
			al_soft_line_first first,
			al_soft_line_step step,
			al_soft_line_draw draw);

	void al_draw_line(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color, float thickness);
	void al_draw_triangle(float x1, float y1, float x2, float y2, float x3, float y3, ALLEGRO_COLOR color, float thickness);
	void al_draw_rectangle(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color, float thickness);
	void al_draw_rounded_rectangle(float x1, float y1, float x2, float y2, float rx, float ry, ALLEGRO_COLOR color, float thickness);

	void al_calculate_arc(float* dest, int stride, float cx, float cy, float rx, float ry, float start_theta, float delta_theta, float thickness, int num_points);
	void al_draw_circle(float cx, float cy, float r, ALLEGRO_COLOR color, float thickness);
	void al_draw_ellipse(float cx, float cy, float rx, float ry, ALLEGRO_COLOR color, float thickness);
	void al_draw_arc(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness);
	void al_draw_elliptical_arc(float cx, float cy, float rx, float ry, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness);
	void al_draw_pieslice(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness);

	void al_calculate_spline(float* dest, int stride, const(float)[8]* points, float thickness, int num_segments);
	void al_draw_spline(const(float)[8]* points, ALLEGRO_COLOR color, float thickness);

	void al_calculate_ribbon(float* dest, int dest_stride, const(float)* points, int points_stride, float thickness, int num_segments);
	void al_draw_ribbon(const(float)* points, int points_stride, ALLEGRO_COLOR color, float thickness, int num_segments);

	void al_draw_filled_triangle(float x1, float y1, float x2, float y2, float x3, float y3, ALLEGRO_COLOR color);
	void al_draw_filled_rectangle(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color);
	void al_draw_filled_ellipse(float cx, float cy, float rx, float ry, ALLEGRO_COLOR color);
	void al_draw_filled_circle(float cx, float cy, float r, ALLEGRO_COLOR color);
	void al_draw_filled_pieslice(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color);
	void al_draw_filled_rounded_rectangle(float x1, float y1, float x2, float y2, float rx, float ry, ALLEGRO_COLOR color);

	void al_draw_polyline(const(float)* vertices, int vertex_stride, int vertex_count, int join_style, int cap_style, ALLEGRO_COLOR color, float thickness, float miter_limit);

	void al_draw_polygon(const(float)* vertices, int vertex_count, int join_style, ALLEGRO_COLOR color, float thickness, float miter_limit);
	void al_draw_filled_polygon(const(float)* vertices, int vertex_count, ALLEGRO_COLOR color);
	void al_draw_filled_polygon_with_holes(const(float)* vertices, const(int)* vertex_counts, ALLEGRO_COLOR color);

	static if (allegroSupport >= AllegroSupport.v5_2_6) {
		bool al_is_primitives_addon_initialized();
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow {

		bool al_init_primitives_addon() => ptr_al_init_primitives_addon();
		void al_shutdown_primitives_addon() => ptr_al_shutdown_primitives_addon();
		uint al_get_allegro_primitives_version() => ptr_al_get_allegro_primitives_version();

		int al_draw_prim(const(void)* vtxs, const(ALLEGRO_VERTEX_DECL)* decl, ALLEGRO_BITMAP* texture, int start, int end, int type) =>
				ptr_al_draw_prim(vtxs, decl, texture, start, end, type);
		int al_draw_indexed_prim(const(void)* vtxs, const(ALLEGRO_VERTEX_DECL)* decl, ALLEGRO_BITMAP* texture, const(int)* indices, int num_vtx, int type) =>
				ptr_al_draw_indexed_prim(vtxs, decl, texture, indices, num_vtx, type);
		int al_draw_vertex_buffer(ALLEGRO_VERTEX_BUFFER* vertex_buffer, ALLEGRO_BITMAP* texture, int start, int end, int type) =>
				ptr_al_draw_vertex_buffer(vertex_buffer, texture, start, end, type);
		int al_draw_indexed_buffer(ALLEGRO_VERTEX_BUFFER* vertex_buffer, ALLEGRO_BITMAP* texture, ALLEGRO_INDEX_BUFFER* index_buffer, int start, int end, int type) =>
				ptr_al_draw_indexed_buffer(vertex_buffer, texture, index_buffer, start, end, type);

		ALLEGRO_VERTEX_DECL* al_create_vertex_decl(const(ALLEGRO_VERTEX_ELEMENT)* elements, int stride) => ptr_al_create_vertex_decl(elements, stride);
		void al_destroy_vertex_decl(ALLEGRO_VERTEX_DECL* decl) => ptr_al_destroy_vertex_decl(decl);

		ALLEGRO_VERTEX_BUFFER* al_create_vertex_buffer(ALLEGRO_VERTEX_DECL* decl, const(void)* initial_data, int num_vertices, int flags) =>
				ptr_al_create_vertex_buffer(decl, initial_data, num_vertices, flags);
		void al_destroy_vertex_buffer(ALLEGRO_VERTEX_BUFFER* buffer) =>
				ptr_al_destroy_vertex_buffer(buffer);
		void* al_lock_vertex_buffer(ALLEGRO_VERTEX_BUFFER* buffer, int offset, int length, int flags) =>
				ptr_al_lock_vertex_buffer(buffer, offset, length, flags);
		void al_unlock_vertex_buffer(ALLEGRO_VERTEX_BUFFER* buffer) =>
				ptr_al_unlock_vertex_buffer(buffer);
		int al_get_vertex_buffer_size(ALLEGRO_VERTEX_BUFFER* buffer) =>
				ptr_al_get_vertex_buffer_size(buffer);

		ALLEGRO_INDEX_BUFFER* al_create_index_buffer(int index_size, const(void)* initial_data, int num_indices, int flags) =>
				ptr_al_create_index_buffer(index_size, initial_data, num_indices, flags);
		void al_destroy_index_buffer(ALLEGRO_INDEX_BUFFER* buffer) =>
				ptr_al_destroy_index_buffer(buffer);
		void* al_lock_index_buffer(ALLEGRO_INDEX_BUFFER* buffer, int offset, int length, int flags) =>
				ptr_al_lock_index_buffer(buffer, offset, length, flags);
		void al_unlock_index_buffer(ALLEGRO_INDEX_BUFFER* buffer) =>
				ptr_al_unlock_index_buffer(buffer);
		int al_get_index_buffer_size(ALLEGRO_INDEX_BUFFER* buffer) =>
				ptr_al_get_index_buffer_size(buffer);

		bool al_triangulate_polygon(const(float)* vertices, size_t vertex_stride, const(int)* vertex_counts, al_emit_triangle_callback emit_triangle, void* userdata) =>
				ptr_al_triangulate_polygon(vertices, vertex_stride, vertex_counts, emit_triangle, userdata);

		void al_draw_soft_triangle(ALLEGRO_VERTEX* v1, ALLEGRO_VERTEX* v2, ALLEGRO_VERTEX* v3, uintptr_t state,
				al_soft_triangle_init init, al_soft_triangle_first first, al_soft_triangle_step step, al_soft_triangle_draw draw) =>
				ptr_al_draw_soft_triangle(v1, v2, v3, state, init, first, step, draw);
		void al_draw_soft_line(ALLEGRO_VERTEX* v1, ALLEGRO_VERTEX* v2, uintptr_t state,
				al_soft_line_first first, al_soft_line_step step, al_soft_line_draw draw) =>
				ptr_al_draw_soft_line(v1, v2, state, first, step, draw);

		void al_draw_line(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color, float thickness) =>
				ptr_al_draw_line(x1, y1, x2, y2, color, thickness);
		void al_draw_triangle(float x1, float y1, float x2, float y2, float x3, float y3, ALLEGRO_COLOR color, float thickness) =>
				ptr_al_draw_triangle(x1, y1, x2, y2, x3, y3, color, thickness);
		void al_draw_rectangle(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color, float thickness) =>
				ptr_al_draw_rectangle(x1, y1, x2, y2, color, thickness);
		void al_draw_rounded_rectangle(float x1, float y1, float x2, float y2, float rx, float ry, ALLEGRO_COLOR color, float thickness) =>
				ptr_al_draw_rounded_rectangle(x1, y1, x2, y2, rx, ry, color, thickness);

		void al_calculate_arc(float* dest, int stride, float cx, float cy, float rx, float ry, float start_theta, float delta_theta, float thickness, int num_points) =>
				ptr_al_calculate_arc(dest, stride, cx, cy, rx, ry, start_theta, delta_theta, thickness, num_points);
		void al_draw_circle(float cx, float cy, float r, ALLEGRO_COLOR color, float thickness) =>
				ptr_al_draw_circle(cx, cy, r, color, thickness);
		void al_draw_ellipse(float cx, float cy, float rx, float ry, ALLEGRO_COLOR color, float thickness) =>
				ptr_al_draw_ellipse(cx, cy, rx, ry, color, thickness);
		void al_draw_arc(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness) =>
				ptr_al_draw_arc(cx, cy, r, start_theta, delta_theta, color, thickness);
		void al_draw_elliptical_arc(float cx, float cy, float rx, float ry, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness) =>
				ptr_al_draw_elliptical_arc(cx, cy, rx, ry, start_theta, delta_theta, color, thickness);
		void al_draw_pieslice(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness) =>
				ptr_al_draw_pieslice(cx, cy, r, start_theta, delta_theta, color, thickness);

		void al_calculate_spline(float* dest, int stride, const(float)[8]* points, float thickness, int num_segments) =>
				ptr_al_calculate_spline(dest, stride, points, thickness, num_segments);
		void al_draw_spline(const(float)[8]* points, ALLEGRO_COLOR color, float thickness) =>
				ptr_al_draw_spline(points, color, thickness);

		void al_calculate_ribbon(float* dest, int dest_stride, const(float)* points, int points_stride, float thickness, int num_segments) =>
				ptr_al_calculate_ribbon(dest, dest_stride, points, points_stride, thickness, num_segments);
		void al_draw_ribbon(const(float)* points, int points_stride, ALLEGRO_COLOR color, float thickness, int num_segments) =>
				ptr_al_draw_ribbon(points, points_stride, color, thickness, num_segments);

		void al_draw_filled_triangle(float x1, float y1, float x2, float y2, float x3, float y3, ALLEGRO_COLOR color) =>
				ptr_al_draw_filled_triangle(x1, y1, x2, y2, x3, y3, color);
		void al_draw_filled_rectangle(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color) =>
				ptr_al_draw_filled_rectangle(x1, y1, x2, y2, color);
		void al_draw_filled_ellipse(float cx, float cy, float rx, float ry, ALLEGRO_COLOR color) =>
				ptr_al_draw_filled_ellipse(cx, cy, rx, ry, color);
		void al_draw_filled_circle(float cx, float cy, float r, ALLEGRO_COLOR color) =>
				ptr_al_draw_filled_circle(cx, cy, r, color);
		void al_draw_filled_pieslice(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color) =>
				ptr_al_draw_filled_pieslice(cx, cy, r, start_theta, delta_theta, color);
		void al_draw_filled_rounded_rectangle(float x1, float y1, float x2, float y2, float rx, float ry, ALLEGRO_COLOR color) =>
				ptr_al_draw_filled_rounded_rectangle(x1, y1, x2, y2, rx, ry, color);

		void al_draw_polyline(const(float)* vertices, int vertex_stride, int vertex_count, int join_style, int cap_style,
				ALLEGRO_COLOR color, float thickness, float miter_limit) =>
				ptr_al_draw_polyline(vertices, vertex_stride, vertex_count, join_style, cap_style, color, thickness, miter_limit);

		void al_draw_polygon(const(float)* vertices, int vertex_count, int join_style, ALLEGRO_COLOR color, float thickness, float miter_limit) =>
				ptr_al_draw_polygon(vertices, vertex_count, join_style, color, thickness, miter_limit);
		void al_draw_filled_polygon(const(float)* vertices, int vertex_count, ALLEGRO_COLOR color) =>
				ptr_al_draw_filled_polygon(vertices, vertex_count, color);
		void al_draw_filled_polygon_with_holes(const(float)* vertices, const(int)* vertex_counts, ALLEGRO_COLOR color) =>
				ptr_al_draw_filled_polygon_with_holes(vertices, vertex_counts, color);

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			bool al_is_primitives_addon_initialized() => ptr_al_is_primitives_addon_initialized();
		}
	}

	private __gshared {
		typeof(&al_init_primitives_addon) ptr_al_init_primitives_addon;
		typeof(&al_shutdown_primitives_addon) ptr_al_shutdown_primitives_addon;
		typeof(&al_get_allegro_primitives_version) ptr_al_get_allegro_primitives_version;

		typeof(&al_draw_prim) ptr_al_draw_prim;
		typeof(&al_draw_indexed_prim) ptr_al_draw_indexed_prim;
		typeof(&al_draw_vertex_buffer) ptr_al_draw_vertex_buffer;
		typeof(&al_draw_indexed_buffer) ptr_al_draw_indexed_buffer;

		typeof(&al_create_vertex_decl) ptr_al_create_vertex_decl;
		typeof(&al_destroy_vertex_decl) ptr_al_destroy_vertex_decl;

		typeof(&al_create_vertex_buffer) ptr_al_create_vertex_buffer;
		typeof(&al_destroy_vertex_buffer) ptr_al_destroy_vertex_buffer;
		typeof(&al_lock_vertex_buffer) ptr_al_lock_vertex_buffer;
		typeof(&al_unlock_vertex_buffer) ptr_al_unlock_vertex_buffer;
		typeof(&al_get_vertex_buffer_size) ptr_al_get_vertex_buffer_size;

		typeof(&al_create_index_buffer) ptr_al_create_index_buffer;
		typeof(&al_destroy_index_buffer) ptr_al_destroy_index_buffer;
		typeof(&al_lock_index_buffer) ptr_al_lock_index_buffer;
		typeof(&al_unlock_index_buffer) ptr_al_unlock_index_buffer;
		typeof(&al_get_index_buffer_size) ptr_al_get_index_buffer_size;

		typeof(&al_triangulate_polygon) ptr_al_triangulate_polygon;

		typeof(&al_draw_soft_triangle) ptr_al_draw_soft_triangle;
		typeof(&al_draw_soft_line) ptr_al_draw_soft_line;

		typeof(&al_draw_line) ptr_al_draw_line;
		typeof(&al_draw_triangle) ptr_al_draw_triangle;
		typeof(&al_draw_rectangle) ptr_al_draw_rectangle;
		typeof(&al_draw_rounded_rectangle) ptr_al_draw_rounded_rectangle;

		typeof(&al_calculate_arc) ptr_al_calculate_arc;
		typeof(&al_draw_circle) ptr_al_draw_circle;
		typeof(&al_draw_ellipse) ptr_al_draw_ellipse;
		typeof(&al_draw_arc) ptr_al_draw_arc;
		typeof(&al_draw_elliptical_arc) ptr_al_draw_elliptical_arc;
		typeof(&al_draw_pieslice) ptr_al_draw_pieslice;

		typeof(&al_calculate_spline) ptr_al_calculate_spline;
		typeof(&al_draw_spline) ptr_al_draw_spline;

		typeof(&al_calculate_ribbon) ptr_al_calculate_ribbon;
		typeof(&al_draw_ribbon) ptr_al_draw_ribbon;

		typeof(&al_draw_filled_triangle) ptr_al_draw_filled_triangle;
		typeof(&al_draw_filled_rectangle) ptr_al_draw_filled_rectangle;
		typeof(&al_draw_filled_ellipse) ptr_al_draw_filled_ellipse;
		typeof(&al_draw_filled_circle) ptr_al_draw_filled_circle;
		typeof(&al_draw_filled_pieslice) ptr_al_draw_filled_pieslice;
		typeof(&al_draw_filled_rounded_rectangle) ptr_al_draw_filled_rounded_rectangle;

		typeof(&al_draw_polyline) ptr_al_draw_polyline;

		typeof(&al_draw_polygon) ptr_al_draw_polygon;
		typeof(&al_draw_filled_polygon) ptr_al_draw_filled_polygon;
		typeof(&al_draw_filled_polygon_with_holes) ptr_al_draw_filled_polygon_with_holes;

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			typeof(&al_is_primitives_addon_initialized) ptr_al_is_primitives_addon_initialized;
		}
	}

	import bindbc.loader;

	@nogc nothrow:

	version (Allegro_Monolith) {} else {

		private {
			__gshared SharedLib lib;
			__gshared AllegroSupport loadedVersion;
		}

		void unloadAllegroPrimitives() {
			if (lib != invalidHandle) {
				lib.unload();
			}
		}

		AllegroSupport loadedAllegroPrimitivesVersion() {
			return loadedVersion;
		}

		bool isAllegroPrimitivesLoaded() {
			return lib != invalidHandle;
		}

		AllegroSupport loadAllegroPrimitives() {
			const(char)[][1] libNames = [
				dynlibFilename!"primitives",
			];

			typeof(return) result;
			foreach (i; 0..libNames.length) {
				result = loadAllegroPrimitives(libNames[i].ptr);
				if (result != AllegroSupport.noLibrary) {
					break;
				}
			}
			return result;
		}

		AllegroSupport loadAllegroPrimitives(const(char)* libName) {
			lib = load(libName);
			if (lib == invalidHandle) {
				return AllegroSupport.noLibrary;
			}
			loadedVersion = bindAllegroPrimitives(lib);
			return loadedVersion == allegroSupport ? allegroSupport : AllegroSupport.badLibrary;
		}
	}

	package AllegroSupport bindAllegroPrimitives(SharedLib lib) {

		auto lastErrorCount = errorCount();

		lib.bindSymbol(cast(void**)&ptr_al_init_primitives_addon, "al_init_primitives_addon");
		lib.bindSymbol(cast(void**)&ptr_al_shutdown_primitives_addon, "al_shutdown_primitives_addon");
		lib.bindSymbol(cast(void**)&ptr_al_get_allegro_primitives_version, "al_get_allegro_primitives_version");

		lib.bindSymbol(cast(void**)&ptr_al_draw_prim, "al_draw_prim");
		lib.bindSymbol(cast(void**)&ptr_al_draw_indexed_prim, "al_draw_indexed_prim");
		lib.bindSymbol(cast(void**)&ptr_al_draw_vertex_buffer, "al_draw_vertex_buffer");
		lib.bindSymbol(cast(void**)&ptr_al_draw_indexed_buffer, "al_draw_indexed_buffer");

		lib.bindSymbol(cast(void**)&ptr_al_create_vertex_decl, "al_create_vertex_decl");
		lib.bindSymbol(cast(void**)&ptr_al_destroy_vertex_decl, "al_destroy_vertex_decl");

		lib.bindSymbol(cast(void**)&ptr_al_create_vertex_buffer, "al_create_vertex_buffer");
		lib.bindSymbol(cast(void**)&ptr_al_destroy_vertex_buffer, "al_destroy_vertex_buffer");
		lib.bindSymbol(cast(void**)&ptr_al_lock_vertex_buffer, "al_lock_vertex_buffer");
		lib.bindSymbol(cast(void**)&ptr_al_unlock_vertex_buffer, "al_unlock_vertex_buffer");
		lib.bindSymbol(cast(void**)&ptr_al_get_vertex_buffer_size, "al_get_vertex_buffer_size");

		lib.bindSymbol(cast(void**)&ptr_al_create_index_buffer, "al_create_index_buffer");
		lib.bindSymbol(cast(void**)&ptr_al_destroy_index_buffer, "al_destroy_index_buffer");
		lib.bindSymbol(cast(void**)&ptr_al_lock_index_buffer, "al_lock_index_buffer");
		lib.bindSymbol(cast(void**)&ptr_al_unlock_index_buffer, "al_unlock_index_buffer");
		lib.bindSymbol(cast(void**)&ptr_al_get_index_buffer_size, "al_get_index_buffer_size");

		lib.bindSymbol(cast(void**)&ptr_al_triangulate_polygon, "al_triangulate_polygon");

		lib.bindSymbol(cast(void**)&ptr_al_draw_soft_triangle, "al_draw_soft_triangle");
		lib.bindSymbol(cast(void**)&ptr_al_draw_soft_line, "al_draw_soft_line");

		lib.bindSymbol(cast(void**)&ptr_al_draw_line, "al_draw_line");
		lib.bindSymbol(cast(void**)&ptr_al_draw_triangle, "al_draw_triangle");
		lib.bindSymbol(cast(void**)&ptr_al_draw_rectangle, "al_draw_rectangle");
		lib.bindSymbol(cast(void**)&ptr_al_draw_rounded_rectangle, "al_draw_rounded_rectangle");

		lib.bindSymbol(cast(void**)&ptr_al_calculate_arc, "al_calculate_arc");
		lib.bindSymbol(cast(void**)&ptr_al_draw_circle, "al_draw_circle");
		lib.bindSymbol(cast(void**)&ptr_al_draw_ellipse, "al_draw_ellipse");
		lib.bindSymbol(cast(void**)&ptr_al_draw_arc, "al_draw_arc");
		lib.bindSymbol(cast(void**)&ptr_al_draw_elliptical_arc, "al_draw_elliptical_arc");
		lib.bindSymbol(cast(void**)&ptr_al_draw_pieslice, "al_draw_pieslice");

		lib.bindSymbol(cast(void**)&ptr_al_calculate_spline, "al_calculate_spline");
		lib.bindSymbol(cast(void**)&ptr_al_draw_spline, "al_draw_spline");

		lib.bindSymbol(cast(void**)&ptr_al_calculate_ribbon, "al_calculate_ribbon");
		lib.bindSymbol(cast(void**)&ptr_al_draw_ribbon, "al_draw_ribbon");

		lib.bindSymbol(cast(void**)&ptr_al_draw_filled_triangle, "al_draw_filled_triangle");
		lib.bindSymbol(cast(void**)&ptr_al_draw_filled_rectangle, "al_draw_filled_rectangle");
		lib.bindSymbol(cast(void**)&ptr_al_draw_filled_ellipse, "al_draw_filled_ellipse");
		lib.bindSymbol(cast(void**)&ptr_al_draw_filled_circle, "al_draw_filled_circle");
		lib.bindSymbol(cast(void**)&ptr_al_draw_filled_pieslice, "al_draw_filled_pieslice");
		lib.bindSymbol(cast(void**)&ptr_al_draw_filled_rounded_rectangle, "al_draw_filled_rounded_rectangle");

		lib.bindSymbol(cast(void**)&ptr_al_draw_polyline, "al_draw_polyline");

		lib.bindSymbol(cast(void**)&ptr_al_draw_polygon, "al_draw_polygon");
		lib.bindSymbol(cast(void**)&ptr_al_draw_filled_polygon, "al_draw_filled_polygon");
		lib.bindSymbol(cast(void**)&ptr_al_draw_filled_polygon_with_holes, "al_draw_filled_polygon_with_holes");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&ptr_al_is_primitives_addon_initialized, "al_is_primitives_addon_initialized");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.v5_2_5;
			}
		}

		return allegroSupport;
	}
}
