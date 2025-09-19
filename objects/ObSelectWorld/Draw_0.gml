draw_set_font(Font);
var _len = array_length(Buttons);

draw_set_halign(fa_center);
for(var i = 0; i < min(_len, MaxShow); i++){
	draw_text(x, y + (12 * i), $"{Select - Skip == i ? ">" : ""}{Buttons[i + Skip]}{Select - Skip == i ? "<" : ""}");
}
draw_set_halign(fa_left);

if (keyboard_check_pressed(ord("S"))){
	Select ++;
	Select = clamp(Select, 0, _len - 1);
	
	Skip ++;
}
if (keyboard_check_pressed(ord("W"))){
	Select --;
	Select = clamp(Select, 0, _len - 1);
	
	Skip --;
}

Skip = clamp(Skip, 0, _len - MaxShow);
Skip = max(0, Skip);

if (CanPress){
	var _hw, _hh;
	for(var i = 0; i < min(_len, MaxShow); i++){
		_hw = Width[i + Skip] / 2;
		_hh = Height[i + Skip] / 2;

		if (point_in_rectangle(mouse_x, mouse_y, x - _hw, y + (12 * i) - _hh, x + _hw, y + (12 * i) + _hh)){
			Select = i + Skip;
	
			if (mouse_check_button_released(mb_left)){
				load();
			}
		}
	}

	if ((keyboard_check_pressed(vk_enter) && !keyboard_check(vk_alt))){
		load();
	}
}


CanPress = true;