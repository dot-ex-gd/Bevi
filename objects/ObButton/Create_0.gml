x = room_width / 2;

Font = global.FontDark;

Current = 0;
Buttons = [
	text_get("text_play"),
	text_get("text_keybinds"),
	text_get("text_exit")
];

var _len = array_length(Buttons);
Width = [];

for(var i = 0; i < _len; i++){
	Width[i] = string_width(Buttons[i]);
}

do_play = function(){
	instance_create_depth(x, y, -200, ObSelectButtons); 
	instance_destroy();
}
do_keybinds = function(){
	instance_create_depth(x, y, -200, ObKeybinds);
	instance_destroy();
}
do_exit = function(){
	game_end();
}
Do = [do_play, do_keybinds, do_exit];

depth = -200;

CanPress = false;
alarm[0] = KEY_DELAY;