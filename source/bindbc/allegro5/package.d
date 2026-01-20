module bindbc.allegro5;

public import bindbc.allegro5.config, bindbc.allegro5.bind;

static if (!staticBinding) {
	public import bindbc.allegro5.dynload;
}
