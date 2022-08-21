module bindbc.allegro5.bind.memory;

import bindbc.allegro5.config;

struct ALLEGRO_MEMORY_INTERFACE {
	extern(C) @nogc nothrow:
	void* function(size_t n, int line, const(char)* file, const(char)* func) mi_malloc;
	void function(void* ptr, int line, const(char)* file, const(char)* func) mi_free;
	void* function(void* ptr, size_t n, int line, const(char)* file, const(char)* func) mi_realloc;
	void* function(size_t count, size_t n, int line, const(char)* file, const(char)* func) mi_calloc;
}

extern(C) @nogc nothrow {
	void* al_malloc(size_t n, int line = __LINE__, const(char)* file = __FILE__.ptr, const(char)* func = __FUNCTION__.ptr) {
		return al_malloc_with_context(n, line, file, func);
	}
	
	void al_free(void* p, int line = __LINE__, const(char)* file = __FILE__.ptr, const(char)* func = __FUNCTION__.ptr) {
		al_free_with_context(p, line, file, func);
	}
	
	void* al_realloc(void* p, size_t n, int line = __LINE__, const(char)* file = __FILE__.ptr, const(char)* func = __FUNCTION__.ptr) {
		return al_realloc_with_context(p, n, line, file, func);
	}
	
	void* al_calloc(size_t c, size_t n, int line = __LINE__, const(char)* file = __FILE__.ptr, const(char)* func = __FUNCTION__.ptr) {
		return al_calloc_with_context(c, n, line, file, func);
	}

}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	void al_set_memory_interface(ALLEGRO_MEMORY_INTERFACE* iface);
	void* al_malloc_with_context(size_t n, int line, const(char)* file, const(char)* func);
	void al_free_with_context(void* ptr, int line, const(char)* file, const(char)* func);
	void* al_realloc_with_context(void* ptr, size_t n, int line, const(char)* file, const(char)* func);
	void* al_calloc_with_context(size_t count, size_t n, int line, const(char)* file, const(char)* func);
}
else {
	extern(C) @nogc nothrow {
		alias pal_set_memory_interface = void function(ALLEGRO_MEMORY_INTERFACE* iface);
		alias pal_malloc_with_context = void* function(size_t n, int line, const(char)* file, const(char)* func);
		alias pal_free_with_context = void function(void* ptr, int line, const(char)* file, const(char)* func);
		alias pal_realloc_with_context = void* function(void* ptr, size_t n, int line, const(char)* file, const(char)* func);
		alias pal_calloc_with_context = void* function(size_t count, size_t n, int line, const(char)* file, const(char)* func);
	}
	__gshared {
		pal_set_memory_interface al_set_memory_interface;
		pal_malloc_with_context al_malloc_with_context;
		pal_free_with_context al_free_with_context;
		pal_realloc_with_context al_realloc_with_context;
		pal_calloc_with_context al_calloc_with_context;
	}
}
