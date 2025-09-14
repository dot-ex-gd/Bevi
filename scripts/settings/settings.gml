enum languages{
	eng,
	rus
}

#macro INV_WDEL	160
#macro INV_HDEL	88

#macro DEPTH	depth = -y div TILE_SIZE
#macro MENEMIES	200

#macro CHUNK_SIZE	24
#macro ENTITY_ACTIVE_DISTANCE	34

var _rus_let = "йцукенгшщзхъфывапролджэячсмитьбю";
var _eng_let = "qwertyuiopasdfghjklzxcvbnm";
var _dig = "1234567890";
var _spec = "!?:/().,;><*'\"";

global.Font = font_add_sprite_ext(SpFont, $"{_eng_let}{_rus_let}{_dig}{_spec}ё+-", 1, -1);
global.Language = languages.rus;