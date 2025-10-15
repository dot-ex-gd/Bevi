draw_self();

var _text = string_copy(MonologueText, 0, MonologueTextLet);

var _len = string_length(MonologueText);
if (MonologueTextLet <= _len){
	MonologueTextLet += MonologueSpeed;
	spring(0.25);
}else{
	if (!alarm[0]){
		alarm[0] = 60 + (_len * 1.75);
	}
}

draw_set_halign(fa_center);
draw_text_ext(x, y - 24, _text, 8, SCREEN_W - 96);
draw_set_halign(fa_left);