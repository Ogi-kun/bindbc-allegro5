module bindbc.allegro5.bind.utf8;

import core.stdc.stdarg : va_list;
import bindbc.allegro5.config;


struct ALLEGRO_USTR {
	int mlen;
	int slen;
	char* data;
}

struct ALLEGRO_USTR_INFO {
	int mlen;
	int slen;
	char* data;
}


static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_USTR* al_ustr_new(const(char)* s);
	ALLEGRO_USTR* al_ustr_new_from_buffer(const(char)* s, size_t size);
	ALLEGRO_USTR* al_ustr_newf(const(char)* fmt, ...);
	void al_ustr_free(ALLEGRO_USTR* us);
	const(char)* al_cstr(const(ALLEGRO_USTR)* us);
	void al_ustr_to_buffer(const(ALLEGRO_USTR)* us, char* buffer, int size);
	char* al_cstr_dup(const(ALLEGRO_USTR)* us);
	ALLEGRO_USTR* al_ustr_dup(const(ALLEGRO_USTR)* us);
	ALLEGRO_USTR* al_ustr_dup_substr(const(ALLEGRO_USTR)* us, int start_pos, int end_pos);

	const(ALLEGRO_USTR)* al_ustr_empty_string();

	const(ALLEGRO_USTR)* al_ref_cstr(ALLEGRO_USTR_INFO* info, const(char)* s);
	const(ALLEGRO_USTR)* al_ref_buffer(ALLEGRO_USTR_INFO* info, const(char)* s, size_t size);
	const(ALLEGRO_USTR)* al_ref_ustr(ALLEGRO_USTR_INFO* info, const(ALLEGRO_USTR)* us, int start_pos, int end_pos);

	size_t al_ustr_size(const(ALLEGRO_USTR)* us);
	size_t al_ustr_length(const(ALLEGRO_USTR)* us);
	int al_ustr_offset(const(ALLEGRO_USTR)* us, int index);
	bool al_ustr_next(const(ALLEGRO_USTR)* us, int* pos);
	bool al_ustr_prev(const(ALLEGRO_USTR)* us, int* pos);

	int al_ustr_get(const(ALLEGRO_USTR)* us, int pos);
	int al_ustr_get_next(const(ALLEGRO_USTR)* us, int* pos);
	int al_ustr_prev_get(const(ALLEGRO_USTR)* us, int* pos);

	bool al_ustr_insert(ALLEGRO_USTR* us1, int pos, const(ALLEGRO_USTR)* us2);
	bool al_ustr_insert_cstr(ALLEGRO_USTR* us, int pos, const(char)* us2);
	size_t al_ustr_insert_chr(ALLEGRO_USTR* us, int pos, int c);

	bool al_ustr_append(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2);
	bool al_ustr_append_cstr(ALLEGRO_USTR* us, const(char)* s);
	size_t al_ustr_append_chr(ALLEGRO_USTR* us, int c);
	bool al_ustr_appendf(ALLEGRO_USTR* us, const(char)* fmt, ...);
	bool al_ustr_vappendf(ALLEGRO_USTR* us, const(char)* fmt, va_list ap);

	bool al_ustr_remove_chr(ALLEGRO_USTR* us, int pos);
	bool al_ustr_remove_range(ALLEGRO_USTR* us, int start_pos, int end_pos);
	bool al_ustr_truncate(ALLEGRO_USTR* us, int start_pos);
	bool al_ustr_ltrim_ws(ALLEGRO_USTR* us);
	bool al_ustr_rtrim_ws(ALLEGRO_USTR* us);
	bool al_ustr_trim_ws(ALLEGRO_USTR* us);

	bool al_ustr_assign(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2);
	bool al_ustr_assign_substr(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2, int start_pos, int end_pos);
	bool al_ustr_assign_cstr(ALLEGRO_USTR* us1, const(char)* s);

	size_t al_ustr_set_chr(ALLEGRO_USTR* us, int pos, int c);
	bool al_ustr_replace_range(ALLEGRO_USTR* us1, int start_pos1, int end_pos1, const(ALLEGRO_USTR)* us2);

	int al_ustr_find_chr(const(ALLEGRO_USTR)* us, int start_pos, int c);
	int al_ustr_rfind_chr(const(ALLEGRO_USTR)* us, int start_pos, int c);
	int al_ustr_find_set(const(ALLEGRO_USTR)* us, int start_pos, const(ALLEGRO_USTR)* accept);
	int al_ustr_find_set_cstr(const(ALLEGRO_USTR)* us, int start_pos, const(char)* accept);
	int al_ustr_find_cset(const(ALLEGRO_USTR)* us, int start_pos, const(ALLEGRO_USTR)* reject);
	int al_ustr_find_cset_cstr(const(ALLEGRO_USTR)* us, int start_pos, const(char)* reject);
	int al_ustr_find_str(const(ALLEGRO_USTR)* haystack, int start_pos, const(ALLEGRO_USTR)* needle);
	int al_ustr_find_cstr(const(ALLEGRO_USTR)* haystack, int start_pos, const(char)* needle);
	int al_ustr_rfind_str(const(ALLEGRO_USTR)* haystack, int start_pos, const(ALLEGRO_USTR)* needle);
	int al_ustr_rfind_cstr(const(ALLEGRO_USTR)* haystack, int start_pos, const(char)* needle);
	bool al_ustr_find_replace(ALLEGRO_USTR* us, int start_pos, const(ALLEGRO_USTR)* find, const(ALLEGRO_USTR)* replace);
	bool al_ustr_find_replace_cstr(ALLEGRO_USTR* us, int start_pos, const(char)* find, const(char)* replace);

	bool al_ustr_equal(const(ALLEGRO_USTR)* us1, const(ALLEGRO_USTR)* us2);
	int al_ustr_compare(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v);
	int al_ustr_ncompare(const(ALLEGRO_USTR)* us1, const(ALLEGRO_USTR)* us2, int n);
	bool al_ustr_has_prefix(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v);
	bool al_ustr_has_prefix_cstr(const(ALLEGRO_USTR)* u, const(char)* s);
	bool al_ustr_has_suffix(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v);
	bool al_ustr_has_suffix_cstr(const(ALLEGRO_USTR)* us1, const(char)* s);

	size_t al_utf8_width(int c);
	size_t al_utf8_encode(char* s, int c);

	ALLEGRO_USTR* al_ustr_new_from_utf16(const(wchar)* s);
	size_t al_ustr_size_utf16(const(ALLEGRO_USTR)* us);
	size_t al_ustr_encode_utf16(const(ALLEGRO_USTR)* us, wchar* s, size_t n);
	size_t al_utf16_width(int c);
	size_t al_utf16_encode(wchar* s, int c);

	static if (allegroSupport >= AllegroSupport.v5_2_10) {
		const(ALLEGRO_USTR)* al_ref_info(const(ALLEGRO_USTR_INFO)* info);
	}
}
else {
	pragma(inline, true) extern(C) @nogc nothrow:

	ALLEGRO_USTR* al_ustr_new(const(char)* s) => ptr_al_ustr_new(s);
	ALLEGRO_USTR* al_ustr_new_from_buffer(const(char)* s, size_t size) => ptr_al_ustr_new_from_buffer(s, size);
	ALLEGRO_USTR* al_ustr_newf(const(char)* fmt, ...) => ptr_al_ustr_newf(__traits(parameters));
	void al_ustr_free(ALLEGRO_USTR* us) => ptr_al_ustr_free(us);
	const(char)* al_cstr(const(ALLEGRO_USTR)* us) => ptr_al_cstr(us);
	void al_ustr_to_buffer(const(ALLEGRO_USTR)* us, char* buffer, int size) => ptr_al_ustr_to_buffer(us, buffer, size);
	char* al_cstr_dup(const(ALLEGRO_USTR)* us) => ptr_al_cstr_dup(us);
	ALLEGRO_USTR* al_ustr_dup(const(ALLEGRO_USTR)* us) => ptr_al_ustr_dup(us);
	ALLEGRO_USTR* al_ustr_dup_substr(const(ALLEGRO_USTR)* us, int start_pos, int end_pos) => ptr_al_ustr_dup_substr(us, start_pos, end_pos);

	const(ALLEGRO_USTR)* al_ustr_empty_string() => ptr_al_ustr_empty_string();

	const(ALLEGRO_USTR)* al_ref_cstr(ALLEGRO_USTR_INFO* info, const(char)* s) => ptr_al_ref_cstr(info, s);
	const(ALLEGRO_USTR)* al_ref_buffer(ALLEGRO_USTR_INFO* info, const(char)* s, size_t size) => ptr_al_ref_buffer(info, s, size);
	const(ALLEGRO_USTR)* al_ref_ustr(ALLEGRO_USTR_INFO* info, const(ALLEGRO_USTR)* us, int start_pos, int end_pos) => ptr_al_ref_ustr(info, us, start_pos, end_pos);

	size_t al_ustr_size(const(ALLEGRO_USTR)* us) => ptr_al_ustr_size(us);
	size_t al_ustr_length(const(ALLEGRO_USTR)* us) => ptr_al_ustr_length(us);
	int al_ustr_offset(const(ALLEGRO_USTR)* us, int index) => ptr_al_ustr_offset(us, index);
	bool al_ustr_next(const(ALLEGRO_USTR)* us, int* pos) => ptr_al_ustr_next(us, pos);
	bool al_ustr_prev(const(ALLEGRO_USTR)* us, int* pos) => ptr_al_ustr_prev(us, pos);

	int al_ustr_get(const(ALLEGRO_USTR)* us, int pos) => ptr_al_ustr_get(us, pos);
	int al_ustr_get_next(const(ALLEGRO_USTR)* us, int* pos) => ptr_al_ustr_get_next(us, pos);
	int al_ustr_prev_get(const(ALLEGRO_USTR)* us, int* pos) => ptr_al_ustr_prev_get(us, pos);

	bool al_ustr_insert(ALLEGRO_USTR* us1, int pos, const(ALLEGRO_USTR)* us2) => ptr_al_ustr_insert(us1, pos, us2);
	bool al_ustr_insert_cstr(ALLEGRO_USTR* us, int pos, const(char)* us2) => ptr_al_ustr_insert_cstr(us, pos, us2);
	size_t al_ustr_insert_chr(ALLEGRO_USTR* us, int pos, int c) => ptr_al_ustr_insert_chr(us, pos, c);

	bool al_ustr_append(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2) => ptr_al_ustr_append(us1, us2);
	bool al_ustr_append_cstr(ALLEGRO_USTR* us, const(char)* s) => ptr_al_ustr_append_cstr(us, s);
	size_t al_ustr_append_chr(ALLEGRO_USTR* us, int c) => ptr_al_ustr_append_chr(us, c);
	bool al_ustr_appendf(ALLEGRO_USTR* us, const(char)* fmt, ...) => ptr_al_ustr_appendf(__traits(parameters));
	bool al_ustr_vappendf(ALLEGRO_USTR* us, const(char)* fmt, va_list ap) => ptr_al_ustr_vappendf(us, fmt, ap);

	bool al_ustr_remove_chr(ALLEGRO_USTR* us, int pos) => ptr_al_ustr_remove_chr(us, pos);
	bool al_ustr_remove_range(ALLEGRO_USTR* us, int start_pos, int end_pos) => ptr_al_ustr_remove_range(us, start_pos, end_pos);
	bool al_ustr_truncate(ALLEGRO_USTR* us, int start_pos) => ptr_al_ustr_truncate(us, start_pos);
	bool al_ustr_ltrim_ws(ALLEGRO_USTR* us) => ptr_al_ustr_ltrim_ws(us);
	bool al_ustr_rtrim_ws(ALLEGRO_USTR* us) => ptr_al_ustr_rtrim_ws(us);
	bool al_ustr_trim_ws(ALLEGRO_USTR* us) => ptr_al_ustr_trim_ws(us);

	bool al_ustr_assign(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2) => ptr_al_ustr_assign(us1, us2);
	bool al_ustr_assign_substr(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2, int start_pos, int end_pos) => ptr_al_ustr_assign_substr(us1, us2, start_pos, end_pos);
	bool al_ustr_assign_cstr(ALLEGRO_USTR* us1, const(char)* s) => ptr_al_ustr_assign_cstr(us1, s);

	size_t al_ustr_set_chr(ALLEGRO_USTR* us, int pos, int c) => ptr_al_ustr_set_chr(us, pos, c);
	bool al_ustr_replace_range(ALLEGRO_USTR* us1, int start_pos1, int end_pos1, const(ALLEGRO_USTR)* us2) => ptr_al_ustr_replace_range(us1, start_pos1, end_pos1, us2);

	int al_ustr_find_chr(const(ALLEGRO_USTR)* us, int start_pos, int c) => ptr_al_ustr_find_chr(us, start_pos, c);
	int al_ustr_rfind_chr(const(ALLEGRO_USTR)* us, int start_pos, int c) => ptr_al_ustr_rfind_chr(us, start_pos, c);
	int al_ustr_find_set(const(ALLEGRO_USTR)* us, int start_pos, const(ALLEGRO_USTR)* accept) => ptr_al_ustr_find_set(us, start_pos, accept);
	int al_ustr_find_set_cstr(const(ALLEGRO_USTR)* us, int start_pos, const(char)* accept) => ptr_al_ustr_find_set_cstr(us, start_pos, accept);
	int al_ustr_find_cset(const(ALLEGRO_USTR)* us, int start_pos, const(ALLEGRO_USTR)* reject) => ptr_al_ustr_find_cset(us, start_pos, reject);
	int al_ustr_find_cset_cstr(const(ALLEGRO_USTR)* us, int start_pos, const(char)* reject) => ptr_al_ustr_find_cset_cstr(us, start_pos, reject);
	int al_ustr_find_str(const(ALLEGRO_USTR)* haystack, int start_pos, const(ALLEGRO_USTR)* needle) => ptr_al_ustr_find_str(haystack, start_pos, needle);
	int al_ustr_find_cstr(const(ALLEGRO_USTR)* haystack, int start_pos, const(char)* needle) => ptr_al_ustr_find_cstr(haystack, start_pos, needle);
	int al_ustr_rfind_str(const(ALLEGRO_USTR)* haystack, int start_pos, const(ALLEGRO_USTR)* needle) => ptr_al_ustr_rfind_str(haystack, start_pos, needle);
	int al_ustr_rfind_cstr(const(ALLEGRO_USTR)* haystack, int start_pos, const(char)* needle) => ptr_al_ustr_rfind_cstr(haystack, start_pos, needle);
	bool al_ustr_find_replace(ALLEGRO_USTR* us, int start_pos, const(ALLEGRO_USTR)* find, const(ALLEGRO_USTR)* replace) => ptr_al_ustr_find_replace(us, start_pos, find, replace);
	bool al_ustr_find_replace_cstr(ALLEGRO_USTR* us, int start_pos, const(char)* find, const(char)* replace) => ptr_al_ustr_find_replace_cstr(us, start_pos, find, replace);

	bool al_ustr_equal(const(ALLEGRO_USTR)* us1, const(ALLEGRO_USTR)* us2) => ptr_al_ustr_equal(us1, us2);
	int al_ustr_compare(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v) => ptr_al_ustr_compare(u, v);
	int al_ustr_ncompare(const(ALLEGRO_USTR)* us1, const(ALLEGRO_USTR)* us2, int n) => ptr_al_ustr_ncompare(us1, us2, n);
	bool al_ustr_has_prefix(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v) => ptr_al_ustr_has_prefix(u, v);
	bool al_ustr_has_prefix_cstr(const(ALLEGRO_USTR)* u, const(char)* s) => ptr_al_ustr_has_prefix_cstr(u, s);
	bool al_ustr_has_suffix(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v) => ptr_al_ustr_has_suffix(u, v);
	bool al_ustr_has_suffix_cstr(const(ALLEGRO_USTR)* us1, const(char)* s) => ptr_al_ustr_has_suffix_cstr(us1, s);

	size_t al_utf8_width(int c) => ptr_al_utf8_width(c);
	size_t al_utf8_encode(char* s, int c) => ptr_al_utf8_encode(s, c);

	ALLEGRO_USTR* al_ustr_new_from_utf16(const(wchar)* s) => ptr_al_ustr_new_from_utf16(s);
	size_t al_ustr_size_utf16(const(ALLEGRO_USTR)* us) => ptr_al_ustr_size_utf16(us);
	size_t al_ustr_encode_utf16(const(ALLEGRO_USTR)* us, wchar* s, size_t n) => ptr_al_ustr_encode_utf16(us, s, n);
	size_t al_utf16_width(int c) => ptr_al_utf16_width(c);
	size_t al_utf16_encode(wchar* s, int c) => ptr_al_utf16_encode(s, c);

	static if (allegroSupport >= AllegroSupport.v5_2_10) {
		const(ALLEGRO_USTR)* al_ref_info(const(ALLEGRO_USTR_INFO)* info) => ptr_al_ref_info(info);
	}

	package(bindbc.allegro5) __gshared {
		typeof(&al_ustr_new) ptr_al_ustr_new;
		typeof(&al_ustr_new_from_buffer) ptr_al_ustr_new_from_buffer;
		typeof(&al_ustr_newf) ptr_al_ustr_newf;
		typeof(&al_ustr_free) ptr_al_ustr_free;
		typeof(&al_cstr) ptr_al_cstr;
		typeof(&al_ustr_to_buffer) ptr_al_ustr_to_buffer;
		typeof(&al_cstr_dup) ptr_al_cstr_dup;
		typeof(&al_ustr_dup) ptr_al_ustr_dup;
		typeof(&al_ustr_dup_substr) ptr_al_ustr_dup_substr;

		typeof(&al_ustr_empty_string) ptr_al_ustr_empty_string;

		typeof(&al_ref_cstr) ptr_al_ref_cstr;
		typeof(&al_ref_buffer) ptr_al_ref_buffer;
		typeof(&al_ref_ustr) ptr_al_ref_ustr;

		typeof(&al_ustr_size) ptr_al_ustr_size;
		typeof(&al_ustr_length) ptr_al_ustr_length;
		typeof(&al_ustr_offset) ptr_al_ustr_offset;
		typeof(&al_ustr_next) ptr_al_ustr_next;
		typeof(&al_ustr_prev) ptr_al_ustr_prev;

		typeof(&al_ustr_get) ptr_al_ustr_get;
		typeof(&al_ustr_get_next) ptr_al_ustr_get_next;
		typeof(&al_ustr_prev_get) ptr_al_ustr_prev_get;

		typeof(&al_ustr_insert) ptr_al_ustr_insert;
		typeof(&al_ustr_insert_cstr) ptr_al_ustr_insert_cstr;
		typeof(&al_ustr_insert_chr) ptr_al_ustr_insert_chr;

		typeof(&al_ustr_append) ptr_al_ustr_append;
		typeof(&al_ustr_append_cstr) ptr_al_ustr_append_cstr;
		typeof(&al_ustr_append_chr) ptr_al_ustr_append_chr;
		typeof(&al_ustr_appendf) ptr_al_ustr_appendf;
		typeof(&al_ustr_vappendf) ptr_al_ustr_vappendf;

		typeof(&al_ustr_remove_chr) ptr_al_ustr_remove_chr;
		typeof(&al_ustr_remove_range) ptr_al_ustr_remove_range;
		typeof(&al_ustr_truncate) ptr_al_ustr_truncate;
		typeof(&al_ustr_ltrim_ws) ptr_al_ustr_ltrim_ws;
		typeof(&al_ustr_rtrim_ws) ptr_al_ustr_rtrim_ws;
		typeof(&al_ustr_trim_ws) ptr_al_ustr_trim_ws;

		typeof(&al_ustr_assign) ptr_al_ustr_assign;
		typeof(&al_ustr_assign_substr) ptr_al_ustr_assign_substr;
		typeof(&al_ustr_assign_cstr) ptr_al_ustr_assign_cstr;

		typeof(&al_ustr_set_chr) ptr_al_ustr_set_chr;
		typeof(&al_ustr_replace_range) ptr_al_ustr_replace_range;

		typeof(&al_ustr_find_chr) ptr_al_ustr_find_chr;
		typeof(&al_ustr_rfind_chr) ptr_al_ustr_rfind_chr;
		typeof(&al_ustr_find_set) ptr_al_ustr_find_set;
		typeof(&al_ustr_find_set_cstr) ptr_al_ustr_find_set_cstr;
		typeof(&al_ustr_find_cset) ptr_al_ustr_find_cset;
		typeof(&al_ustr_find_cset_cstr) ptr_al_ustr_find_cset_cstr;
		typeof(&al_ustr_find_str) ptr_al_ustr_find_str;
		typeof(&al_ustr_find_cstr) ptr_al_ustr_find_cstr;
		typeof(&al_ustr_rfind_str) ptr_al_ustr_rfind_str;
		typeof(&al_ustr_rfind_cstr) ptr_al_ustr_rfind_cstr;
		typeof(&al_ustr_find_replace) ptr_al_ustr_find_replace;
		typeof(&al_ustr_find_replace_cstr) ptr_al_ustr_find_replace_cstr;

		typeof(&al_ustr_equal) ptr_al_ustr_equal;
		typeof(&al_ustr_compare) ptr_al_ustr_compare;
		typeof(&al_ustr_ncompare) ptr_al_ustr_ncompare;
		typeof(&al_ustr_has_prefix) ptr_al_ustr_has_prefix;
		typeof(&al_ustr_has_prefix_cstr) ptr_al_ustr_has_prefix_cstr;
		typeof(&al_ustr_has_suffix) ptr_al_ustr_has_suffix;
		typeof(&al_ustr_has_suffix_cstr) ptr_al_ustr_has_suffix_cstr;

		typeof(&al_utf8_width) ptr_al_utf8_width;
		typeof(&al_utf8_encode) ptr_al_utf8_encode;

		typeof(&al_ustr_new_from_utf16) ptr_al_ustr_new_from_utf16;
		typeof(&al_ustr_size_utf16) ptr_al_ustr_size_utf16;
		typeof(&al_ustr_encode_utf16) ptr_al_ustr_encode_utf16;
		typeof(&al_utf16_width) ptr_al_utf16_width;
		typeof(&al_utf16_encode) ptr_al_utf16_encode;

		static if (allegroSupport >= AllegroSupport.v5_2_10) {
			typeof(&al_ref_info) ptr_al_ref_info;
		}
	}
}
