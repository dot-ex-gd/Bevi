var _hw = Width / 2;
var _hh = Height / 2;

if (point_in_rectangle(mouse_x, mouse_y, x - _hw, y - _hh, x + _hw, y + _hh)){
	if (mouse_check_button_released(mb_left)){
		Do();
	}
	
	with(ObButton){
		Number = true;
	}
	Number = false;
}

if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))){
	Number = !Number;
}
if (keyboard_check_pressed(vk_enter) && !keyboard_check(vk_alt) && !Number){
	Do();
}