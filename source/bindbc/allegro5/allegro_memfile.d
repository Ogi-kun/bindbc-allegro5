module bindbc.allegro5.allegro_memfile;

import bindbc.allegro5.config;

static if (allegroMemfile):

import bindbc.allegro5.bind.file : ALLEGRO_FILE;

static if (staticBinding) {
	extern(C) @nogc nothrow:

	ALLEGRO_FILE* al_open_memfile(void* mem, long size, const(char)* mode);
	uint al_get_allegro_memfile_version();
}
else {
	extern(C) @nogc nothrow {
		alias pal_open_memfile = ALLEGRO_FILE* function(void* mem, long size, const(char)* mode);
		alias pal_get_allegro_memfile_version = uint function();
	}
	__gshared {
		pal_open_memfile al_open_memfile;
		pal_get_allegro_memfile_version al_get_allegro_memfile_version;
	}

	import bindbc.loader;

	@nogc nothrow:

	version (Allegro_Monolith) {} else { 
		
		private {
			__gshared SharedLib lib;
			__gshared AllegroSupport loadedVersion;
		}
	
		void unloadAllegroMemfile() {
			if (lib != invalidHandle) {
				lib.unload();
			}
		}
	
		AllegroSupport loadedAllegroMemfileVersion() {
			return loadedVersion; 
		}
	
		bool isAllegroMemfileLoaded() {
			return lib != invalidHandle;
		}
	
		AllegroSupport loadAllegroMemfile() {
			const(char)[][1] libNames = [
				libName!"memfile",
			];
	
			typeof(return) result;
			foreach (i; 0..libNames.length) {
				result = loadAllegroMemfile(libNames[i].ptr);
				if (result != AllegroSupport.noLibrary) {
					break;
				}
			}
			return result;
		}

		AllegroSupport loadAllegroMemfile(const(char)* libName) {
			lib = load(libName);
			if (lib == invalidHandle) {
				return AllegroSupport.noLibrary;
			}
			loadedVersion = bindAllegroMemfile(lib);
			return loadedVersion;
		}
	}

	package AllegroSupport bindAllegroMemfile(SharedLib lib) {

		auto lastErrorCount = errorCount();
		auto loadedVersion = AllegroSupport.badLibrary;

		lib.bindSymbol(cast(void**)&al_open_memfile, "al_open_memfile");
		lib.bindSymbol(cast(void**)&al_get_allegro_memfile_version, "al_get_allegro_memfile_version");

		if (errorCount() != lastErrorCount) {
			return AllegroSupport.badLibrary;
		}
		loadedVersion = AllegroSupport.v5_2_0;

		return loadedVersion;
	}
}
