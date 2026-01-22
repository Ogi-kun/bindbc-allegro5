module bindbc.allegro5.dynload;

import bindbc.loader;
import bindbc.allegro5.config;
import bindbc.allegro5.bind;

static if (!staticBinding):

private {
	__gshared SharedLib lib;
	__gshared AllegroSupport loadedVersion;
}

@nogc nothrow:

void unloadAllegro() {
	if (lib != invalidHandle) {
		lib.unload();
	}
}

AllegroSupport loadedAllegroVersion() {
	return loadedVersion;
}

bool isAllegroLoaded() {
	return lib != invalidHandle;
}

AllegroSupport loadAllegro()() {
	static assert(dynlibFilename!"" != "",
			"No known shared library filenames for this platform. " ~
			"Use `loadAllegro(const(char)* libName)` overload, or bind statically");
	version (Allegro_Monolith) {
		return loadAllegro(dynlibFilename!"monolith");
	}
	else {
		return loadAllegro(dynlibFilename!"");
	}
}

AllegroSupport loadAllegro(const(char)* libName) {
	lib = load(libName);
	if (lib == invalidHandle) {
		return AllegroSupport.noLibrary;
	}

	loadedVersion = bindAllegro(lib);
	return loadedVersion == allegroSupport ? allegroSupport : AllegroSupport.badLibrary;
}

