draw_set_font(Font);
var _ydel = 16;
var _len = array_length(Buttons);

draw_set_halign(fa_center);

for(var i = 0; i < _len; i++){
	draw_text(x, y + (_ydel * i), $"{(i == Current) ? ">" : ""}{Buttons[i]}{(i == Current) ? "<" : ""}");
}

if (CanPress){
	if (get_pressed(ObController.KeybindMoveDown)){
		Current++;
		
		CanPress = false;
		alarm[0] = KEY_DELAY;
	}
	if (get_pressed(ObController.KeybindMoveUp)){
		Current--;
		
		CanPress = false;
		alarm[0] = KEY_DELAY;
	}
}
Current = clamp(Current, 0, _len - 1);

if (keyboard_check_pressed(vk_enter) && !keyboard_check(vk_alt)){
	Do[Current]();
}

draw_set_halign(fa_left);