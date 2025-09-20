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

draw_set_halign(fa_center);

draw_text(x, y - 16, $"{Info}");

var _hw, _len = array_length(TextBinds), _ydel = 16;
for(var i = 0; i < min(_len, MaxShow); i++){
	_hw = Width[i + Skip] + string_width(Binds[i + Skip]);
	
	_hw /= sprite_get_width(SpButtonBack);
	_hw += 2;
	
	draw_sprite_ext(SpButtonBack, Current - Skip == i, x, y + 16 + (_ydel * i), _hw, 1, 0, c_white, 1);
	draw_set_color(Valid[i + Skip] ? c_white : #E68787);
	
	draw_text(x, y + 16 + (_ydel * i), $"{Current - Skip == i ? ">" : ""}{TextBinds[i + Skip]}: {Binds[i + Skip]}{Current - Skip == i ? "<" : ""}");
	
	draw_set_color(c_white);
}

draw_set_halign(fa_left)

if (!Change){
	ChangeText = "";
	
	if (CanPress){
		if (get_pressed(ObController.KeybindMoveDown)){
			Current ++;
			Skip ++;
			
			CanPress = false;
			alarm[0] = KEY_DELAY;
		}
		if (get_pressed(ObController.KeybindMoveUp)){
			Current --;
			Skip --;
			
			CanPress = false;
			alarm[0] = KEY_DELAY;
		}
	
		Current = clamp(Current, 0, _len - 1);
		Skip = clamp(Skip, 0, _len - MaxShow);
		Skip = max(0, Skip);
	
		if (keyboard_check_pressed(vk_escape)){
			instance_destroy();
			instance_create_depth(x, y, -200, ObButton);
		}
	}
}else{
	do_write();
}

if (keyboard_check_pressed(vk_enter) && !keyboard_check(vk_alt)){
	keyboard_lastchar = "";
	Change = !Change;
}