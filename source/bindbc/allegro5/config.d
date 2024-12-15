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
	v5_2_9 = 5_02_09,
	v5_2_10 = 5_02_10,
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

version (Allegro_5_2_10) {
	enum allegroSupport = AllegroSupport.v5_2_10;
}
else version (Allegro_5_2_9) {
	enum allegroSupport = AllegroSupport.v5_2_9;
}
else version (Allegro_5_2_8) {
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

version (Allegro_Monolith) {
	enum allegroAudio = true;
	enum allegroACodec = true;
	enum allegroColor = true;
	enum allegroFont = true;
	enum allegroTTF = true;
	enum allegroImage = true;
	enum allegroMemfile = true;
	enum allegroDialog = true;
	enum allegroPhysFS = true;
	enum allegroPrimitives = true;
	enum allegroVideo = true;
}
else {
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

	version (Allegro_Dialog) {
		enum allegroDialog = true;
	}
	else {
		enum allegroDialog = false;
	}

	version (Allegro_PhysFS) {
		enum allegroPhysFS = true;
	}
	else {
		enum allegroPhysFS = false;
	}

	version (Allegro_Primitives) {
		enum allegroPrimitives = true;
	}
	else {
		enum allegroPrimitives = false;
	}

	version (Allegro_Video) {
		enum allegroVideo = true;
	}
	else {
		enum allegroVideo = false;
	}
}

package {
	version (Windows) {
		version (ALLEGRO_DEBUG) {
			enum libName(string addon) =
					"allegro" ~(addon != "" ? ("_" ~ addon) : "") ~"-debug-5.2.dll";
		}
		else {
			enum libName(string addon) =
					"allegro" ~(addon != "" ? ("_" ~ addon) : "") ~"-5.2.dll";
		}
	}
	else version (OSX) {
		enum libName(string addon) =
				"liballegro"~(addon != "" ? ("_" ~ addon) : "") ~".5.2.dylib";
	}
	else version (Posix) {
		enum libName(string addon) =
				"liballegro"~(addon != "" ? ("_" ~ addon) : "") ~".so.5.2";
	}
	else static assert(0, "No known library names for this platform.");
}

mixin template ExpandEnum(EnumType, string fqnEnumType = EnumType.stringof) {
	static foreach (m; __traits(allMembers, EnumType)) {
		mixin("alias " ~ m ~ " = " ~ fqnEnumType ~ "." ~ m ~ ";");
	}
}
