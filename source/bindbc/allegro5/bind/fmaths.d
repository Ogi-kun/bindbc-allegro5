module bindbc.allegro5.bind.fmaths;


import core.stdc.errno : ERANGE, EDOM;
import bindbc.allegro5.config;
import bindbc.allegro5.bind.fixed;
import bindbc.allegro5.bind.error;

static if (staticBinding) {
	extern(C) @nogc nothrow:
	al_fixed al_fixsqrt(al_fixed x);
	al_fixed al_fixhypot(al_fixed x, al_fixed y);
	al_fixed al_fixatan(al_fixed x);
	al_fixed al_fixatan2(al_fixed y, al_fixed x);
}
else {
	extern(C) @nogc nothrow {
		alias pal_fixsqrt = al_fixed function(al_fixed x);
		alias pal_fixhypot = al_fixed function(al_fixed x, al_fixed y);
		alias pal_fixatan = al_fixed function(al_fixed x);
		alias pal_fixatan2 = al_fixed function(al_fixed y, al_fixed x);
	}
	__gshared {
		pal_fixsqrt al_fixsqrt;
		pal_fixhypot al_fixhypot;
		pal_fixatan al_fixatan;
		pal_fixatan2 al_fixatan2;
	}
}

extern extern(C) {
	al_fixed* _al_fix_cos_tbl;
	al_fixed* _al_fix_tan_tbl;
	al_fixed* _al_fix_acos_tbl;
}

extern(C) @nogc nothrow:

al_fixed al_ftofix(double x) {
	if (x > 32767.0) {
		al_set_errno(ERANGE);
		return 0x7FFFFFFF;
	}
	if (x < -32767.0) {
		al_set_errno(ERANGE);
		return -0x7FFFFFFF;
	}
	return cast(al_fixed)(x * 65536.0 + (x < 0 ? -0.5 : 0.5));
}


double al_fixtof(al_fixed x) {
   return cast(double)x / 65536.0;
}


al_fixed al_fixadd(al_fixed x, al_fixed y) {
	al_fixed result = x + y;

	if (result >= 0) {
		if (x < 0 && y < 0) {
			al_set_errno(ERANGE);
			return -0x7FFFFFFF;
		}
		else {
			return result;
		}
	}
	else {
		if (x > 0 && y > 0) {
			al_set_errno(ERANGE);
			return 0x7FFFFFFF;
		}
		else {
			return result;
		}
	}
}


al_fixed al_fixsub(al_fixed x, al_fixed y) {
   al_fixed result = x - y;

	if (result >= 0) {
		if (x < 0 && y > 0) {
			al_set_errno(ERANGE);
			return -0x7FFFFFFF;
		}
		else {
			return result;
		}
	}
	else {
		if (x > 0 && y < 0) {
		al_set_errno(ERANGE);
			return 0x7FFFFFFF;
		}
		else {
			return result;
		}
	}
}


al_fixed al_fixmul(al_fixed x, al_fixed y) {
	version (X86) {
		return al_ftofix(al_fixtof(x) * al_fixtof(y));
	}
	else {
		long lx = x;
		long ly = y;
		long lres = (lx*ly);

		if (lres > 0x7FFFFFFF0000) {
			al_set_errno(ERANGE);
			return 0x7FFFFFFF;
		}
		else if (lres < -0x7FFFFFFF0000) {
			al_set_errno(ERANGE);
			return 0x80000000;
		}
		else {
			return cast(al_fixed)(lres >> 16);
		}
	}
}



al_fixed al_fixdiv(al_fixed x, al_fixed y) {
	version (D_SoftFloat) {
		int64_t lres = x;
		if (y == 0) {
			al_set_errno(ERANGE);
			return (x < 0) ? -0x7FFFFFFF : 0x7FFFFFFF;
		}
		lres <<= 16;
		lres /= y;
		if (lres > 0x7FFFFFFF) {
			al_set_errno(ERANGE);
			return 0x7FFFFFFF;
		}
		else if (lres < -0x7FFFFFFF) {
			al_set_errno(ERANGE);
			return 0x80000000;
		}
		else {
			return cast(al_fixed)(lres);
		}
	}
	else {
		if (y == 0) {
			al_set_errno(ERANGE);
			return (x < 0) ? -0x7FFFFFFF : 0x7FFFFFFF;
		}
		else {
			return al_ftofix(al_fixtof(x) / al_fixtof(y));
		}
	}
}


int al_fixfloor(al_fixed x) {
	// (x >> 16) IS portable in D
	return x >> 16;
}


int al_fixceil(al_fixed x) {
	if (x > 0x7FFF0000) {
		al_set_errno(ERANGE);
		return 0x7FFF;
	}
	return al_fixfloor(x + 0xFFFF);
}


al_fixed al_itofix(int x) {
	return x << 16;
}


int al_fixtoi(al_fixed x){
	return al_fixfloor(x) + ((x & 0x8000) >> 15);
}


al_fixed al_fixcos(al_fixed x) {
	return _al_fix_cos_tbl[((x + 0x4000) >> 15) & 0x1FF];
}


al_fixed al_fixsin(al_fixed x) {
	return _al_fix_cos_tbl[((x - 0x400000 + 0x4000) >> 15) & 0x1FF];
}


al_fixed al_fixtan(al_fixed x) {
	return _al_fix_tan_tbl[((x + 0x4000) >> 15) & 0xFF];
}


al_fixed al_fixacos(al_fixed x) {
	if (x < -65536 || x > 65536) {
		al_set_errno(EDOM);
		return 0;
	}
	return _al_fix_acos_tbl[(x+65536+127)>>8];
}


al_fixed al_fixasin(al_fixed x) {
	if (x < -65536 || x > 65536) {
		al_set_errno(EDOM);
		return 0;
	}
	return 0x00400000 - _al_fix_acos_tbl[(x+65536+127)>>8];
}
