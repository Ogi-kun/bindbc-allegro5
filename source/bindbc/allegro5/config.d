module bindbc.allegro5.config;

enum AllegroSupport {
	noLibrary,
	badLibrary,
	v5_2_0 = 5_02_00,
	v5_2_1 = 5_02_01,
	v5_2_2 = 5_02_02,
	v5_2_3 = 5_02_03,
	v5_2_4 = 5_02_04,
	v5_2_5 = 5_02_05,
	v5_2_6 = 5_02_06,
	v5_2_7 = 5_02_07,
	v5_2_8 = 5_02_08,
}

deprecated("use AllegroSupport instead")
alias Allegro5Support = AllegroSupport;

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
	enum allegro5Support = AllegroSupport.v5_2_8;
}
else version (Allegro_5_2_7) {
	enum allegro5Support = AllegroSupport.v5_2_7;
}
else version (Allegro_5_2_6) {
	enum allegro5Support = AllegroSupport.v5_2_6;
}
else version (Allegro_5_2_5) {
	enum allegro5Support = AllegroSupport.v5_2_5;
}
else version (Allegro_5_2_4) {
	enum allegro5Support = AllegroSupport.v5_2_4;
}
else version (Allegro_5_2_3) {
	enum allegro5Support = AllegroSupport.v5_2_3;
}
else version (Allegro_5_2_2) {
	enum allegro5Support = AllegroSupport.v5_2_2;
}
else version (Allegro_5_2_1) {
	enum allegro5Support = AllegroSupport.v5_2_1;
}
else {
	enum allegro5Support = AllegroSupport.v5_2_0;
}