private AllegroSupport bindAllegro(SharedLib lib) {
	auto lastErrorCount = errorCount();
	loadedVersion = AllegroSupport.badLibrary;

	version (Android) {
		lib.bindSymbol(cast(void**)&al_android_set_apk_file_interface, "al_android_set_apk_file_interface");
		lib.bindSymbol(cast(void**)&al_android_get_os_version, "al_android_get_os_version");
		lib.bindSymbol(cast(void**)&al_android_set_apk_fs_interface, "al_android_set_apk_fs_interface");
		lib.bindSymbol(cast(void**)&_al_android_set_capture_volume_keys, "_al_android_set_capture_volume_keys");
	}

	version (Windows) {
		lib.bindSymbol(cast(void**)&al_get_d3d_device, "al_get_d3d_device");
		lib.bindSymbol(cast(void**)&al_get_d3d_system_texture, "al_get_d3d_system_texture");
		lib.bindSymbol(cast(void**)&al_get_d3d_video_texture, "al_get_d3d_video_texture");
		lib.bindSymbol(cast(void**)&al_have_d3d_non_pow2_texture_support, "al_have_d3d_non_pow2_texture_support");
		lib.bindSymbol(cast(void**)&al_have_d3d_non_square_texture_support, "al_have_d3d_non_square_texture_support");
		lib.bindSymbol(cast(void**)&al_get_d3d_texture_position, "al_get_d3d_texture_position");
		lib.bindSymbol(cast(void**)&al_get_d3d_texture_size, "al_get_d3d_texture_size");
		lib.bindSymbol(cast(void**)&al_is_d3d_device_lost, "al_is_d3d_device_lost");
		lib.bindSymbol(cast(void**)&al_set_d3d_device_release_callback, "al_set_d3d_device_release_callback");
		lib.bindSymbol(cast(void**)&al_set_d3d_device_restore_callback, "al_set_d3d_device_restore_callback");
	}

	version (iOS) {
		lib.bindSymbol(cast(void**)&al_iphone_set_statusbar_orientation, "al_iphone_set_statusbar_orientation");
		lib.bindSymbol(cast(void**)&al_iphone_get_last_shake_time, "al_iphone_get_last_shake_time");
		lib.bindSymbol(cast(void**)&al_iphone_get_battery_level, "al_iphone_get_battery_level");

		lib.bindSymbol(cast(void**)&al_iphone_get_window, "al_iphone_get_window");
		lib.bindSymbol(cast(void**)&al_iphone_get_view, "al_iphone_get_view");
	}

	lib.bindSymbol(cast(void**)&al_get_opengl_version, "al_get_opengl_version");
	lib.bindSymbol(cast(void**)&al_have_opengl_extension, "al_have_opengl_extension");
	lib.bindSymbol(cast(void**)&al_get_opengl_proc_address, "al_get_opengl_proc_address");
	lib.bindSymbol(cast(void**)&al_get_opengl_extension_list, "al_get_opengl_extension_list");
	lib.bindSymbol(cast(void**)&al_get_opengl_texture, "al_get_opengl_texture");
	lib.bindSymbol(cast(void**)&al_remove_opengl_fbo, "al_remove_opengl_fbo");
	lib.bindSymbol(cast(void**)&al_get_opengl_fbo, "al_get_opengl_fbo");
	lib.bindSymbol(cast(void**)&al_get_opengl_texture_size, "al_get_opengl_texture_size");
	lib.bindSymbol(cast(void**)&al_get_opengl_texture_position, "al_get_opengl_texture_position");
	lib.bindSymbol(cast(void**)&al_get_opengl_program_object, "al_get_opengl_program_object");
	lib.bindSymbol(cast(void**)&al_set_current_opengl_context, "al_set_current_opengl_context");
	lib.bindSymbol(cast(void**)&al_get_opengl_variant, "al_get_opengl_variant");

	version (OSX) {
		lib.bindSymbol(cast(void**)&al_osx_get_window, "al_osx_get_window");
	}

	version (Windows) {
		lib.bindSymbol(cast(void**)&al_get_win_window_handle, "al_get_win_window_handle");
		lib.bindSymbol(cast(void**)&al_win_add_window_callback, "al_win_add_window_callback");
		lib.bindSymbol(cast(void**)&al_win_remove_window_callback, "al_win_remove_window_callback");
	}

	version (ALLEGRO_X11) {
		lib.bindSymbol(cast(void**)&al_get_x_window_id, "al_get_x_window_id");
	}

	lib.bindSymbol(cast(void**)&al_get_time, "al_get_time");
	lib.bindSymbol(cast(void**)&al_rest, "al_rest");
	lib.bindSymbol(cast(void**)&al_init_timeout, "al_init_timeout");

	lib.bindSymbol(cast(void**)&al_get_allegro_version, "al_get_allegro_version");
	lib.bindSymbol(cast(void**)&al_run_main, "al_run_main");

	lib.bindSymbol(cast(void**)&al_set_new_bitmap_format, "al_set_new_bitmap_format");
	lib.bindSymbol(cast(void**)&al_set_new_bitmap_flags, "al_set_new_bitmap_flags");
	lib.bindSymbol(cast(void**)&al_get_new_bitmap_format, "al_get_new_bitmap_format");
	lib.bindSymbol(cast(void**)&al_get_new_bitmap_flags, "al_get_new_bitmap_flags");
	lib.bindSymbol(cast(void**)&al_add_new_bitmap_flag, "al_add_new_bitmap_flag");

	lib.bindSymbol(cast(void**)&al_get_bitmap_width, "al_get_bitmap_width");
	lib.bindSymbol(cast(void**)&al_get_bitmap_height, "al_get_bitmap_height");
	lib.bindSymbol(cast(void**)&al_get_bitmap_format, "al_get_bitmap_format");
	lib.bindSymbol(cast(void**)&al_get_bitmap_flags, "al_get_bitmap_flags");

	lib.bindSymbol(cast(void**)&al_create_bitmap, "al_create_bitmap");
	lib.bindSymbol(cast(void**)&al_destroy_bitmap, "al_destroy_bitmap");

	lib.bindSymbol(cast(void**)&al_put_pixel, "al_put_pixel");
	lib.bindSymbol(cast(void**)&al_put_blended_pixel, "al_put_blended_pixel");
	lib.bindSymbol(cast(void**)&al_get_pixel, "al_get_pixel");

	lib.bindSymbol(cast(void**)&al_convert_mask_to_alpha, "al_convert_mask_to_alpha");

	lib.bindSymbol(cast(void**)&al_set_clipping_rectangle, "al_set_clipping_rectangle");
	lib.bindSymbol(cast(void**)&al_reset_clipping_rectangle, "al_reset_clipping_rectangle");
	lib.bindSymbol(cast(void**)&al_get_clipping_rectangle, "al_get_clipping_rectangle");

	lib.bindSymbol(cast(void**)&al_create_sub_bitmap, "al_create_sub_bitmap");
	lib.bindSymbol(cast(void**)&al_is_sub_bitmap, "al_is_sub_bitmap");
	lib.bindSymbol(cast(void**)&al_get_parent_bitmap, "al_get_parent_bitmap");
	lib.bindSymbol(cast(void**)&al_get_bitmap_x, "al_get_bitmap_x");
	lib.bindSymbol(cast(void**)&al_get_bitmap_y, "al_get_bitmap_y");
	lib.bindSymbol(cast(void**)&al_reparent_bitmap, "al_reparent_bitmap");

	lib.bindSymbol(cast(void**)&al_clone_bitmap, "al_clone_bitmap");
	lib.bindSymbol(cast(void**)&al_convert_bitmap, "al_convert_bitmap");
	lib.bindSymbol(cast(void**)&al_convert_memory_bitmaps, "al_convert_memory_bitmaps");

	lib.bindSymbol(cast(void**)&al_draw_bitmap, "al_draw_bitmap");
	lib.bindSymbol(cast(void**)&al_draw_bitmap_region, "al_draw_bitmap_region");
	lib.bindSymbol(cast(void**)&al_draw_scaled_bitmap, "al_draw_scaled_bitmap");
	lib.bindSymbol(cast(void**)&al_draw_rotated_bitmap, "al_draw_rotated_bitmap");
	lib.bindSymbol(cast(void**)&al_draw_scaled_rotated_bitmap, "al_draw_scaled_rotated_bitmap");

	lib.bindSymbol(cast(void**)&al_draw_tinted_bitmap, "al_draw_tinted_bitmap");
	lib.bindSymbol(cast(void**)&al_draw_tinted_bitmap_region, "al_draw_tinted_bitmap_region");
	lib.bindSymbol(cast(void**)&al_draw_tinted_scaled_bitmap, "al_draw_tinted_scaled_bitmap");
	lib.bindSymbol(cast(void**)&al_draw_tinted_rotated_bitmap, "al_draw_tinted_rotated_bitmap");
	lib.bindSymbol(cast(void**)&al_draw_tinted_scaled_rotated_bitmap, "al_draw_tinted_scaled_rotated_bitmap");
	lib.bindSymbol(cast(void**)&al_draw_tinted_scaled_rotated_bitmap_region, "al_draw_tinted_scaled_rotated_bitmap_region");

	lib.bindSymbol(cast(void**)&al_register_bitmap_loader, "al_register_bitmap_loader");
	lib.bindSymbol(cast(void**)&al_register_bitmap_saver, "al_register_bitmap_saver");
	lib.bindSymbol(cast(void**)&al_register_bitmap_loader_f, "al_register_bitmap_loader_f");
	lib.bindSymbol(cast(void**)&al_register_bitmap_saver_f, "al_register_bitmap_saver_f");
	lib.bindSymbol(cast(void**)&al_register_bitmap_identifier, "al_register_bitmap_identifier");
	lib.bindSymbol(cast(void**)&al_load_bitmap, "al_load_bitmap");
	lib.bindSymbol(cast(void**)&al_load_bitmap_flags, "al_load_bitmap_flags");
	lib.bindSymbol(cast(void**)&al_load_bitmap_f, "al_load_bitmap_f");
	lib.bindSymbol(cast(void**)&al_load_bitmap_flags_f, "al_load_bitmap_flags_f");
	lib.bindSymbol(cast(void**)&al_save_bitmap, "al_save_bitmap");
	lib.bindSymbol(cast(void**)&al_save_bitmap_f, "al_save_bitmap_f");
	lib.bindSymbol(cast(void**)&al_identify_bitmap_f, "al_identify_bitmap_f");
	lib.bindSymbol(cast(void**)&al_identify_bitmap, "al_identify_bitmap");

	lib.bindSymbol(cast(void**)&al_lock_bitmap, "al_lock_bitmap");
	lib.bindSymbol(cast(void**)&al_lock_bitmap_region, "al_lock_bitmap_region");
	lib.bindSymbol(cast(void**)&al_lock_bitmap_blocked, "al_lock_bitmap_blocked");
	lib.bindSymbol(cast(void**)&al_lock_bitmap_region_blocked, "al_lock_bitmap_region_blocked");
	lib.bindSymbol(cast(void**)&al_unlock_bitmap, "al_unlock_bitmap");
	lib.bindSymbol(cast(void**)&al_is_bitmap_locked, "al_is_bitmap_locked");

	lib.bindSymbol(cast(void**)&al_set_blender, "al_set_blender");
	lib.bindSymbol(cast(void**)&al_set_blend_color, "al_set_blend_color");
	lib.bindSymbol(cast(void**)&al_get_blender, "al_get_blender");
	lib.bindSymbol(cast(void**)&al_get_blend_color, "al_get_blend_color");
	lib.bindSymbol(cast(void**)&al_set_separate_blender, "al_set_separate_blender");
	lib.bindSymbol(cast(void**)&al_get_separate_blender, "al_get_separate_blender");

	lib.bindSymbol(cast(void**)&al_get_clipboard_text, "al_get_clipboard_text");
	lib.bindSymbol(cast(void**)&al_set_clipboard_text, "al_set_clipboard_text");
	lib.bindSymbol(cast(void**)&al_clipboard_has_text, "al_clipboard_has_text");

	lib.bindSymbol(cast(void**)&al_map_rgb, "al_map_rgb");
	lib.bindSymbol(cast(void**)&al_map_rgba, "al_map_rgba");
	lib.bindSymbol(cast(void**)&al_map_rgb_f, "al_map_rgb_f");
	lib.bindSymbol(cast(void**)&al_map_rgba_f, "al_map_rgba_f");
	lib.bindSymbol(cast(void**)&al_premul_rgba, "al_premul_rgba");
	lib.bindSymbol(cast(void**)&al_premul_rgba_f, "al_premul_rgba_f");

	lib.bindSymbol(cast(void**)&al_unmap_rgb, "al_unmap_rgb");
	lib.bindSymbol(cast(void**)&al_unmap_rgba, "al_unmap_rgba");
	lib.bindSymbol(cast(void**)&al_unmap_rgb_f, "al_unmap_rgb_f");
	lib.bindSymbol(cast(void**)&al_unmap_rgba_f, "al_unmap_rgba_f");

	lib.bindSymbol(cast(void**)&al_get_pixel_size, "al_get_pixel_size");
	lib.bindSymbol(cast(void**)&al_get_pixel_format_bits, "al_get_pixel_format_bits");
	lib.bindSymbol(cast(void**)&al_get_pixel_block_size, "al_get_pixel_block_size");
	lib.bindSymbol(cast(void**)&al_get_pixel_block_width, "al_get_pixel_block_width");
	lib.bindSymbol(cast(void**)&al_get_pixel_block_height, "al_get_pixel_block_height");

	lib.bindSymbol(cast(void**)&al_create_config, "al_create_config");
	lib.bindSymbol(cast(void**)&al_add_config_section, "al_add_config_section");
	lib.bindSymbol(cast(void**)&al_set_config_value, "al_set_config_value");
	lib.bindSymbol(cast(void**)&al_add_config_comment, "al_add_config_comment");
	lib.bindSymbol(cast(void**)&al_get_config_value, "al_get_config_value");
	lib.bindSymbol(cast(void**)&al_load_config_file, "al_load_config_file");
	lib.bindSymbol(cast(void**)&al_load_config_file_f, "al_load_config_file_f");
	lib.bindSymbol(cast(void**)&al_save_config_file, "al_save_config_file");
	lib.bindSymbol(cast(void**)&al_save_config_file_f, "al_save_config_file_f");
	lib.bindSymbol(cast(void**)&al_merge_config_into, "al_merge_config_into");
	lib.bindSymbol(cast(void**)&al_merge_config, "al_merge_config");
	lib.bindSymbol(cast(void**)&al_destroy_config, "al_destroy_config");
	lib.bindSymbol(cast(void**)&al_remove_config_section, "al_remove_config_section");
	lib.bindSymbol(cast(void**)&al_remove_config_key, "al_remove_config_key");

	lib.bindSymbol(cast(void**)&al_get_first_config_section, "al_get_first_config_section");
	lib.bindSymbol(cast(void**)&al_get_next_config_section, "al_get_next_config_section");
	lib.bindSymbol(cast(void**)&al_get_first_config_entry, "al_get_first_config_entry");
	lib.bindSymbol(cast(void**)&al_get_next_config_entry, "al_get_next_config_entry");

	lib.bindSymbol(cast(void**)&al_get_cpu_count, "al_get_cpu_count");
	lib.bindSymbol(cast(void**)&al_get_ram_size, "al_get_ram_size");

	lib.bindSymbol(cast(void**)&_al_trace_prefix, "_al_trace_prefix");
	lib.bindSymbol(cast(void**)&_al_trace_suffix, "_al_trace_suffix");
	lib.bindSymbol(cast(void**)&al_register_assert_handler, "al_register_assert_handler");
	lib.bindSymbol(cast(void**)&al_register_trace_handler, "al_register_trace_handler");

	lib.bindSymbol(cast(void**)&al_set_new_display_refresh_rate, "al_set_new_display_refresh_rate");
	lib.bindSymbol(cast(void**)&al_set_new_display_flags, "al_set_new_display_flags");
	lib.bindSymbol(cast(void**)&al_get_new_display_refresh_rate, "al_get_new_display_refresh_rate");
	lib.bindSymbol(cast(void**)&al_get_new_display_flags, "al_get_new_display_flags");

	lib.bindSymbol(cast(void**)&al_set_new_window_title, "al_set_new_window_title");
	lib.bindSymbol(cast(void**)&al_get_new_window_title, "al_get_new_window_title");

	lib.bindSymbol(cast(void**)&al_get_display_width, "al_get_display_width");
	lib.bindSymbol(cast(void**)&al_get_display_height, "al_get_display_height");
	lib.bindSymbol(cast(void**)&al_get_display_format, "al_get_display_format");
	lib.bindSymbol(cast(void**)&al_get_display_refresh_rate, "al_get_display_refresh_rate");
	lib.bindSymbol(cast(void**)&al_get_display_flags, "al_get_display_flags");
	lib.bindSymbol(cast(void**)&al_get_display_orientation, "al_get_display_orientation");
	lib.bindSymbol(cast(void**)&al_set_display_flag, "al_set_display_flag");

	lib.bindSymbol(cast(void**)&al_create_display, "al_create_display");
	lib.bindSymbol(cast(void**)&al_destroy_display, "al_destroy_display");
	lib.bindSymbol(cast(void**)&al_get_current_display, "al_get_current_display");
	lib.bindSymbol(cast(void**)&al_set_target_bitmap, "al_set_target_bitmap");
	lib.bindSymbol(cast(void**)&al_set_target_backbuffer, "al_set_target_backbuffer");
	lib.bindSymbol(cast(void**)&al_get_backbuffer, "al_get_backbuffer");
	lib.bindSymbol(cast(void**)&al_get_target_bitmap, "al_get_target_bitmap");

	lib.bindSymbol(cast(void**)&al_acknowledge_resize, "al_acknowledge_resize");
	lib.bindSymbol(cast(void**)&al_resize_display, "al_resize_display");
	lib.bindSymbol(cast(void**)&al_flip_display, "al_flip_display");
	lib.bindSymbol(cast(void**)&al_update_display_region, "al_update_display_region");
	lib.bindSymbol(cast(void**)&al_is_compatible_bitmap, "al_is_compatible_bitmap");

	lib.bindSymbol(cast(void**)&al_wait_for_vsync, "al_wait_for_vsync");

	lib.bindSymbol(cast(void**)&al_get_display_event_source, "al_get_display_event_source");

	lib.bindSymbol(cast(void**)&al_set_display_icon, "al_set_display_icon");
	lib.bindSymbol(cast(void**)&al_set_display_icons, "al_set_display_icons");

	lib.bindSymbol(cast(void**)&al_get_new_display_adapter, "al_get_new_display_adapter");
	lib.bindSymbol(cast(void**)&al_set_new_display_adapter, "al_set_new_display_adapter");
	lib.bindSymbol(cast(void**)&al_set_new_window_position, "al_set_new_window_position");
	lib.bindSymbol(cast(void**)&al_get_new_window_position, "al_get_new_window_position");
	lib.bindSymbol(cast(void**)&al_set_window_position, "al_set_window_position");
	lib.bindSymbol(cast(void**)&al_get_window_position, "al_get_window_position");
	lib.bindSymbol(cast(void**)&al_set_window_constraints, "al_set_window_constraints");
	lib.bindSymbol(cast(void**)&al_get_window_constraints, "al_get_window_constraints");
	lib.bindSymbol(cast(void**)&al_apply_window_constraints, "al_apply_window_constraints");

	lib.bindSymbol(cast(void**)&al_set_window_title, "al_set_window_title");

	lib.bindSymbol(cast(void**)&al_set_new_display_option, "al_set_new_display_option");
	lib.bindSymbol(cast(void**)&al_get_new_display_option, "al_get_new_display_option");
	lib.bindSymbol(cast(void**)&al_reset_new_display_options, "al_reset_new_display_options");
	lib.bindSymbol(cast(void**)&al_set_display_option, "al_set_display_option");
	lib.bindSymbol(cast(void**)&al_get_display_option, "al_get_display_option");

	lib.bindSymbol(cast(void**)&al_hold_bitmap_drawing, "al_hold_bitmap_drawing");
	lib.bindSymbol(cast(void**)&al_is_bitmap_drawing_held, "al_is_bitmap_drawing_held");

	lib.bindSymbol(cast(void**)&al_acknowledge_drawing_halt, "al_acknowledge_drawing_halt");
	lib.bindSymbol(cast(void**)&al_acknowledge_drawing_resume, "al_acknowledge_drawing_resume");

	lib.bindSymbol(cast(void**)&al_clear_to_color, "al_clear_to_color");
	lib.bindSymbol(cast(void**)&al_clear_depth_buffer, "al_clear_depth_buffer");
	lib.bindSymbol(cast(void**)&al_draw_pixel, "al_draw_pixel");

	lib.bindSymbol(cast(void**)&al_get_errno, "al_get_errno");
	lib.bindSymbol(cast(void**)&al_set_errno, "al_set_errno");

	lib.bindSymbol(cast(void**)&al_init_user_event_source, "al_init_user_event_source");
	lib.bindSymbol(cast(void**)&al_destroy_user_event_source, "al_destroy_user_event_source");
	lib.bindSymbol(cast(void**)&al_emit_user_event, "al_emit_user_event");
	lib.bindSymbol(cast(void**)&al_unref_user_event, "al_unref_user_event");
	lib.bindSymbol(cast(void**)&al_set_event_source_data, "al_set_event_source_data");
	lib.bindSymbol(cast(void**)&al_get_event_source_data, "al_get_event_source_data");

	lib.bindSymbol(cast(void**)&al_create_event_queue, "al_create_event_queue");
	lib.bindSymbol(cast(void**)&al_destroy_event_queue, "al_destroy_event_queue");
	lib.bindSymbol(cast(void**)&al_is_event_source_registered, "al_is_event_source_registered");
	lib.bindSymbol(cast(void**)&al_register_event_source, "al_register_event_source");
	lib.bindSymbol(cast(void**)&al_unregister_event_source, "al_unregister_event_source");
	lib.bindSymbol(cast(void**)&al_pause_event_queue, "al_pause_event_queue");
	lib.bindSymbol(cast(void**)&al_is_event_queue_paused, "al_is_event_queue_paused");
	lib.bindSymbol(cast(void**)&al_is_event_queue_empty, "al_is_event_queue_empty");
	lib.bindSymbol(cast(void**)&al_get_next_event, "al_get_next_event");
	lib.bindSymbol(cast(void**)&al_peek_next_event, "al_peek_next_event");
	lib.bindSymbol(cast(void**)&al_drop_next_event, "al_drop_next_event");
	lib.bindSymbol(cast(void**)&al_flush_event_queue, "al_flush_event_queue");
	lib.bindSymbol(cast(void**)&al_wait_for_event, "al_wait_for_event");
	lib.bindSymbol(cast(void**)&al_wait_for_event_timed, "al_wait_for_event_timed");
	lib.bindSymbol(cast(void**)&al_wait_for_event_until, "al_wait_for_event_until");

	lib.bindSymbol(cast(void**)&al_fopen, "al_fopen");
	lib.bindSymbol(cast(void**)&al_fopen_interface, "al_fopen_interface");
	lib.bindSymbol(cast(void**)&al_create_file_handle, "al_create_file_handle");
	lib.bindSymbol(cast(void**)&al_fclose, "al_fclose");
	lib.bindSymbol(cast(void**)&al_fread, "al_fread");
	lib.bindSymbol(cast(void**)&al_fwrite, "al_fwrite");
	lib.bindSymbol(cast(void**)&al_fflush, "al_fflush");
	lib.bindSymbol(cast(void**)&al_ftell, "al_ftell");
	lib.bindSymbol(cast(void**)&al_fseek, "al_fseek");
	lib.bindSymbol(cast(void**)&al_feof, "al_feof");
	lib.bindSymbol(cast(void**)&al_ferror, "al_ferror");
	lib.bindSymbol(cast(void**)&al_ferrmsg, "al_ferrmsg");
	lib.bindSymbol(cast(void**)&al_fclearerr, "al_fclearerr");
	lib.bindSymbol(cast(void**)&al_fungetc, "al_fungetc");
	lib.bindSymbol(cast(void**)&al_fsize, "al_fsize");

	lib.bindSymbol(cast(void**)&al_fgetc, "al_fgetc");
	lib.bindSymbol(cast(void**)&al_fputc, "al_fputc");
	lib.bindSymbol(cast(void**)&al_fread16le, "al_fread16le");
	lib.bindSymbol(cast(void**)&al_fread16be, "al_fread16be");
	lib.bindSymbol(cast(void**)&al_fwrite16le, "al_fwrite16le");
	lib.bindSymbol(cast(void**)&al_fwrite16be, "al_fwrite16be");
	lib.bindSymbol(cast(void**)&al_fread32le, "al_fread32le");
	lib.bindSymbol(cast(void**)&al_fread32be, "al_fread32be");
	lib.bindSymbol(cast(void**)&al_fwrite32le, "al_fwrite32le");
	lib.bindSymbol(cast(void**)&al_fwrite32be, "al_fwrite32be");
	lib.bindSymbol(cast(void**)&al_fgets, "al_fgets");
	lib.bindSymbol(cast(void**)&al_fget_ustr, "al_fget_ustr");
	lib.bindSymbol(cast(void**)&al_fputs, "al_fputs");
	lib.bindSymbol(cast(void**)&al_fprintf, "al_fprintf");
	lib.bindSymbol(cast(void**)&al_vfprintf, "al_vfprintf");

	lib.bindSymbol(cast(void**)&al_fopen_fd, "al_fopen_fd");
	lib.bindSymbol(cast(void**)&al_make_temp_file, "al_make_temp_file");

	lib.bindSymbol(cast(void**)&al_fopen_slice, "al_fopen_slice");

	lib.bindSymbol(cast(void**)&al_get_new_file_interface, "al_get_new_file_interface");
	lib.bindSymbol(cast(void**)&al_set_new_file_interface, "al_set_new_file_interface");
	lib.bindSymbol(cast(void**)&al_set_standard_file_interface, "al_set_standard_file_interface");

	lib.bindSymbol(cast(void**)&al_get_file_userdata, "al_get_file_userdata");

	lib.bindSymbol(cast(void**)&al_fixsqrt, "al_fixsqrt");
	lib.bindSymbol(cast(void**)&al_fixhypot, "al_fixhypot");
	lib.bindSymbol(cast(void**)&al_fixatan, "al_fixatan");
	lib.bindSymbol(cast(void**)&al_fixatan2, "al_fixatan2");

	lib.bindSymbol(cast(void**)&al_create_fs_entry, "al_create_fs_entry");
	lib.bindSymbol(cast(void**)&al_destroy_fs_entry, "al_destroy_fs_entry");
	lib.bindSymbol(cast(void**)&al_get_fs_entry_name, "al_get_fs_entry_name");
	lib.bindSymbol(cast(void**)&al_update_fs_entry, "al_update_fs_entry");
	lib.bindSymbol(cast(void**)&al_get_fs_entry_mode, "al_get_fs_entry_mode");
	lib.bindSymbol(cast(void**)&al_get_fs_entry_atime, "al_get_fs_entry_atime");
	lib.bindSymbol(cast(void**)&al_get_fs_entry_mtime, "al_get_fs_entry_mtime");
	lib.bindSymbol(cast(void**)&al_get_fs_entry_ctime, "al_get_fs_entry_ctime");
	lib.bindSymbol(cast(void**)&al_get_fs_entry_size, "al_get_fs_entry_size");
	lib.bindSymbol(cast(void**)&al_fs_entry_exists, "al_fs_entry_exists");
	lib.bindSymbol(cast(void**)&al_remove_fs_entry, "al_remove_fs_entry");

	lib.bindSymbol(cast(void**)&al_open_directory, "al_open_directory");
	lib.bindSymbol(cast(void**)&al_read_directory, "al_read_directory");
	lib.bindSymbol(cast(void**)&al_close_directory, "al_close_directory");

	lib.bindSymbol(cast(void**)&al_filename_exists, "al_filename_exists");
	lib.bindSymbol(cast(void**)&al_remove_filename, "al_remove_filename");
	lib.bindSymbol(cast(void**)&al_get_current_directory, "al_get_current_directory");
	lib.bindSymbol(cast(void**)&al_change_directory, "al_change_directory");
	lib.bindSymbol(cast(void**)&al_make_directory, "al_make_directory");

	lib.bindSymbol(cast(void**)&al_open_fs_entry, "al_open_fs_entry");

	lib.bindSymbol(cast(void**)&al_for_each_fs_entry, "al_for_each_fs_entry");

	lib.bindSymbol(cast(void**)&al_get_fs_interface, "al_get_fs_interface");
	lib.bindSymbol(cast(void**)&al_set_fs_interface, "al_set_fs_interface");
	lib.bindSymbol(cast(void**)&al_set_standard_fs_interface, "al_set_standard_fs_interface");

	lib.bindSymbol(cast(void**)&al_get_num_display_modes, "al_get_num_display_modes");
	lib.bindSymbol(cast(void**)&al_get_display_mode, "al_get_display_mode");

	lib.bindSymbol(cast(void**)&al_install_joystick, "al_install_joystick");
	lib.bindSymbol(cast(void**)&al_uninstall_joystick, "al_uninstall_joystick");
	lib.bindSymbol(cast(void**)&al_is_joystick_installed, "al_is_joystick_installed");
	lib.bindSymbol(cast(void**)&al_reconfigure_joysticks, "al_reconfigure_joysticks");

	lib.bindSymbol(cast(void**)&al_get_num_joysticks, "al_get_num_joysticks");
	lib.bindSymbol(cast(void**)&al_get_joystick, "al_get_joystick");
	lib.bindSymbol(cast(void**)&al_release_joystick, "al_release_joystick");
	lib.bindSymbol(cast(void**)&al_get_joystick_active, "al_get_joystick_active");
	lib.bindSymbol(cast(void**)&al_get_joystick_name, "al_get_joystick_name");

	lib.bindSymbol(cast(void**)&al_get_joystick_num_sticks, "al_get_joystick_num_sticks");
	lib.bindSymbol(cast(void**)&al_get_joystick_stick_flags, "al_get_joystick_stick_flags");
	lib.bindSymbol(cast(void**)&al_get_joystick_stick_name, "al_get_joystick_stick_name");

	lib.bindSymbol(cast(void**)&al_get_joystick_num_axes, "al_get_joystick_num_axes");
	lib.bindSymbol(cast(void**)&al_get_joystick_axis_name, "al_get_joystick_axis_name");

	lib.bindSymbol(cast(void**)&al_get_joystick_num_buttons, "al_get_joystick_num_buttons");
	lib.bindSymbol(cast(void**)&al_get_joystick_button_name, "al_get_joystick_button_name");

	lib.bindSymbol(cast(void**)&al_get_joystick_state, "al_get_joystick_state");

	lib.bindSymbol(cast(void**)&al_get_joystick_event_source, "al_get_joystick_event_source");

	lib.bindSymbol(cast(void**)&al_is_keyboard_installed, "al_is_keyboard_installed");
	lib.bindSymbol(cast(void**)&al_install_keyboard, "al_install_keyboard");
	lib.bindSymbol(cast(void**)&al_uninstall_keyboard, "al_uninstall_keyboard");
	lib.bindSymbol(cast(void**)&al_set_keyboard_leds, "al_set_keyboard_leds");
	lib.bindSymbol(cast(void**)&al_keycode_to_name, "al_keycode_to_name");
	lib.bindSymbol(cast(void**)&al_get_keyboard_state, "al_get_keyboard_state");
	lib.bindSymbol(cast(void**)&al_key_down, "al_key_down");
	lib.bindSymbol(cast(void**)&al_get_keyboard_event_source, "al_get_keyboard_event_source");

	lib.bindSymbol(cast(void**)&al_set_memory_interface, "al_set_memory_interface");
	lib.bindSymbol(cast(void**)&al_malloc_with_context, "al_malloc_with_context");
	lib.bindSymbol(cast(void**)&al_free_with_context, "al_free_with_context");
	lib.bindSymbol(cast(void**)&al_realloc_with_context, "al_realloc_with_context");
	lib.bindSymbol(cast(void**)&al_calloc_with_context, "al_calloc_with_context");

	lib.bindSymbol(cast(void**)&al_get_num_video_adapters, "al_get_num_video_adapters");
	lib.bindSymbol(cast(void**)&al_get_monitor_info, "al_get_monitor_info");

	lib.bindSymbol(cast(void**)&al_is_mouse_installed, "al_is_mouse_installed");
	lib.bindSymbol(cast(void**)&al_install_mouse, "al_install_mouse");
	lib.bindSymbol(cast(void**)&al_uninstall_mouse, "al_uninstall_mouse");
	lib.bindSymbol(cast(void**)&al_get_mouse_num_buttons, "al_get_mouse_num_buttons");
	lib.bindSymbol(cast(void**)&al_get_mouse_num_axes, "al_get_mouse_num_axes");
	lib.bindSymbol(cast(void**)&al_set_mouse_xy, "al_set_mouse_xy");
	lib.bindSymbol(cast(void**)&al_set_mouse_z, "al_set_mouse_z");
	lib.bindSymbol(cast(void**)&al_set_mouse_w, "al_set_mouse_w");
	lib.bindSymbol(cast(void**)&al_set_mouse_axis, "al_set_mouse_axis");
	lib.bindSymbol(cast(void**)&al_get_mouse_state, "al_get_mouse_state");
	lib.bindSymbol(cast(void**)&al_mouse_button_down, "al_mouse_button_down");
	lib.bindSymbol(cast(void**)&al_get_mouse_state_axis, "al_get_mouse_state_axis");
	lib.bindSymbol(cast(void**)&al_get_mouse_cursor_position, "al_get_mouse_cursor_position");
	lib.bindSymbol(cast(void**)&al_grab_mouse, "al_grab_mouse");
	lib.bindSymbol(cast(void**)&al_ungrab_mouse, "al_ungrab_mouse");
	lib.bindSymbol(cast(void**)&al_set_mouse_wheel_precision, "al_set_mouse_wheel_precision");
	lib.bindSymbol(cast(void**)&al_get_mouse_wheel_precision, "al_get_mouse_wheel_precision");
	lib.bindSymbol(cast(void**)&al_get_mouse_event_source, "al_get_mouse_event_source");

	lib.bindSymbol(cast(void**)&al_create_mouse_cursor, "al_create_mouse_cursor");
	lib.bindSymbol(cast(void**)&al_destroy_mouse_cursor, "al_destroy_mouse_cursor");
	lib.bindSymbol(cast(void**)&al_set_mouse_cursor, "al_set_mouse_cursor");
	lib.bindSymbol(cast(void**)&al_set_system_mouse_cursor, "al_set_system_mouse_cursor");
	lib.bindSymbol(cast(void**)&al_show_mouse_cursor, "al_show_mouse_cursor");
	lib.bindSymbol(cast(void**)&al_hide_mouse_cursor, "al_hide_mouse_cursor");

	lib.bindSymbol(cast(void**)&al_create_path, "al_create_path");
	lib.bindSymbol(cast(void**)&al_create_path_for_directory, "al_create_path_for_directory");
	lib.bindSymbol(cast(void**)&al_clone_path, "al_clone_path");

	lib.bindSymbol(cast(void**)&al_get_path_num_components, "al_get_path_num_components");
	lib.bindSymbol(cast(void**)&al_get_path_component, "al_get_path_component");
	lib.bindSymbol(cast(void**)&al_replace_path_component, "al_replace_path_component");
	lib.bindSymbol(cast(void**)&al_remove_path_component, "al_remove_path_component");
	lib.bindSymbol(cast(void**)&al_insert_path_component, "al_insert_path_component");
	lib.bindSymbol(cast(void**)&al_get_path_tail, "al_get_path_tail");
	lib.bindSymbol(cast(void**)&al_drop_path_tail, "al_drop_path_tail");
	lib.bindSymbol(cast(void**)&al_append_path_component, "al_append_path_component");
	lib.bindSymbol(cast(void**)&al_join_paths, "al_join_paths");
	lib.bindSymbol(cast(void**)&al_rebase_path, "al_rebase_path");
	lib.bindSymbol(cast(void**)&al_path_cstr, "al_path_cstr");
	lib.bindSymbol(cast(void**)&al_destroy_path, "al_destroy_path");

	lib.bindSymbol(cast(void**)&al_set_path_drive, "al_set_path_drive");
	lib.bindSymbol(cast(void**)&al_get_path_drive, "al_get_path_drive");

	lib.bindSymbol(cast(void**)&al_set_path_filename, "al_set_path_filename");
	lib.bindSymbol(cast(void**)&al_get_path_filename, "al_get_path_filename");

	lib.bindSymbol(cast(void**)&al_get_path_extension, "al_get_path_extension");
	lib.bindSymbol(cast(void**)&al_set_path_extension, "al_set_path_extension");
	lib.bindSymbol(cast(void**)&al_get_path_basename, "al_get_path_basename");

	lib.bindSymbol(cast(void**)&al_make_path_canonical, "al_make_path_canonical");

	lib.bindSymbol(cast(void**)&al_set_render_state, "al_set_render_state");

	lib.bindSymbol(cast(void**)&al_create_shader, "al_create_shader");
	lib.bindSymbol(cast(void**)&al_attach_shader_source, "al_attach_shader_source");
	lib.bindSymbol(cast(void**)&al_attach_shader_source_file, "al_attach_shader_source_file");
	lib.bindSymbol(cast(void**)&al_build_shader, "al_build_shader");
	lib.bindSymbol(cast(void**)&al_get_shader_log, "al_get_shader_log");
	lib.bindSymbol(cast(void**)&al_get_shader_platform, "al_get_shader_platform");
	lib.bindSymbol(cast(void**)&al_use_shader, "al_use_shader");
	lib.bindSymbol(cast(void**)&al_destroy_shader, "al_destroy_shader");

	lib.bindSymbol(cast(void**)&al_set_shader_sampler, "al_set_shader_sampler");
	lib.bindSymbol(cast(void**)&al_set_shader_matrix, "al_set_shader_matrix");
	lib.bindSymbol(cast(void**)&al_set_shader_int, "al_set_shader_int");
	lib.bindSymbol(cast(void**)&al_set_shader_float, "al_set_shader_float");
	lib.bindSymbol(cast(void**)&al_set_shader_int_vector, "al_set_shader_int_vector");
	lib.bindSymbol(cast(void**)&al_set_shader_float_vector, "al_set_shader_float_vector");
	lib.bindSymbol(cast(void**)&al_set_shader_bool, "al_set_shader_bool");

	lib.bindSymbol(cast(void**)&al_get_default_shader_source, "al_get_default_shader_source");

	lib.bindSymbol(cast(void**)&al_install_system, "al_install_system");
	lib.bindSymbol(cast(void**)&al_uninstall_system, "al_uninstall_system");
	lib.bindSymbol(cast(void**)&al_is_system_installed, "al_is_system_installed");
	lib.bindSymbol(cast(void**)&al_get_system_driver, "al_get_system_driver");
	lib.bindSymbol(cast(void**)&al_get_system_config, "al_get_system_config");

	lib.bindSymbol(cast(void**)&al_get_standard_path, "al_get_standard_path");
	lib.bindSymbol(cast(void**)&al_set_exe_name, "al_set_exe_name");

	lib.bindSymbol(cast(void**)&al_set_org_name, "al_set_org_name");
	lib.bindSymbol(cast(void**)&al_set_app_name, "al_set_app_name");
	lib.bindSymbol(cast(void**)&al_get_org_name, "al_get_org_name");
	lib.bindSymbol(cast(void**)&al_get_app_name, "al_get_app_name");

	lib.bindSymbol(cast(void**)&al_inhibit_screensaver, "al_inhibit_screensaver");

	lib.bindSymbol(cast(void**)&al_create_thread, "al_create_thread");

	lib.bindSymbol(cast(void**)&al_start_thread, "al_start_thread");
	lib.bindSymbol(cast(void**)&al_join_thread, "al_join_thread");
	lib.bindSymbol(cast(void**)&al_set_thread_should_stop, "al_set_thread_should_stop");
	lib.bindSymbol(cast(void**)&al_get_thread_should_stop, "al_get_thread_should_stop");
	lib.bindSymbol(cast(void**)&al_destroy_thread, "al_destroy_thread");
	lib.bindSymbol(cast(void**)&al_run_detached_thread, "al_run_detached_thread");

	lib.bindSymbol(cast(void**)&al_create_mutex, "al_create_mutex");
	lib.bindSymbol(cast(void**)&al_create_mutex_recursive, "al_create_mutex_recursive");
	lib.bindSymbol(cast(void**)&al_lock_mutex, "al_lock_mutex");
	lib.bindSymbol(cast(void**)&al_unlock_mutex, "al_unlock_mutex");
	lib.bindSymbol(cast(void**)&al_destroy_mutex, "al_destroy_mutex");

	lib.bindSymbol(cast(void**)&al_create_cond, "al_create_cond");
	lib.bindSymbol(cast(void**)&al_destroy_cond, "al_destroy_cond");
	lib.bindSymbol(cast(void**)&al_wait_cond, "al_wait_cond");
	lib.bindSymbol(cast(void**)&al_wait_cond_until, "al_wait_cond_until");
	lib.bindSymbol(cast(void**)&al_broadcast_cond, "al_broadcast_cond");
	lib.bindSymbol(cast(void**)&al_signal_cond, "al_signal_cond");

	lib.bindSymbol(cast(void**)&al_create_timer, "al_create_timer");
	lib.bindSymbol(cast(void**)&al_destroy_timer, "al_destroy_timer");
	lib.bindSymbol(cast(void**)&al_start_timer, "al_start_timer");
	lib.bindSymbol(cast(void**)&al_stop_timer, "al_stop_timer");
	lib.bindSymbol(cast(void**)&al_resume_timer, "al_resume_timer");
	lib.bindSymbol(cast(void**)&al_get_timer_started, "al_get_timer_started");
	lib.bindSymbol(cast(void**)&al_get_timer_speed, "al_get_timer_speed");
	lib.bindSymbol(cast(void**)&al_set_timer_speed, "al_set_timer_speed");
	lib.bindSymbol(cast(void**)&al_get_timer_count, "al_get_timer_count");
	lib.bindSymbol(cast(void**)&al_set_timer_count, "al_set_timer_count");
	lib.bindSymbol(cast(void**)&al_add_timer_count, "al_add_timer_count");
	lib.bindSymbol(cast(void**)&al_get_timer_event_source, "al_get_timer_event_source");

	lib.bindSymbol(cast(void**)&al_store_state, "al_store_state");
	lib.bindSymbol(cast(void**)&al_restore_state, "al_restore_state");

	lib.bindSymbol(cast(void**)&al_is_touch_input_installed, "al_is_touch_input_installed");
	lib.bindSymbol(cast(void**)&al_install_touch_input, "al_install_touch_input");
	lib.bindSymbol(cast(void**)&al_uninstall_touch_input, "al_uninstall_touch_input");
	lib.bindSymbol(cast(void**)&al_get_touch_input_state, "al_get_touch_input_state");
	lib.bindSymbol(cast(void**)&al_get_touch_input_event_source, "al_get_touch_input_event_source");

	lib.bindSymbol(cast(void**)&al_use_transform, "al_use_transform");
	lib.bindSymbol(cast(void**)&al_use_projection_transform, "al_use_projection_transform");
	lib.bindSymbol(cast(void**)&al_copy_transform, "al_copy_transform");
	lib.bindSymbol(cast(void**)&al_identity_transform, "al_identity_transform");
	lib.bindSymbol(cast(void**)&al_build_transform, "al_build_transform");
	lib.bindSymbol(cast(void**)&al_build_camera_transform, "al_build_camera_transform");
	lib.bindSymbol(cast(void**)&al_translate_transform, "al_translate_transform");
	lib.bindSymbol(cast(void**)&al_translate_transform_3d, "al_translate_transform_3d");
	lib.bindSymbol(cast(void**)&al_rotate_transform, "al_rotate_transform");
	lib.bindSymbol(cast(void**)&al_rotate_transform_3d, "al_rotate_transform_3d");
	lib.bindSymbol(cast(void**)&al_scale_transform, "al_scale_transform");
	lib.bindSymbol(cast(void**)&al_scale_transform_3d, "al_scale_transform_3d");
	lib.bindSymbol(cast(void**)&al_transform_coordinates, "al_transform_coordinates");
	lib.bindSymbol(cast(void**)&al_transform_coordinates_3d, "al_transform_coordinates_3d");
	lib.bindSymbol(cast(void**)&al_compose_transform, "al_compose_transform");
	lib.bindSymbol(cast(void**)&al_get_current_transform, "al_get_current_transform");
	lib.bindSymbol(cast(void**)&al_get_current_inverse_transform, "al_get_current_inverse_transform");
	lib.bindSymbol(cast(void**)&al_get_current_projection_transform, "al_get_current_projection_transform");
	lib.bindSymbol(cast(void**)&al_invert_transform, "al_invert_transform");
	lib.bindSymbol(cast(void**)&al_check_inverse, "al_check_inverse");
	lib.bindSymbol(cast(void**)&al_orthographic_transform, "al_orthographic_transform");
	lib.bindSymbol(cast(void**)&al_perspective_transform, "al_perspective_transform");
	lib.bindSymbol(cast(void**)&al_horizontal_shear_transform, "al_horizontal_shear_transform");
	lib.bindSymbol(cast(void**)&al_vertical_shear_transform, "al_vertical_shear_transform");

	lib.bindSymbol(cast(void**)&al_ustr_new, "al_ustr_new");
	lib.bindSymbol(cast(void**)&al_ustr_new_from_buffer, "al_ustr_new_from_buffer");
	lib.bindSymbol(cast(void**)&al_ustr_newf, "al_ustr_newf");
	lib.bindSymbol(cast(void**)&al_ustr_free, "al_ustr_free");
	lib.bindSymbol(cast(void**)&al_cstr, "al_cstr");
	lib.bindSymbol(cast(void**)&al_ustr_to_buffer, "al_ustr_to_buffer");
	lib.bindSymbol(cast(void**)&al_cstr_dup, "al_cstr_dup");
	lib.bindSymbol(cast(void**)&al_ustr_dup, "al_ustr_dup");
	lib.bindSymbol(cast(void**)&al_ustr_dup_substr, "al_ustr_dup_substr");

	lib.bindSymbol(cast(void**)&al_ustr_empty_string, "al_ustr_empty_string");

	lib.bindSymbol(cast(void**)&al_ref_cstr, "al_ref_cstr");
	lib.bindSymbol(cast(void**)&al_ref_buffer, "al_ref_buffer");
	lib.bindSymbol(cast(void**)&al_ref_ustr, "al_ref_ustr");

	lib.bindSymbol(cast(void**)&al_ustr_size, "al_ustr_size");
	lib.bindSymbol(cast(void**)&al_ustr_length, "al_ustr_length");
	lib.bindSymbol(cast(void**)&al_ustr_offset, "al_ustr_offset");
	lib.bindSymbol(cast(void**)&al_ustr_next, "al_ustr_next");
	lib.bindSymbol(cast(void**)&al_ustr_prev, "al_ustr_prev");

	lib.bindSymbol(cast(void**)&al_ustr_get, "al_ustr_get");
	lib.bindSymbol(cast(void**)&al_ustr_get_next, "al_ustr_get_next");
	lib.bindSymbol(cast(void**)&al_ustr_prev_get, "al_ustr_prev_get");

	lib.bindSymbol(cast(void**)&al_ustr_insert, "al_ustr_insert");
	lib.bindSymbol(cast(void**)&al_ustr_insert_cstr, "al_ustr_insert_cstr");
	lib.bindSymbol(cast(void**)&al_ustr_insert_chr, "al_ustr_insert_chr");

	lib.bindSymbol(cast(void**)&al_ustr_append, "al_ustr_append");
	lib.bindSymbol(cast(void**)&al_ustr_append_cstr, "al_ustr_append_cstr");
	lib.bindSymbol(cast(void**)&al_ustr_append_chr, "al_ustr_append_chr");
	lib.bindSymbol(cast(void**)&al_ustr_appendf, "al_ustr_appendf");
	lib.bindSymbol(cast(void**)&al_ustr_vappendf, "al_ustr_vappendf");

	lib.bindSymbol(cast(void**)&al_ustr_remove_chr, "al_ustr_remove_chr");
	lib.bindSymbol(cast(void**)&al_ustr_remove_range, "al_ustr_remove_range");
	lib.bindSymbol(cast(void**)&al_ustr_truncate, "al_ustr_truncate");
	lib.bindSymbol(cast(void**)&al_ustr_ltrim_ws, "al_ustr_ltrim_ws");
	lib.bindSymbol(cast(void**)&al_ustr_rtrim_ws, "al_ustr_rtrim_ws");
	lib.bindSymbol(cast(void**)&al_ustr_trim_ws, "al_ustr_trim_ws");

	lib.bindSymbol(cast(void**)&al_ustr_assign, "al_ustr_assign");
	lib.bindSymbol(cast(void**)&al_ustr_assign_substr, "al_ustr_assign_substr");
	lib.bindSymbol(cast(void**)&al_ustr_assign_cstr, "al_ustr_assign_cstr");

	lib.bindSymbol(cast(void**)&al_ustr_set_chr, "al_ustr_set_chr");
	lib.bindSymbol(cast(void**)&al_ustr_replace_range, "al_ustr_replace_range");

	lib.bindSymbol(cast(void**)&al_ustr_find_chr, "al_ustr_find_chr");
	lib.bindSymbol(cast(void**)&al_ustr_rfind_chr, "al_ustr_rfind_chr");
	lib.bindSymbol(cast(void**)&al_ustr_find_set, "al_ustr_find_set");
	lib.bindSymbol(cast(void**)&al_ustr_find_set_cstr, "al_ustr_find_set_cstr");
	lib.bindSymbol(cast(void**)&al_ustr_find_cset, "al_ustr_find_cset");
	lib.bindSymbol(cast(void**)&al_ustr_find_cset_cstr, "al_ustr_find_cset_cstr");
	lib.bindSymbol(cast(void**)&al_ustr_find_str, "al_ustr_find_str");
	lib.bindSymbol(cast(void**)&al_ustr_find_cstr, "al_ustr_find_cstr");
	lib.bindSymbol(cast(void**)&al_ustr_rfind_str, "al_ustr_rfind_str");
	lib.bindSymbol(cast(void**)&al_ustr_rfind_cstr, "al_ustr_rfind_cstr");
	lib.bindSymbol(cast(void**)&al_ustr_find_replace, "al_ustr_find_replace");
	lib.bindSymbol(cast(void**)&al_ustr_find_replace_cstr, "al_ustr_find_replace_cstr");

	lib.bindSymbol(cast(void**)&al_ustr_equal, "al_ustr_equal");
	lib.bindSymbol(cast(void**)&al_ustr_compare, "al_ustr_compare");
	lib.bindSymbol(cast(void**)&al_ustr_ncompare, "al_ustr_ncompare");
	lib.bindSymbol(cast(void**)&al_ustr_has_prefix, "al_ustr_has_prefix");
	lib.bindSymbol(cast(void**)&al_ustr_has_prefix_cstr, "al_ustr_has_prefix_cstr");
	lib.bindSymbol(cast(void**)&al_ustr_has_suffix, "al_ustr_has_suffix");
	lib.bindSymbol(cast(void**)&al_ustr_has_suffix_cstr, "al_ustr_has_suffix_cstr");

	lib.bindSymbol(cast(void**)&al_utf8_width, "al_utf8_width");
	lib.bindSymbol(cast(void**)&al_utf8_encode, "al_utf8_encode");

	lib.bindSymbol(cast(void**)&al_ustr_new_from_utf16, "al_ustr_new_from_utf16");
	lib.bindSymbol(cast(void**)&al_ustr_size_utf16, "al_ustr_size_utf16");
	lib.bindSymbol(cast(void**)&al_ustr_encode_utf16, "al_ustr_encode_utf16");
	lib.bindSymbol(cast(void**)&al_utf16_width, "al_utf16_width");
	lib.bindSymbol(cast(void**)&al_utf16_encode, "al_utf16_encode");

	version (ALLEGRO_UNSTABLE) {

		lib.bindSymbol(cast(void**)&al_install_haptic, "al_install_haptic");
		lib.bindSymbol(cast(void**)&al_uninstall_haptic, "al_uninstall_haptic");
		lib.bindSymbol(cast(void**)&al_is_haptic_installed, "al_is_haptic_installed");

		lib.bindSymbol(cast(void**)&al_is_mouse_haptic, "al_is_mouse_haptic");
		lib.bindSymbol(cast(void**)&al_is_joystick_haptic, "al_is_joystick_haptic");
		lib.bindSymbol(cast(void**)&al_is_keyboard_haptic, "al_is_keyboard_haptic");
		lib.bindSymbol(cast(void**)&al_is_display_haptic, "al_is_display_haptic");
		lib.bindSymbol(cast(void**)&al_is_touch_input_haptic, "al_is_touch_input_haptic");

		lib.bindSymbol(cast(void**)&al_get_haptic_from_mouse, "al_get_haptic_from_mouse");
		lib.bindSymbol(cast(void**)&al_get_haptic_from_joystick, "al_get_haptic_from_joystick");
		lib.bindSymbol(cast(void**)&al_get_haptic_from_keyboard, "al_get_haptic_from_keyboard");
		lib.bindSymbol(cast(void**)&al_get_haptic_from_display, "al_get_haptic_from_display");
		lib.bindSymbol(cast(void**)&al_get_haptic_from_touch_input, "al_get_haptic_from_touch_input");

		lib.bindSymbol(cast(void**)&al_release_haptic, "al_release_haptic");

		lib.bindSymbol(cast(void**)&al_is_haptic_active, "al_is_haptic_active");
		lib.bindSymbol(cast(void**)&al_get_haptic_capabilities, "al_get_haptic_capabilities");
		lib.bindSymbol(cast(void**)&al_is_haptic_capable, "al_is_haptic_capable");

		lib.bindSymbol(cast(void**)&al_set_haptic_gain, "al_set_haptic_gain");
		lib.bindSymbol(cast(void**)&al_get_haptic_gain, "al_get_haptic_gain");

		lib.bindSymbol(cast(void**)&al_set_haptic_autocenter, "al_set_haptic_autocenter");
		lib.bindSymbol(cast(void**)&al_get_haptic_autocenter, "al_get_haptic_autocenter");

		lib.bindSymbol(cast(void**)&al_get_max_haptic_effects, "al_get_max_haptic_effects");
		lib.bindSymbol(cast(void**)&al_is_haptic_effect_ok, "al_is_haptic_effect_ok");
		lib.bindSymbol(cast(void**)&al_upload_haptic_effect, "al_upload_haptic_effect");
		lib.bindSymbol(cast(void**)&al_play_haptic_effect, "al_play_haptic_effect");
		lib.bindSymbol(cast(void**)&al_upload_and_play_haptic_effect, "al_upload_and_play_haptic_effect");
		lib.bindSymbol(cast(void**)&al_stop_haptic_effect, "al_stop_haptic_effect");
		lib.bindSymbol(cast(void**)&al_is_haptic_effect_playing, "al_is_haptic_effect_playing");
		lib.bindSymbol(cast(void**)&al_release_haptic_effect, "al_release_haptic_effect");
		lib.bindSymbol(cast(void**)&al_get_haptic_effect_duration, "al_get_haptic_effect_duration");
		lib.bindSymbol(cast(void**)&al_rumble_haptic, "al_rumble_haptic");

		lib.bindSymbol(cast(void**)&al_set_mouse_emulation_mode, "al_set_mouse_emulation_mode");
		lib.bindSymbol(cast(void**)&al_get_mouse_emulation_mode, "al_get_mouse_emulation_mode");
		lib.bindSymbol(cast(void**)&al_get_touch_input_mouse_emulation_event_source, "al_get_touch_input_mouse_emulation_event_source");
	}

	if (errorCount() != lastErrorCount) {
		return AllegroSupport.badLibrary;
	}
	loadedVersion = AllegroSupport.v5_2_0;

	static if (allegroSupport >= AllegroSupport.v5_2_1) {
		version (ALLEGRO_UNSTABLE) {
			lib.bindSymbol(cast(void**)&al_get_new_bitmap_depth, "al_get_new_bitmap_depth");
			lib.bindSymbol(cast(void**)&al_set_new_bitmap_depth, "al_set_new_bitmap_depth");
			lib.bindSymbol(cast(void**)&al_get_new_bitmap_samples, "al_get_new_bitmap_samples");
			lib.bindSymbol(cast(void**)&al_set_new_bitmap_samples, "al_set_new_bitmap_samples");
			lib.bindSymbol(cast(void**)&al_get_bitmap_depth, "al_get_bitmap_depth");
			lib.bindSymbol(cast(void**)&al_get_bitmap_samples, "al_get_bitmap_samples");

			lib.bindSymbol(cast(void**)&al_backup_dirty_bitmap, "al_backup_dirty_bitmap");
			lib.bindSymbol(cast(void**)&al_backup_dirty_bitmaps, "al_backup_dirty_bitmaps");
		}
		if (errorCount() != lastErrorCount) {
			return loadedVersion;
		}
		loadedVersion = AllegroSupport.v5_2_1;
	}

	static if (allegroSupport >= AllegroSupport.v5_2_2) {
		version (ALLEGRO_UNSTABLE) {
			version (Android) {
				lib.bindSymbol(cast(void**)&al_android_get_jni_env, "al_android_get_jni_env");
				lib.bindSymbol(cast(void**)&pal_android_get_activity, "pal_android_get_activity");
			}
		}

		if (errorCount() != lastErrorCount) {
			return loadedVersion;
		}
		loadedVersion = AllegroSupport.v5_2_2;
	}

	static if (allegroSupport >= AllegroSupport.v5_2_3) {
		version (ALLEGRO_UNSTABLE) {
			version (ALLEGRO_X11) {
				lib.bindSymbol(cast(void**)&al_x_set_initial_icon, "al_x_set_initial_icon");
			}
			lib.bindSymbol(cast(void**)&al_clear_keyboard_state, "al_clear_keyboard_state");
		}
		// Considered stable
		lib.bindSymbol(cast(void**)&al_path_ustr, "al_path_ustr");

		if (errorCount() != lastErrorCount) {
			return loadedVersion;
		}
		loadedVersion = AllegroSupport.v5_2_3;
	}

	static if (allegroSupport >= AllegroSupport.v5_2_4) {
		// Considered stable
		lib.bindSymbol(cast(void**)&al_transform_coordinates_4d, "al_transform_coordinates_4d");
		lib.bindSymbol(cast(void**)&al_transform_coordinates_3d_projective, "al_transform_coordinates_3d_projective");

		if (errorCount() != lastErrorCount) {
			return loadedVersion;
		}
		loadedVersion = AllegroSupport.v5_2_4;
	}

	static if (allegroSupport >= AllegroSupport.v5_2_5) {
		version (ALLEGRO_UNSTABLE) {
			lib.bindSymbol(cast(void**)&al_get_bitmap_blend_color, "al_get_bitmap_blend_color");
			lib.bindSymbol(cast(void**)&al_get_bitmap_blender, "al_get_bitmap_blender");
			lib.bindSymbol(cast(void**)&al_get_separate_bitmap_blender, "al_get_separate_bitmap_blender");
			lib.bindSymbol(cast(void**)&al_set_bitmap_blend_color, "al_set_bitmap_blend_color");
			lib.bindSymbol(cast(void**)&al_set_bitmap_blender, "al_set_bitmap_blender");
			lib.bindSymbol(cast(void**)&al_set_separate_bitmap_blender, "al_set_separate_bitmap_blender");
			lib.bindSymbol(cast(void**)&al_reset_bitmap_blender, "al_reset_bitmap_blender");

			lib.bindSymbol(cast(void**)&al_create_thread_with_stacksize, "al_create_thread_with_stacksize");
		}

		// Considered stable
		lib.bindSymbol(cast(void**)&al_get_monitor_dpi, "al_get_monitor_dpi");
		lib.bindSymbol(cast(void**)&al_get_system_id, "al_get_system_id");
		lib.bindSymbol(cast(void**)&al_transpose_transform, "al_transpose_transform");

		if (errorCount() != lastErrorCount) {
			return loadedVersion;
		}
		loadedVersion = AllegroSupport.v5_2_5;
	}

	static if (allegroSupport >= AllegroSupport.v5_2_6) {
		version (ALLEGRO_UNSTABLE) {
			lib.bindSymbol(cast(void**)&al_get_monitor_refresh_rate, "al_get_monitor_refresh_rate");
		}

		if (errorCount() != lastErrorCount) {
			return loadedVersion;
		}
		loadedVersion = AllegroSupport.v5_2_6;
	}

	static if (allegroSupport >= AllegroSupport.v5_2_7) {
		// No new functions
		if (errorCount() != lastErrorCount) {
			return loadedVersion;
		}
		loadedVersion = AllegroSupport.v5_2_7;
	}

	static if (allegroSupport >= AllegroSupport.v5_2_8) {
		version (ALLEGRO_UNSTABLE) {
			lib.bindSymbol(cast(void**)&al_get_new_bitmap_wrap, "al_get_new_bitmap_wrap");
			lib.bindSymbol(cast(void**)&al_set_new_bitmap_wrap, "al_set_new_bitmap_wrap");
		}

		if (errorCount() != lastErrorCount) {
			return loadedVersion;
		}
		loadedVersion = AllegroSupport.v5_2_8;
	}

	static if (allegroSupport >= AllegroSupport.v5_2_9) {
		lib.bindSymbol(cast(void**)&al_can_set_keyboard_leds, "al_can_set_keyboard_leds");
		lib.bindSymbol(cast(void**)&al_can_get_mouse_cursor_position, "al_can_get_mouse_cursor_position");
		lib.bindSymbol(cast(void**)&al_get_current_shader, "al_get_current_shader");
		version (ALLEGRO_UNSTABLE) {
			lib.bindSymbol(cast(void**)&al_get_window_borders, "al_get_window_borders");
		}
		if (errorCount() != lastErrorCount) {
			return loadedVersion;
		}
		loadedVersion = AllegroSupport.v5_2_9;
	}

	static if (allegroSupport >= AllegroSupport.v5_2_10) {
		lib.bindSymbol(cast(void**)&al_get_display_adapter, "al_get_display_adapter");
		lib.bindSymbol(cast(void**)&al_get_render_state, "al_get_render_state");
		lib.bindSymbol(cast(void**)&al_ref_info, "al_ref_info");

		version (Android) {
			lib.bindSymbol(cast(void**)&al_android_open_fd, "al_android_open_fd");
		}

		if (errorCount() != lastErrorCount) {
			return loadedVersion;
		}
		loadedVersion = AllegroSupport.v5_2_10;
	}

	static if (allegroSupport >= AllegroSupport.v5_2_11) {
		version (ALLEGRO_UNSTABLE) {
			lib.bindSymbol(cast(void**)&al_get_joystick_guid, "al_get_joystick_guid");
			lib.bindSymbol(cast(void**)&al_get_joystick_type, "al_get_joystick_type");
			lib.bindSymbol(cast(void**)&al_set_joystick_mappings, "al_set_joystick_mappings");
			lib.bindSymbol(cast(void**)&al_set_joystick_mappings_f, "al_set_joystick_mappings_f");
		}

		if (errorCount() != lastErrorCount) {
			return loadedVersion;
		}
		loadedVersion = AllegroSupport.v5_2_11;
	}

	version (Allegro_Monolith) {
		static AllegroSupport min(AllegroSupport lhs, AllegroSupport rhs) {
			return lhs < rhs ? lhs : rhs;
		}

		import bindbc.allegro5.allegro_acodec;
		auto acodecVersion = bindAllegroACodec(lib);
		loadedVersion = min(loadedVersion, acodecVersion);

		import bindbc.allegro5.allegro_audio;
		auto audioVersion = bindAllegroAudio(lib);
		loadedVersion = min(loadedVersion, audioVersion);

		import bindbc.allegro5.allegro_color;
		auto colorVersion = bindAllegroColor(lib);
		loadedVersion = min(loadedVersion, colorVersion);

		import bindbc.allegro5.allegro_font;
		auto fontVersion = bindAllegroFont(lib);
		loadedVersion = min(loadedVersion, fontVersion);

		import bindbc.allegro5.allegro_image;
		auto imageVersion = bindAllegroImage(lib);
		loadedVersion = min(loadedVersion, imageVersion);

		import bindbc.allegro5.allegro_memfile;
		auto memfileVersion = bindAllegroMemfile(lib);
		loadedVersion = min(loadedVersion, memfileVersion);

		import bindbc.allegro5.allegro_native_dialog;
		auto dialogVersion = bindAllegroDialog(lib);
		loadedVersion = min(loadedVersion, dialogVersion);

		import bindbc.allegro5.allegro_physfs;
		auto physFSVersion = bindAllegroPhysFS(lib);
		loadedVersion = min(loadedVersion, physFSVersion);

		import bindbc.allegro5.allegro_primitives;
		auto primVersion = bindAllegroPrimitives(lib);
		loadedVersion = min(loadedVersion, primVersion);

		import bindbc.allegro5.allegro_ttf;
		auto ttfVersion = bindAllegroTTF(lib);
		loadedVersion = min(loadedVersion, ttfVersion);

		import bindbc.allegro5.allegro_video;
		auto videoVersion = bindAllegroVideo(lib);
		loadedVersion = min(loadedVersion, videoVersion);

	}

	return loadedVersion;

}
