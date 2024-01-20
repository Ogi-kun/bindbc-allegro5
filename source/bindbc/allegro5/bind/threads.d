module bindbc.allegro5.bind.threads;

import bindbc.allegro5.config;
import bindbc.allegro5.bind.altime : ALLEGRO_TIMEOUT;

struct ALLEGRO_THREAD;

struct ALLEGRO_MUTEX;

struct ALLEGRO_COND;

extern(C) @nogc nothrow {
	alias al_thread_proc = void* function(ALLEGRO_THREAD* thread, void* arg);
	alias al_detached_thread_proc = void* function(void* arg);
}

static if (staticBinding) {
	extern(C) @nogc nothrow:
	ALLEGRO_THREAD* al_create_thread(al_thread_proc proc, void* arg);
	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_5) {
		ALLEGRO_THREAD* al_create_thread_with_stacksize(al_thread_proc proc, void* arg, size_t stacksize);
	}
	void al_start_thread(ALLEGRO_THREAD* outer);
	void al_join_thread(ALLEGRO_THREAD* outer, void** ret_value);
	void al_set_thread_should_stop(ALLEGRO_THREAD* outer);
	bool al_get_thread_should_stop(ALLEGRO_THREAD* outer);
	void al_destroy_thread(ALLEGRO_THREAD* thread);
	void al_run_detached_thread(al_detached_thread_proc proc, void* arg);

	ALLEGRO_MUTEX* al_create_mutex();
	ALLEGRO_MUTEX* al_create_mutex_recursive();
	void al_lock_mutex(ALLEGRO_MUTEX* mutex);
	void al_unlock_mutex(ALLEGRO_MUTEX* mutex);
	void al_destroy_mutex(ALLEGRO_MUTEX* mutex);

	ALLEGRO_COND* al_create_cond();
	void al_destroy_cond(ALLEGRO_COND* cond);
	void al_wait_cond(ALLEGRO_COND* cond, ALLEGRO_MUTEX* mutex);
	int al_wait_cond_until(ALLEGRO_COND* cond, ALLEGRO_MUTEX* mutex, const(ALLEGRO_TIMEOUT)* timeout);
	void al_broadcast_cond(ALLEGRO_COND* cond);
	void al_signal_cond(ALLEGRO_COND* cond);
}
else {
	extern(C) @nogc nothrow {
		alias pal_create_thread = ALLEGRO_THREAD* function(al_thread_proc proc, void* arg);
		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_5) {
			alias pal_create_thread_with_stacksize = ALLEGRO_THREAD* function(
					al_thread_proc proc, void* arg, size_t stacksize);
		}
		alias pal_start_thread = void function(ALLEGRO_THREAD* outer);
		alias pal_join_thread = void function(ALLEGRO_THREAD* outer, void** ret_value);
		alias pal_set_thread_should_stop = void function(ALLEGRO_THREAD* outer);
		alias pal_get_thread_should_stop = bool function(ALLEGRO_THREAD* outer);
		alias pal_destroy_thread = void function(ALLEGRO_THREAD* thread);
		alias pal_run_detached_thread = void function(al_detached_thread_proc proc, void* arg);

		alias pal_create_mutex = ALLEGRO_MUTEX* function();
		alias pal_create_mutex_recursive = ALLEGRO_MUTEX* function();
		alias pal_lock_mutex = void function(ALLEGRO_MUTEX* mutex);
		alias pal_unlock_mutex = void function(ALLEGRO_MUTEX* mutex);
		alias pal_destroy_mutex = void function(ALLEGRO_MUTEX* mutex);

		alias pal_create_cond = ALLEGRO_COND* function();
		alias pal_destroy_cond = void function(ALLEGRO_COND* cond);
		alias pal_wait_cond = void function(ALLEGRO_COND* cond, ALLEGRO_MUTEX* mutex);
		alias pal_wait_cond_until = int function(ALLEGRO_COND* cond, ALLEGRO_MUTEX* mutex, const(ALLEGRO_TIMEOUT)* timeout);
		alias pal_broadcast_cond = void function(ALLEGRO_COND* cond);
		alias pal_signal_cond = void function(ALLEGRO_COND* cond);
	}
	__gshared {
		pal_create_thread al_create_thread;
		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_5) {
			pal_create_thread_with_stacksize al_create_thread_with_stacksize;
		}
		pal_start_thread al_start_thread;
		pal_join_thread al_join_thread;
		pal_set_thread_should_stop al_set_thread_should_stop;
		pal_get_thread_should_stop al_get_thread_should_stop;
		pal_destroy_thread al_destroy_thread;
		pal_run_detached_thread al_run_detached_thread;

		pal_create_mutex al_create_mutex;
		pal_create_mutex_recursive al_create_mutex_recursive;
		pal_lock_mutex al_lock_mutex;
		pal_unlock_mutex al_unlock_mutex;
		pal_destroy_mutex al_destroy_mutex;

		pal_create_cond al_create_cond;
		pal_destroy_cond al_destroy_cond;
		pal_wait_cond al_wait_cond;
		pal_wait_cond_until al_wait_cond_until;
		pal_broadcast_cond al_broadcast_cond;
		pal_signal_cond al_signal_cond;
	}
}
