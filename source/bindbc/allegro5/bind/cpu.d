module bindbc.allegro5.bind.cpu;

import bindbc.allegro5.config;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	int al_get_cpu_count();
	int al_get_ram_size();
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:
	int al_get_cpu_count() => ptr_al_get_cpu_count();
	int al_get_ram_size() => ptr_al_get_ram_size();
	package(bindbc.allegro5) __gshared {
		typeof(&al_get_cpu_count) ptr_al_get_cpu_count;
		typeof(&al_get_ram_size) ptr_al_get_ram_size;
	}
}
