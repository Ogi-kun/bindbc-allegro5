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
	pragma(inline, true) extern(C) @nogc nothrow:
	void al_set_memory_interface(ALLEGRO_MEMORY_INTERFACE* iface) => ptr_al_set_memory_interface(iface);
	void* al_malloc_with_context(size_t n, int line, const(char)* file, const(char)* func) => ptr_al_malloc_with_context(n, line, file, func);
	void al_free_with_context(void* ptr, int line, const(char)* file, const(char)* func) => ptr_al_free_with_context(ptr, line, file, func);
	void* al_realloc_with_context(void* ptr, size_t n, int line, const(char)* file, const(char)* func) => ptr_al_realloc_with_context(ptr, n, line, file, func);
	void* al_calloc_with_context(size_t count, size_t n, int line, const(char)* file, const(char)* func) => ptr_al_calloc_with_context(count, n, line, file, func);
	package(bindbc.allegro5) __gshared {
		typeof(&al_set_memory_interface) ptr_al_set_memory_interface;
		typeof(&al_malloc_with_context) ptr_al_malloc_with_context;
		typeof(&al_free_with_context) ptr_al_free_with_context;
		typeof(&al_realloc_with_context) ptr_al_realloc_with_context;
		typeof(&al_calloc_with_context) ptr_al_calloc_with_context;
	}
}
