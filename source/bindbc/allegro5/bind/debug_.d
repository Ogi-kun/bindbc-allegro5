module bindbc.allegro5.bind.debug_;

import bindbc.allegro5.config;

__gshared const(char)* __al_debug_channel;

extern(C) @nogc nothrow {

	void ALLEGRO_TRACE_CHANNEL_LEVEL(
			const(char)* file = __FILE__.ptr, int line = __LINE__, const(char)* fun = __FUNCTION__.ptr, T...
			)(const(char)* channel, int level, const(char)* msg, T args) {
		version (ALLEGRO_DEBUG) {
			if (_al_trace_prefix(channel, level, file, line, fun)) {
				_al_trace_suffix(msg, args);
			}
		}
	}

	void ALLEGRO_TRACE_LEVEL(
			const(char)* file = __FILE__.ptr, int line = __LINE__, const(char)* fun = __FUNCTION__.ptr, T...
			)(int level, const(char)* msg, T args) {
		ALLEGRO_TRACE_CHANNEL_LEVEL!(file, line, fun)(__al_debug_channel, level, msg, args);
	}

	void ALLEGRO_DEBUG(
			const(char)* file = __FILE__.ptr, int line = __LINE__, const(char)* fun = __FUNCTION__.ptr, T...
			)(const(char)* msg, T args) {
		ALLEGRO_TRACE_LEVEL!(file, line, fun)(0, msg, args);
	}

	void ALLEGRO_INFO(
			const(char)* file = __FILE__.ptr, int line = __LINE__, const(char)* fun = __FUNCTION__.ptr, T...
			)(const(char)* msg, T args) {
		ALLEGRO_TRACE_LEVEL!(file, line, fun)(1, msg, args);
	}

	void ALLEGRO_WARN(
			const(char)* file = __FILE__.ptr, int line = __LINE__, const(char)* fun = __FUNCTION__.ptr, T...
			)(const(char)* msg, T args) {
		ALLEGRO_TRACE_LEVEL!(file, line, fun)(2, msg, args);
	}

	void ALLEGRO_ERROR(
			const(char)* file = __FILE__.ptr, int line = __LINE__, const(char)* fun = __FUNCTION__.ptr, T...
			)(const(char)* msg, T args) {
		ALLEGRO_TRACE_LEVEL!(file, line, fun)(3, msg, args);
	}
}

version (ALLEGRO_DEBUG) {
	extern(C) void ALLEGRO_DEBUG_CHANNEL(const(char)* x) @nogc nothrow {
		__al_debug_channel = x;
	}
}
else {
	extern(C) void ALLEGRO_DEBUG_CHANNEL(const(char)* x) @nogc nothrow {}
}

alias _pal_user_assert_handler = extern(C) void function(const(char)* expr, const(char)*file, int line, const(char) *func) @nogc nothrow;
__gshared _pal_user_assert_handler _al_user_assert_handler;

void ALLEGRO_ASSERT(bool expr, const(char)* file = __FILE__.ptr, int line = __LINE__, const(char)* fun = __FUNCTION__.ptr) {
	import core.exception;
	import std.string;
	if (!expr) {
		if (_al_user_assert_handler) {
			_al_user_assert_handler("expression", file, line, fun);
		}
		else {
			_d_assert(file.fromStringz.idup, line);
		}
	}
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	bool _al_trace_prefix(const(char)* channel, int level, const(char)* file, int line, const(char)* fun);
	void _al_trace_suffix(const(char)* msg, ...);
	void al_register_assert_handler(void function(const(char)* expr, const(char)* file, int line, const(char)* func) handler);
	void al_register_trace_handler(void function(const(char)*) handler);
}
else {
	extern(C) @nogc nothrow {
		alias p_al_trace_prefix = bool function(const(char)* channel, int level, const(char)* file, int line, const(char)* fun);
		alias p_al_trace_suffix = void function(const(char)* msg, ...);
		alias pal_register_assert_handler = void function(void function(const(char)* expr, const(char)* file, int line, const(char)* func) handler);
		alias pal_register_trace_handler = void function(void function(const(char)*) handler);
	}
	__gshared {
		p_al_trace_prefix _al_trace_prefix;
		p_al_trace_suffix _al_trace_suffix;
		pal_register_assert_handler al_register_assert_handler;
		pal_register_trace_handler al_register_trace_handler;
	}
}
