module bindbc.allegro5.bind.allegro;

public {
	import bindbc.allegro5.bind.base;

	import bindbc.allegro5.bind.altime;
	import bindbc.allegro5.bind.bitmap;
	import bindbc.allegro5.bind.bitmap_draw;
	import bindbc.allegro5.bind.bitmap_io;
	import bindbc.allegro5.bind.bitmap_lock;
	import bindbc.allegro5.bind.blender;
	import bindbc.allegro5.bind.clipboard;
	import bindbc.allegro5.bind.color;
	import bindbc.allegro5.bind.config;
	import bindbc.allegro5.bind.cpu;
	import bindbc.allegro5.bind.debug_;
	import bindbc.allegro5.bind.display;
	import bindbc.allegro5.bind.drawing;
	import bindbc.allegro5.bind.error;
	import bindbc.allegro5.bind.events;
	import bindbc.allegro5.bind.file;
	import bindbc.allegro5.bind.fixed;
	import bindbc.allegro5.bind.fmaths;
	import bindbc.allegro5.bind.fshook;
	import bindbc.allegro5.bind.fullscreen_mode;
	import bindbc.allegro5.bind.haptic;
	import bindbc.allegro5.bind.joystick;
	import bindbc.allegro5.bind.keyboard;
	import bindbc.allegro5.bind.keycodes;
	import bindbc.allegro5.bind.memory;
	import bindbc.allegro5.bind.monitor;
	import bindbc.allegro5.bind.mouse;
	import bindbc.allegro5.bind.mouse_cursor;
	import bindbc.allegro5.bind.path;
	import bindbc.allegro5.bind.render_state;
	import bindbc.allegro5.bind.shader;
	import bindbc.allegro5.bind.system;
	import bindbc.allegro5.bind.threads;
	import bindbc.allegro5.bind.timer;
	import bindbc.allegro5.bind.tls;
	import bindbc.allegro5.bind.touch_input;
	import bindbc.allegro5.bind.transformations;
	import bindbc.allegro5.bind.utf8;

	version (ALLEGRO_NO_COMPATIBILITY) { }
	else {
		import bindbc.allegro5.bind.alcompat;
	}

}
