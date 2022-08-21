module bindbc.allegro5;

public import bindbc.allegro5.config, bindbc.allegro5.bind;

version (BindAllegro5_Static) { }
else {
	public import bindbc.allegro5.dynload;
}
