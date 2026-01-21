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
	public pragma(inline, true) extern(C) @nogc nothrow:

	ALLEGRO_THREAD* al_create_thread(al_thread_proc proc, void* arg) => ptr_al_create_thread(proc, arg);
	version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_5) {
		ALLEGRO_THREAD* al_create_thread_with_stacksize(al_thread_proc proc, void* arg, size_t stacksize) => ptr_al_create_thread_with_stacksize(proc, arg, stacksize);
	}
	void al_start_thread(ALLEGRO_THREAD* outer) => ptr_al_start_thread(outer);
	void al_join_thread(ALLEGRO_THREAD* outer, void** ret_value) => ptr_al_join_thread(outer, ret_value);
	void al_set_thread_should_stop(ALLEGRO_THREAD* outer) => ptr_al_set_thread_should_stop(outer);
	bool al_get_thread_should_stop(ALLEGRO_THREAD* outer) => ptr_al_get_thread_should_stop(outer);
	void al_destroy_thread(ALLEGRO_THREAD* thread) => ptr_al_destroy_thread(thread);
	void al_run_detached_thread(al_detached_thread_proc proc, void* arg) => ptr_al_run_detached_thread(proc, arg);

	ALLEGRO_MUTEX* al_create_mutex() => ptr_al_create_mutex();
	ALLEGRO_MUTEX* al_create_mutex_recursive() => ptr_al_create_mutex_recursive();
	void al_lock_mutex(ALLEGRO_MUTEX* mutex) => ptr_al_lock_mutex(mutex);
	void al_unlock_mutex(ALLEGRO_MUTEX* mutex) => ptr_al_unlock_mutex(mutex);
	void al_destroy_mutex(ALLEGRO_MUTEX* mutex) => ptr_al_destroy_mutex(mutex);

	ALLEGRO_COND* al_create_cond() => ptr_al_create_cond();
	void al_destroy_cond(ALLEGRO_COND* cond) => ptr_al_destroy_cond(cond);
	void al_wait_cond(ALLEGRO_COND* cond, ALLEGRO_MUTEX* mutex) => ptr_al_wait_cond(cond, mutex);
	int al_wait_cond_until(ALLEGRO_COND* cond, ALLEGRO_MUTEX* mutex, const(ALLEGRO_TIMEOUT)* timeout) => ptr_al_wait_cond_until(cond, mutex, timeout);
	void al_broadcast_cond(ALLEGRO_COND* cond) => ptr_al_broadcast_cond(cond);
	void al_signal_cond(ALLEGRO_COND* cond) => ptr_al_signal_cond(cond);

	package(bindbc.allegro5) __gshared {
		typeof(&al_create_thread) ptr_al_create_thread;
		version (ALLEGRO_UNSTABLE) static if (allegroSupport >= AllegroSupport.v5_2_5) {
			typeof(&al_create_thread_with_stacksize) ptr_al_create_thread_with_stacksize;
		}
		typeof(&al_start_thread) ptr_al_start_thread;
		typeof(&al_join_thread) ptr_al_join_thread;
		typeof(&al_set_thread_should_stop) ptr_al_set_thread_should_stop;
		typeof(&al_get_thread_should_stop) ptr_al_get_thread_should_stop;
		typeof(&al_destroy_thread) ptr_al_destroy_thread;
		typeof(&al_run_detached_thread) ptr_al_run_detached_thread;

		typeof(&al_create_mutex) ptr_al_create_mutex;
		typeof(&al_create_mutex_recursive) ptr_al_create_mutex_recursive;
		typeof(&al_lock_mutex) ptr_al_lock_mutex;
		typeof(&al_unlock_mutex) ptr_al_unlock_mutex;
		typeof(&al_destroy_mutex) ptr_al_destroy_mutex;

		typeof(&al_create_cond) ptr_al_create_cond;
		typeof(&al_destroy_cond) ptr_al_destroy_cond;
		typeof(&al_wait_cond) ptr_al_wait_cond;
		typeof(&al_wait_cond_until) ptr_al_wait_cond_until;
		typeof(&al_broadcast_cond) ptr_al_broadcast_cond;
		typeof(&al_signal_cond) ptr_al_signal_cond;
	}
}
