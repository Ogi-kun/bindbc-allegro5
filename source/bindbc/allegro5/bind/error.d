module bindbc.allegro5.bind.error;

import bindbc.allegro5.config;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	int al_get_errno();
	void al_set_errno(int errnum);
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	int al_get_errno() => ptr_al_get_errno();
	void al_set_errno(int errnum) => ptr_al_set_errno(errnum);
	package(bindbc.allegro5) __gshared {
		typeof(&al_get_errno) ptr_al_get_errno;
		typeof(&al_set_errno) ptr_al_set_errno;
	}
}
