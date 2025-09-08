draw_set_font(Font);
var _len = array_length(Buttons);

draw_set_halign(fa_center);
for(var i = 0; i < _len; i++){
	draw_text(x, y + (12 * i), $"{Select == i ? ">" : ""}{Buttons[i]}{Select == i ? "<" : ""}");
}
draw_set_halign(fa_left);

if (keyboard_check_pressed(ord("S"))){
	Select ++;
	Select = clamp(Select, 0, _len - 1);
}
if (keyboard_check_pressed(ord("W"))){
	Select --;
	Select = clamp(Select, 0, _len - 1);
}


if (CanPress){
	var _hw, hh;
	for(var i = 0; i < _len; i++){
		_hw = Width[i] / 2;
		_hh = Height[i] / 2;
	
		if (point_in_rectangle(mouse_x, mouse_y, x - _hw, y + (12 * i) - _hh, x + _hw, y + (12 * i) + _hh)){
			Select = i;
		
			if (mouse_check_button_released(mb_left)){
				Do[Select]();
			}
		}
	}

	if ((keyboard_check_pressed(vk_enter) && !keyboard_check(vk_alt))){
		Do[Select]();
	}
}
CanPress = true;