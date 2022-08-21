module bindbc.allegro5.bind.fixed;

alias al_fixed = int;

extern extern(C) {
	const(al_fixed) al_fixtorad_r;
	const(al_fixed) al_radtofix_r;
}
