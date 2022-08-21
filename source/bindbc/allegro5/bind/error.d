module bindbc.allegro5.bind.error;

import bindbc.allegro5.config;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	int al_get_errno();
	void al_set_errno(int errnum);
}
else {
	extern(C) @nogc nothrow {
		alias pal_get_errno = int function();
		alias pal_set_errno = void function(int errnum);
	}
	__gshared {
		pal_get_errno al_get_errno;
		pal_set_errno al_set_errno;
	}
}
