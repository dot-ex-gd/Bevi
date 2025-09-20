var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);
var _cam_w = camera_get_view_width(view_camera[0]);
var _cam_h = camera_get_view_height(view_camera[0]);
x = _cam_x + xstart;
y = _cam_y + ystart;

BackAlpha = lerp(BackAlpha, 0.55, 0.1);

draw_set_alpha(BackAlpha);
draw_set_color(c_black);
draw_rectangle(_cam_x, _cam_y, _cam_x + _cam_w, _cam_y + _cam_h, false);
draw_set_color(c_white);
draw_set_alpha(1);

draw_set_font(Font);
var _len = array_length(Buttons);
var _ydel = 16;

draw_set_halign(fa_center);
var _hw;
for(var i = 0; i < min(_len, MaxShow); i++){
	_hw = Width[i];
	
	_hw /= sprite_get_width(SpButtonBack);
	_hw += 2;
	
	draw_sprite_ext(SpButtonBack, Select - Skip == i + Skip, x, y + (_ydel * i), _hw, 1, 0, c_white, 1);
	draw_text(x, y + (_ydel * i), $"{Select - Skip == i ? ">" : ""}{Buttons[i + Skip]}{Select - Skip == i ? "<" : ""}");
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

		if (point_in_rectangle(mouse_x, mouse_y, x - _hw, y + (_ydel * i) - _hh, x + _hw, y + (_ydel * i) + _hh)){
			Select = i + Skip;
	
			if (mouse_check_button_released(mb_left)){
				load();
			}
		}
	}

	if ((keyboard_check_pressed(vk_enter) && !keyboard_check(vk_alt))){
		load();
	}
	if (keyboard_check_pressed(vk_escape)){
		instance_destroy();
		
		instance_create_depth(x, y, depth, ObSelectButtons);
	}
}


CanPress = true;