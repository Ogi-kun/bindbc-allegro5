module bindbc.allegro5.allegro_primitives;

import bindbc.allegro5.config;

static if (allegroPrimitives):

import bindbc.allegro5.bind.color : ALLEGRO_COLOR;
import bindbc.allegro5.bind.bitmap : ALLEGRO_BITMAP;
import bindbc.allegro5.bind.display : _ALLEGRO_PRIM_MAX_USER_ATTR;
import core.stdc.stdint : uintptr_t;

enum ALLEGRO_PRIM_TYPE {
	ALLEGRO_PRIM_LINE_LIST,
	ALLEGRO_PRIM_LINE_STRIP,
	ALLEGRO_PRIM_LINE_LOOP,
	ALLEGRO_PRIM_TRIANGLE_LIST,
	ALLEGRO_PRIM_TRIANGLE_STRIP,
	ALLEGRO_PRIM_TRIANGLE_FAN,
	ALLEGRO_PRIM_POINT_LIST,
	ALLEGRO_PRIM_NUM_TYPES,
}

enum ALLEGRO_PRIM_MAX_USER_ATTR = _ALLEGRO_PRIM_MAX_USER_ATTR;

enum ALLEGRO_PRIM_ATTR {
	ALLEGRO_PRIM_POSITION = 1,
	ALLEGRO_PRIM_COLOR_ATTR,
	ALLEGRO_PRIM_TEX_COORD,
	ALLEGRO_PRIM_TEX_COORD_PIXEL,
	ALLEGRO_PRIM_USER_ATTR,
	ALLEGRO_PRIM_ATTR_NUM = ALLEGRO_PRIM_USER_ATTR + ALLEGRO_PRIM_MAX_USER_ATTR
}

enum ALLEGRO_PRIM_STORAGE {
	ALLEGRO_PRIM_FLOAT_2,
	ALLEGRO_PRIM_FLOAT_3,
	ALLEGRO_PRIM_SHORT_2,
	ALLEGRO_PRIM_FLOAT_1,
	ALLEGRO_PRIM_FLOAT_4,
	ALLEGRO_PRIM_UBYTE_4,
	ALLEGRO_PRIM_SHORT_4,
	ALLEGRO_PRIM_NORMALIZED_UBYTE_4,
	ALLEGRO_PRIM_NORMALIZED_SHORT_2,
	ALLEGRO_PRIM_NORMALIZED_SHORT_4,
	ALLEGRO_PRIM_NORMALIZED_USHORT_2,
	ALLEGRO_PRIM_NORMALIZED_USHORT_4,
	ALLEGRO_PRIM_HALF_FLOAT_2,
	ALLEGRO_PRIM_HALF_FLOAT_4,
}

enum ALLEGRO_LINE_JOIN {
	ALLEGRO_LINE_JOIN_NONE,
	ALLEGRO_LINE_JOIN_BEVEL,
	ALLEGRO_LINE_JOIN_ROUND,
	ALLEGRO_LINE_JOIN_MITER,
	ALLEGRO_LINE_JOIN_MITRE = ALLEGRO_LINE_JOIN_MITER,
}

enum ALLEGRO_LINE_CAP {
	ALLEGRO_LINE_CAP_NONE,
	ALLEGRO_LINE_CAP_SQUARE,
	ALLEGRO_LINE_CAP_ROUND,
	ALLEGRO_LINE_CAP_TRIANGLE,
	ALLEGRO_LINE_CAP_CLOSED,
}

enum ALLEGRO_PRIM_BUFFER_FLAGS {
	 ALLEGRO_PRIM_BUFFER_STREAM       = 0x01,
	 ALLEGRO_PRIM_BUFFER_STATIC       = 0x02,
	 ALLEGRO_PRIM_BUFFER_DYNAMIC      = 0x04,
	 ALLEGRO_PRIM_BUFFER_READWRITE    = 0x08,
}

enum ALLEGRO_VERTEX_CACHE_SIZE = 256;

enum ALLEGRO_PRIM_QUALITY = 10;
	
struct ALLEGRO_VERTEX_ELEMENT {
	 int attribute;
	 int storage;
	 int offset;
}

struct ALLEGRO_VERTEX_DECL;

