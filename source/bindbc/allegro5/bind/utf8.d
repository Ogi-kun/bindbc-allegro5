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
	extern(C) @nogc nothrow {
		alias pal_ustr_new = ALLEGRO_USTR* function(const(char)* s);
		alias pal_ustr_new_from_buffer = ALLEGRO_USTR* function(const(char)* s, size_t size);
		alias pal_ustr_newf = ALLEGRO_USTR* function(const(char)* fmt, ...);
		alias pal_ustr_free = void function(ALLEGRO_USTR* us);
		alias pal_cstr = const(char)* function(const(ALLEGRO_USTR)* us);
		alias pal_ustr_to_buffer = void function(const(ALLEGRO_USTR)* us, char* buffer, int size);
		alias pal_cstr_dup = char* function(const(ALLEGRO_USTR)* us);
		alias pal_ustr_dup = ALLEGRO_USTR* function(const(ALLEGRO_USTR)* us);
		alias pal_ustr_dup_substr = ALLEGRO_USTR* function(const(ALLEGRO_USTR)* us, int start_pos, int end_pos);

		alias pal_ustr_empty_string = const(ALLEGRO_USTR)* function();

		alias pal_ref_cstr = const(ALLEGRO_USTR)* function(ALLEGRO_USTR_INFO* info, const(char)* s);
		alias pal_ref_buffer = const(ALLEGRO_USTR)* function(ALLEGRO_USTR_INFO* info, const(char)* s, size_t size);
		alias pal_ref_ustr = const(ALLEGRO_USTR)* function(ALLEGRO_USTR_INFO* info, const(ALLEGRO_USTR)* us, int start_pos, int end_pos);

		alias pal_ustr_size = size_t function(const(ALLEGRO_USTR)* us);
		alias pal_ustr_length = size_t function(const(ALLEGRO_USTR)* us);
		alias pal_ustr_offset = int function(const(ALLEGRO_USTR)* us, int index);
		alias pal_ustr_next = bool function(const(ALLEGRO_USTR)* us, int* pos);
		alias pal_ustr_prev = bool function(const(ALLEGRO_USTR)* us, int* pos);

		alias pal_ustr_get = int function(const(ALLEGRO_USTR)* us, int pos);
		alias pal_ustr_get_next = int function(const(ALLEGRO_USTR)* us, int* pos);
		alias pal_ustr_prev_get = int function(const(ALLEGRO_USTR)* us, int* pos);

		alias pal_ustr_insert = bool function(ALLEGRO_USTR* us1, int pos, const(ALLEGRO_USTR)* us2);
		alias pal_ustr_insert_cstr = bool function(ALLEGRO_USTR* us, int pos, const(char)* us2);
		alias pal_ustr_insert_chr = size_t function(ALLEGRO_USTR* us, int pos, int c);

		alias pal_ustr_append = bool function(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2);
		alias pal_ustr_append_cstr = bool function(ALLEGRO_USTR* us, const(char)* s);
		alias pal_ustr_append_chr = size_t function(ALLEGRO_USTR* us, int c);
		alias pal_ustr_appendf = bool function(ALLEGRO_USTR* us, const(char)* fmt, ...);
		alias pal_ustr_vappendf = bool function(ALLEGRO_USTR* us, const(char)* fmt, va_list ap);

		alias pal_ustr_remove_chr = bool function(ALLEGRO_USTR* us, int pos);
		alias pal_ustr_remove_range = bool function(ALLEGRO_USTR* us, int start_pos, int end_pos);
		alias pal_ustr_truncate = bool function(ALLEGRO_USTR* us, int start_pos);
		alias pal_ustr_ltrim_ws = bool function(ALLEGRO_USTR* us);
		alias pal_ustr_rtrim_ws = bool function(ALLEGRO_USTR* us);
		alias pal_ustr_trim_ws = bool function(ALLEGRO_USTR* us);

		alias pal_ustr_assign = bool function(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2);
		alias pal_ustr_assign_substr = bool function(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2, int start_pos, int end_pos);
		alias pal_ustr_assign_cstr = bool function(ALLEGRO_USTR* us1, const(char)* s);

		alias pal_ustr_set_chr = size_t function(ALLEGRO_USTR* us, int pos, int c);
		alias pal_ustr_replace_range = bool function(ALLEGRO_USTR* us1, int start_pos1, int end_pos1, const(ALLEGRO_USTR)* us2);

		alias pal_ustr_find_chr = int function(const(ALLEGRO_USTR)* us, int start_pos, int c);
		alias pal_ustr_rfind_chr = int function(const(ALLEGRO_USTR)* us, int start_pos, int c);
		alias pal_ustr_find_set = int function(const(ALLEGRO_USTR)* us, int start_pos, const(ALLEGRO_USTR)* accept);
		alias pal_ustr_find_set_cstr = int function(const(ALLEGRO_USTR)* us, int start_pos, const(char)* accept);
		alias pal_ustr_find_cset = int function(const(ALLEGRO_USTR)* us, int start_pos, const(ALLEGRO_USTR)* reject);
		alias pal_ustr_find_cset_cstr = int function(const(ALLEGRO_USTR)* us, int start_pos, const(char)* reject);
		alias pal_ustr_find_str = int function(const(ALLEGRO_USTR)* haystack, int start_pos, const(ALLEGRO_USTR)* needle);
		alias pal_ustr_find_cstr = int function(const(ALLEGRO_USTR)* haystack, int start_pos, const(char)* needle);
		alias pal_ustr_rfind_str = int function(const(ALLEGRO_USTR)* haystack, int start_pos, const(ALLEGRO_USTR)* needle);
		alias pal_ustr_rfind_cstr = int function(const(ALLEGRO_USTR)* haystack, int start_pos, const(char)* needle);
		alias pal_ustr_find_replace = bool function(ALLEGRO_USTR* us, int start_pos, const(ALLEGRO_USTR)* find, const(ALLEGRO_USTR)* replace);
		alias pal_ustr_find_replace_cstr = bool function(ALLEGRO_USTR* us, int start_pos, const(char)* find, const(char)* replace);

		alias pal_ustr_equal = bool function(const(ALLEGRO_USTR)* us1, const(ALLEGRO_USTR)* us2);
		alias pal_ustr_compare = int function(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v);
		alias pal_ustr_ncompare = int function(const(ALLEGRO_USTR)* us1, const(ALLEGRO_USTR)* us2, int n);
		alias pal_ustr_has_prefix = bool function(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v);
		alias pal_ustr_has_prefix_cstr = bool function(const(ALLEGRO_USTR)* u, const(char)* s);
		alias pal_ustr_has_suffix = bool function(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v);
		alias pal_ustr_has_suffix_cstr = bool function(const(ALLEGRO_USTR)* us1, const(char)* s);

		alias pal_utf8_width = size_t function(int c);
		alias pal_utf8_encode = size_t function(char* s, int c);

		alias pal_ustr_new_from_utf16 = ALLEGRO_USTR* function(const(wchar)* s);
		alias pal_ustr_size_utf16 = size_t function(const(ALLEGRO_USTR)* us);
		alias pal_ustr_encode_utf16 = size_t function(const(ALLEGRO_USTR)* us, wchar* s, size_t n);
		alias pal_utf16_width = size_t function(int c);
		alias pal_utf16_encode = size_t function(wchar* s, int c);

	}
	__gshared {
		pal_ustr_new al_ustr_new;
		pal_ustr_new_from_buffer al_ustr_new_from_buffer;
		pal_ustr_newf al_ustr_newf;
		pal_ustr_free al_ustr_free;
		pal_cstr al_cstr;
		pal_ustr_to_buffer al_ustr_to_buffer;
		pal_cstr_dup al_cstr_dup;
		pal_ustr_dup al_ustr_dup;
		pal_ustr_dup_substr al_ustr_dup_substr;

		pal_ustr_empty_string al_ustr_empty_string;

		pal_ref_cstr al_ref_cstr;
		pal_ref_buffer al_ref_buffer;
		pal_ref_ustr al_ref_ustr;

		pal_ustr_size al_ustr_size;
		pal_ustr_length al_ustr_length;
		pal_ustr_offset al_ustr_offset;
		pal_ustr_next al_ustr_next;
		pal_ustr_prev al_ustr_prev;

		pal_ustr_get al_ustr_get;
		pal_ustr_get_next al_ustr_get_next;
		pal_ustr_prev_get al_ustr_prev_get;

		pal_ustr_insert al_ustr_insert;
		pal_ustr_insert_cstr al_ustr_insert_cstr;
		pal_ustr_insert_chr al_ustr_insert_chr;

		pal_ustr_append al_ustr_append;
		pal_ustr_append_cstr al_ustr_append_cstr;
		pal_ustr_append_chr al_ustr_append_chr;
		pal_ustr_appendf al_ustr_appendf;
		pal_ustr_vappendf al_ustr_vappendf;

		pal_ustr_remove_chr al_ustr_remove_chr;
		pal_ustr_remove_range al_ustr_remove_range;
		pal_ustr_truncate al_ustr_truncate;
		pal_ustr_ltrim_ws al_ustr_ltrim_ws;
		pal_ustr_rtrim_ws al_ustr_rtrim_ws;
		pal_ustr_trim_ws al_ustr_trim_ws;

		pal_ustr_assign al_ustr_assign;
		pal_ustr_assign_substr al_ustr_assign_substr;
		pal_ustr_assign_cstr al_ustr_assign_cstr;

		pal_ustr_set_chr al_ustr_set_chr;
		pal_ustr_replace_range al_ustr_replace_range;

		pal_ustr_find_chr al_ustr_find_chr;
		pal_ustr_rfind_chr al_ustr_rfind_chr;
		pal_ustr_find_set al_ustr_find_set;
		pal_ustr_find_set_cstr al_ustr_find_set_cstr;
		pal_ustr_find_cset al_ustr_find_cset;
		pal_ustr_find_cset_cstr al_ustr_find_cset_cstr;
		pal_ustr_find_str al_ustr_find_str;
		pal_ustr_find_cstr al_ustr_find_cstr;
		pal_ustr_rfind_str al_ustr_rfind_str;
		pal_ustr_rfind_cstr al_ustr_rfind_cstr;
		pal_ustr_find_replace al_ustr_find_replace;
		pal_ustr_find_replace_cstr al_ustr_find_replace_cstr;

		pal_ustr_equal al_ustr_equal;
		pal_ustr_compare al_ustr_compare;
		pal_ustr_ncompare al_ustr_ncompare;
		pal_ustr_has_prefix al_ustr_has_prefix;
		pal_ustr_has_prefix_cstr al_ustr_has_prefix_cstr;
		pal_ustr_has_suffix al_ustr_has_suffix;
		pal_ustr_has_suffix_cstr al_ustr_has_suffix_cstr;

		pal_utf8_width al_utf8_width;
		pal_utf8_encode al_utf8_encode;

		pal_ustr_new_from_utf16 al_ustr_new_from_utf16;
		pal_ustr_size_utf16 al_ustr_size_utf16;
		pal_ustr_encode_utf16 al_ustr_encode_utf16;
		pal_utf16_width al_utf16_width;
		pal_utf16_encode al_utf16_encode;

	}

	static if (allegroSupport >= AllegroSupport.v5_2_10) {
		extern(C) @nogc nothrow {
			alias pal_ref_info = const(ALLEGRO_USTR)* function(const(ALLEGRO_USTR_INFO)* info);
		}
		__gshared {
			pal_ref_info al_ref_info;
		}
	}
}
