module bindbc.allegro5.bind.cpu;

import bindbc.allegro5.config;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	int al_get_cpu_count();
	int al_get_ram_size();
}
else {
	extern(C) @nogc nothrow {
		alias pal_get_cpu_count = int function();
		alias pal_get_ram_size = int function();
	}
	
	__gshared {
		pal_get_cpu_count al_get_cpu_count;
		pal_get_ram_size al_get_ram_size;
	}
}