struct ALLEGRO_VERTEX {
	float x, y, z;
	float u, v;
	ALLEGRO_COLOR color;
}

struct ALLEGRO_VERTEX_BUFFER;

struct ALLEGRO_INDEX_BUFFER;

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

	bool al_triangulate_polygon(const(float)* vertices, size_t vertex_stride, const(int)* vertex_counts, void function(int, int, int, void*) emit_triangle, void* userdata);

	void al_draw_soft_triangle(ALLEGRO_VERTEX* v1, ALLEGRO_VERTEX* v2, ALLEGRO_VERTEX* v3, uintptr_t state,
			void function(uintptr_t, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*) init,
			void function(uintptr_t, int, int, int, int) first,
			void function(uintptr_t, int) step,
			void function(uintptr_t, int, int, int) draw);
	void al_draw_soft_line(ALLEGRO_VERTEX* v1, ALLEGRO_VERTEX* v2, uintptr_t state,
			void function(uintptr_t, int, int, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*) first,
			void function(uintptr_t, int) step,
			void function(uintptr_t, int, int) draw);

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

	void al_calculate_spline(float* dest, int stride, float[8] points, float thickness, int num_segments);
	void al_draw_spline(float[8] points, ALLEGRO_COLOR color, float thickness);

	void al_calculate_ribbon(float* dest, int dest_stride, const(float)  points, int points_stride, float thickness, int num_segments);
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
	extern(C) @nogc nothrow {
		alias pal_init_primitives_addon = bool function();
		alias pal_shutdown_primitives_addon = void function();
		alias pal_get_allegro_primitives_version = uint function();
	
		alias pal_draw_prim = int function(const(void)* vtxs, const(ALLEGRO_VERTEX_DECL)* decl, ALLEGRO_BITMAP* texture, int start, int end, int type);
		alias pal_draw_indexed_prim = int function(const(void)* vtxs, const(ALLEGRO_VERTEX_DECL)* decl, ALLEGRO_BITMAP* texture, const(int)* indices, int num_vtx, int type);
		alias pal_draw_vertex_buffer = int function(ALLEGRO_VERTEX_BUFFER* vertex_buffer, ALLEGRO_BITMAP* texture, int start, int end, int type);
		alias pal_draw_indexed_buffer = int function(ALLEGRO_VERTEX_BUFFER* vertex_buffer, ALLEGRO_BITMAP* texture, ALLEGRO_INDEX_BUFFER* index_buffer, int start, int end, int type);
	
		alias pal_create_vertex_decl = ALLEGRO_VERTEX_DECL* function(const(ALLEGRO_VERTEX_ELEMENT)* elements, int stride);
		alias pal_destroy_vertex_decl = void function(ALLEGRO_VERTEX_DECL* decl);
	
		alias pal_create_vertex_buffer = ALLEGRO_VERTEX_BUFFER* function(ALLEGRO_VERTEX_DECL* decl, const(void)* initial_data, int num_vertices, int flags);
		alias pal_destroy_vertex_buffer = void function(ALLEGRO_VERTEX_BUFFER* buffer);
		alias pal_lock_vertex_buffer = void* function(ALLEGRO_VERTEX_BUFFER* buffer, int offset, int length, int flags);
		alias pal_unlock_vertex_buffer = void function(ALLEGRO_VERTEX_BUFFER* buffer);
		alias pal_get_vertex_buffer_size = int function(ALLEGRO_VERTEX_BUFFER* buffer);
	
		alias pal_create_index_buffer = ALLEGRO_INDEX_BUFFER* function(int index_size, const(void)* initial_data, int num_indices, int flags);
		alias pal_destroy_index_buffer = void function(ALLEGRO_INDEX_BUFFER* buffer);
		alias pal_lock_index_buffer = void* function(ALLEGRO_INDEX_BUFFER* buffer, int offset, int length, int flags);
		alias pal_unlock_index_buffer = void function(ALLEGRO_INDEX_BUFFER* buffer);
		alias pal_get_index_buffer_size = int function(ALLEGRO_INDEX_BUFFER* buffer);
	
		alias pal_triangulate_polygon = bool function(const(float)* vertices, size_t vertex_stride, const(int)* vertex_counts, void function(int, int, int, void*) emit_triangle, void* userdata);
	
		alias pal_draw_soft_triangle = void function(ALLEGRO_VERTEX* v1, ALLEGRO_VERTEX* v2, ALLEGRO_VERTEX* v3, uintptr_t state,
				void function(uintptr_t, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*) init,
				void function(uintptr_t, int, int, int, int) first,
				void function(uintptr_t, int) step,
			    void function(uintptr_t, int, int, int) draw);
		alias pal_draw_soft_line = void function(ALLEGRO_VERTEX* v1, ALLEGRO_VERTEX* v2, uintptr_t state,
				void function(uintptr_t, int, int, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*) first,
				void function(uintptr_t, int) step,
				void function(uintptr_t, int, int) draw);
	
		alias pal_draw_line = void function(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color, float thickness);
		alias pal_draw_triangle = void function(float x1, float y1, float x2, float y2, float x3, float y3, ALLEGRO_COLOR color, float thickness);
		alias pal_draw_rectangle = void function(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color, float thickness);
		alias pal_draw_rounded_rectangle = void function(float x1, float y1, float x2, float y2, float rx, float ry, ALLEGRO_COLOR color, float thickness);
	
		alias pal_calculate_arc = void function(float* dest, int stride, float cx, float cy, float rx, float ry, float start_theta, float delta_theta, float thickness, int num_points);
		alias pal_draw_circle = void function(float cx, float cy, float r, ALLEGRO_COLOR color, float thickness);
		alias pal_draw_ellipse = void function(float cx, float cy, float rx, float ry, ALLEGRO_COLOR color, float thickness);
		alias pal_draw_arc = void function(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness);
		alias pal_draw_elliptical_arc = void function(float cx, float cy, float rx, float ry, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness);
		alias pal_draw_pieslice = void function(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness);
	
		alias pal_calculate_spline = void function(float* dest, int stride, float[8] points, float thickness, int num_segments);
		alias pal_draw_spline = void function(float[8] points, ALLEGRO_COLOR color, float thickness);
	
		alias pal_calculate_ribbon = void function(float* dest, int dest_stride, const(float)  points, int points_stride, float thickness, int num_segments);
		alias pal_draw_ribbon = void function(const(float)* points, int points_stride, ALLEGRO_COLOR color, float thickness, int num_segments);
	
		alias pal_draw_filled_triangle = void function(float x1, float y1, float x2, float y2, float x3, float y3, ALLEGRO_COLOR color);
		alias pal_draw_filled_rectangle = void function(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color);
		alias pal_draw_filled_ellipse = void function(float cx, float cy, float rx, float ry, ALLEGRO_COLOR color);
		alias pal_draw_filled_circle = void function(float cx, float cy, float r, ALLEGRO_COLOR color);
		alias pal_draw_filled_pieslice = void function(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color);
		alias pal_draw_filled_rounded_rectangle = void function(float x1, float y1, float x2, float y2, float rx, float ry, ALLEGRO_COLOR color);
	
		alias pal_draw_polyline = void function(const(float)* vertices, int vertex_stride, int vertex_count, int join_style, int cap_style, ALLEGRO_COLOR color, float thickness, float miter_limit);
	
		alias pal_draw_polygon = void function(const(float)* vertices, int vertex_count, int join_style, ALLEGRO_COLOR color, float thickness, float miter_limit);
		alias pal_draw_filled_polygon = void function(const(float)* vertices, int vertex_count, ALLEGRO_COLOR color);
		alias pal_draw_filled_polygon_with_holes = void function(const(float)* vertices, const(int)* vertex_counts, ALLEGRO_COLOR color);
	
		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			alias pal_is_primitives_addon_initialized = bool function();
		}
	}

	__gshared {
		pal_init_primitives_addon al_init_primitives_addon;
		pal_shutdown_primitives_addon al_shutdown_primitives_addon;
		pal_get_allegro_primitives_version al_get_allegro_primitives_version;

		pal_draw_prim al_draw_prim;
		pal_draw_indexed_prim al_draw_indexed_prim;
		pal_draw_vertex_buffer al_draw_vertex_buffer;
		pal_draw_indexed_buffer al_draw_indexed_buffer;

		pal_create_vertex_decl al_create_vertex_decl;
		pal_destroy_vertex_decl al_destroy_vertex_decl;

		pal_create_vertex_buffer al_create_vertex_buffer;
		pal_destroy_vertex_buffer al_destroy_vertex_buffer;
		pal_lock_vertex_buffer al_lock_vertex_buffer;
		pal_unlock_vertex_buffer al_unlock_vertex_buffer;
		pal_get_vertex_buffer_size al_get_vertex_buffer_size;

		pal_create_index_buffer al_create_index_buffer;
		pal_destroy_index_buffer al_destroy_index_buffer;
		pal_lock_index_buffer al_lock_index_buffer;
		pal_unlock_index_buffer al_unlock_index_buffer;
		pal_get_index_buffer_size al_get_index_buffer_size;

		pal_triangulate_polygon al_triangulate_polygon;

		pal_draw_soft_triangle al_draw_soft_triangle;
		pal_draw_soft_line al_draw_soft_line;

		pal_draw_line al_draw_line;
		pal_draw_triangle al_draw_triangle;
		pal_draw_rectangle al_draw_rectangle;
		pal_draw_rounded_rectangle al_draw_rounded_rectangle;

		pal_calculate_arc al_calculate_arc;
		pal_draw_circle al_draw_circle;
		pal_draw_ellipse al_draw_ellipse;
		pal_draw_arc al_draw_arc;
		pal_draw_elliptical_arc al_draw_elliptical_arc;
		pal_draw_pieslice al_draw_pieslice;

		pal_calculate_spline al_calculate_spline;
		pal_draw_spline al_draw_spline;

		pal_calculate_ribbon al_calculate_ribbon;
		pal_draw_ribbon al_draw_ribbon;

		pal_draw_filled_triangle al_draw_filled_triangle;
		pal_draw_filled_rectangle al_draw_filled_rectangle;
		pal_draw_filled_ellipse al_draw_filled_ellipse;
		pal_draw_filled_circle al_draw_filled_circle;
		pal_draw_filled_pieslice al_draw_filled_pieslice;
		pal_draw_filled_rounded_rectangle al_draw_filled_rounded_rectangle;

		pal_draw_polyline al_draw_polyline;

		pal_draw_polygon al_draw_polygon;
		pal_draw_filled_polygon al_draw_filled_polygon;
		pal_draw_filled_polygon_with_holes al_draw_filled_polygon_with_holes;

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			pal_is_primitives_addon_initialized al_is_primitives_addon_initialized;
		}
	}

	import bindbc.loader;

	private {
		__gshared SharedLib lib;
		__gshared AllegroSupport loadedVersion;
	}

	@nogc nothrow:

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
			libName!"primitives",
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

		auto lastErrorCount = errorCount();
		loadedVersion = AllegroSupport.badLibrary;

		lib.bindSymbol(cast(void**)&al_init_primitives_addon, "al_init_primitives_addon");
		lib.bindSymbol(cast(void**)&al_shutdown_primitives_addon, "al_shutdown_primitives_addon");
		lib.bindSymbol(cast(void**)&al_get_allegro_primitives_version, "al_get_allegro_primitives_version");

		lib.bindSymbol(cast(void**)&al_draw_prim, "al_draw_prim");
		lib.bindSymbol(cast(void**)&al_draw_indexed_prim, "al_draw_indexed_prim");
		lib.bindSymbol(cast(void**)&al_draw_vertex_buffer, "al_draw_vertex_buffer");
		lib.bindSymbol(cast(void**)&al_draw_indexed_buffer, "al_draw_indexed_buffer");

		lib.bindSymbol(cast(void**)&al_create_vertex_decl, "al_create_vertex_decl");
		lib.bindSymbol(cast(void**)&al_destroy_vertex_decl, "al_destroy_vertex_decl");

		lib.bindSymbol(cast(void**)&al_create_vertex_buffer, "al_create_vertex_buffer");
		lib.bindSymbol(cast(void**)&al_destroy_vertex_buffer, "al_destroy_vertex_buffer");
		lib.bindSymbol(cast(void**)&al_lock_vertex_buffer, "al_lock_vertex_buffer");
		lib.bindSymbol(cast(void**)&al_unlock_vertex_buffer, "al_unlock_vertex_buffer");
		lib.bindSymbol(cast(void**)&al_get_vertex_buffer_size, "al_get_vertex_buffer_size");

		lib.bindSymbol(cast(void**)&al_create_index_buffer, "al_create_index_buffer");
		lib.bindSymbol(cast(void**)&al_destroy_index_buffer, "al_destroy_index_buffer");
		lib.bindSymbol(cast(void**)&al_lock_index_buffer, "al_lock_index_buffer");
		lib.bindSymbol(cast(void**)&al_unlock_index_buffer, "al_unlock_index_buffer");
		lib.bindSymbol(cast(void**)&al_get_index_buffer_size, "al_get_index_buffer_size");

		lib.bindSymbol(cast(void**)&al_triangulate_polygon, "al_triangulate_polygon");

		lib.bindSymbol(cast(void**)&al_draw_soft_triangle, "al_draw_soft_triangle");
		lib.bindSymbol(cast(void**)&al_draw_soft_line, "al_draw_soft_line");

		lib.bindSymbol(cast(void**)&al_draw_line, "al_draw_line");
		lib.bindSymbol(cast(void**)&al_draw_triangle, "al_draw_triangle");
		lib.bindSymbol(cast(void**)&al_draw_rectangle, "al_draw_rectangle");
		lib.bindSymbol(cast(void**)&al_draw_rounded_rectangle, "al_draw_rounded_rectangle");

		lib.bindSymbol(cast(void**)&al_calculate_arc, "al_calculate_arc");
		lib.bindSymbol(cast(void**)&al_draw_circle, "al_draw_circle");
		lib.bindSymbol(cast(void**)&al_draw_ellipse, "al_draw_ellipse");
		lib.bindSymbol(cast(void**)&al_draw_arc, "al_draw_arc");
		lib.bindSymbol(cast(void**)&al_draw_elliptical_arc, "al_draw_elliptical_arc");
		lib.bindSymbol(cast(void**)&al_draw_pieslice, "al_draw_pieslice");

		lib.bindSymbol(cast(void**)&al_calculate_spline, "al_calculate_spline");
		lib.bindSymbol(cast(void**)&al_draw_spline, "al_draw_spline");

		lib.bindSymbol(cast(void**)&al_calculate_ribbon, "al_calculate_ribbon");
		lib.bindSymbol(cast(void**)&al_draw_ribbon, "al_draw_ribbon");

		lib.bindSymbol(cast(void**)&al_draw_filled_triangle, "al_draw_filled_triangle");
		lib.bindSymbol(cast(void**)&al_draw_filled_rectangle, "al_draw_filled_rectangle");
		lib.bindSymbol(cast(void**)&al_draw_filled_ellipse, "al_draw_filled_ellipse");
		lib.bindSymbol(cast(void**)&al_draw_filled_circle, "al_draw_filled_circle");
		lib.bindSymbol(cast(void**)&al_draw_filled_pieslice, "al_draw_filled_pieslice");
		lib.bindSymbol(cast(void**)&al_draw_filled_rounded_rectangle, "al_draw_filled_rounded_rectangle");

		lib.bindSymbol(cast(void**)&al_draw_polyline, "al_draw_polyline");

		lib.bindSymbol(cast(void**)&al_draw_polygon, "al_draw_polygon");
		lib.bindSymbol(cast(void**)&al_draw_filled_polygon, "al_draw_filled_polygon");
		lib.bindSymbol(cast(void**)&al_draw_filled_polygon_with_holes, "al_draw_filled_polygon_with_holes");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}
		loadedVersion = AllegroSupport.v5_2_0;

		static if (allegroSupport >= AllegroSupport.v5_2_6) {
			lib.bindSymbol(cast(void**)&al_is_primitives_addon_initialized, "al_is_primitives_addon_initialized");

			if (errorCount() != lastErrorCount) {
				return AllegroSupport.badLibrary;
			}
			loadedVersion = AllegroSupport.v5_2_6;
		}

		return loadedVersion;
	}
}
