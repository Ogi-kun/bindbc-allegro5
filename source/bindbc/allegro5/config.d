module bindbc.allegro5.config;

enum Allegro5Support {
	noLibrary,
	badLibrary,
	v5_2_8 = 5_02_08
}

version (BindBC_Static) {
	version = BindAllegro5_Static;
}

version (BindAllegro5_Static) {
	enum staticBinding = true;
}
else {
	enum staticBinding = false;
}

version (Allegro_5_2_8) {
	enum allegro5Support = Allegro5Support.v5_2_8;
}
else {
	enum allegro5Support = Allegro5Support.v5_2_8;
}