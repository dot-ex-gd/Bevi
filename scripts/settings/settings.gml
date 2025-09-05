enum languages{
	eng,
	rus
}

#macro INV_WDEL	160
#macro INV_HDEL	88

#macro DEPTH	depth = -y div TILE_SIZE
#macro MENEMIES	200

#macro CHUNK_SIZE	64 * TILE_SIZE

var _rus_let = "йцукенгшщзхъфывапролджэячсмитьбю";
var _eng_let = "qwertyuiopasdfghjklzxcvbnm";
var _dig = "1234567890";
var _spec = "!?:/().,;><*'\"";

global.FontRus = font_add_sprite_ext(SpFontRussian, $"{_rus_let}{_dig}{_spec}ё", 1, -1);
global.FontEng = font_add_sprite_ext(SpFontEnglish, $"{_eng_let}{_dig}{_spec}", 1, -1);

global.Language = languages.rus;

function get_language_font(){
	return (global.Language == languages.rus ? global.FontRus : global.FontEng);
}