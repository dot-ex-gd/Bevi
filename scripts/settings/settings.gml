enum languages{
	eng,
	rus
}

#macro INV_WDEL	160
#macro INV_HDEL	88

#macro DEPTH	depth = -y div TILE_SIZE
#macro MENEMIES	200

#macro CHUNK_SIZE	24
#macro ENTITY_ACTIVE_DISTANCE	24

var _rus_let = "йцукенгшщзхъфывапролджэячсмитьбю";
var _eng_let = "qwertyuiopasdfghjklzxcvbnm";
var _dig = "1234567890";
var _spec = "!?:/().,;><^*'\"";

#macro TEXT_YDEL	4

global.FontDark = font_add_sprite_ext(SpFontDark, $"{_eng_let}{_rus_let}{_dig}{_spec}ё+-", 1, -1);
global.FontLight = font_add_sprite_ext(SpFontLight, $"{_eng_let}{_rus_let}{_dig}{_spec}ё+-", 1, -1);


ini_open("/settings.ini");
global.Language = ini_read_real("global", "lang", languages.eng);
window_set_fullscreen(ini_read_real("global", "full_scr", false));
ini_close();


#macro SCREEN_W	320
#macro SCREEN_H	180
display_set_gui_size(SCREEN_W, SCREEN_H);