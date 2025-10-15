ini_open("/settings.ini");
ini_write_real("global", "full_scr", window_get_fullscreen());
ini_write_real("global", "guide", Guide);
ini_close();