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

version (BindBC_Static) {
	version = BindAllegro_Static;
}

version (BindAllegro_Static) {
	enum staticBinding = true;
}
else {
	enum staticBinding = false;
}

version (Allegro_5_2_8) {
	enum allegroSupport = AllegroSupport.v5_2_8;
}
else version (Allegro_5_2_7) {
	enum allegroSupport = AllegroSupport.v5_2_7;
}
else version (Allegro_5_2_6) {
	enum allegroSupport = AllegroSupport.v5_2_6;
}
else version (Allegro_5_2_5) {
	enum allegroSupport = AllegroSupport.v5_2_5;
}
else version (Allegro_5_2_4) {
	enum allegroSupport = AllegroSupport.v5_2_4;
}
else version (Allegro_5_2_3) {
	enum allegroSupport = AllegroSupport.v5_2_3;
}
else version (Allegro_5_2_2) {
	enum allegroSupport = AllegroSupport.v5_2_2;
}
else version (Allegro_5_2_1) {
	enum allegroSupport = AllegroSupport.v5_2_1;
}
else {
	enum allegroSupport = AllegroSupport.v5_2_0;
}

version (Allegro_Audio) {
	enum allegroAudio = true;
}
else {
	enum allegroAudio = false;
}

version (Allegro_ACodec) {
	enum allegroACodec = true;
}
else {
	enum allegroACodec = false;
}

version (Allegro_Color) {
	enum allegroColor = true;
}
else {
	enum allegroColor = false;
}

version (Allegro_Font) {
	enum allegroFont = true;
}
else {
	enum allegroFont = false;
}

version (Allegro_TTF) {
	enum allegroTTF = true;
}
else {
	enum allegroTTF = false;
}

version (Allegro_Image) {
	enum allegroImage = true;
}
else {
	enum allegroImage = false;
}

version (Allegro_Memfile) {
	enum allegroMemfile = true;
}
else {
	enum allegroMemfile = false;
}
