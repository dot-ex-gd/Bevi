depth = -16_000;

/// Time
Second = 0;
SecondK = 5;
Minute = 0;
Hour = 12;
Day = 0;
Time = time.day;
ToNightK = 0;
DarkSurf = -1;
CurX = 0;

/// Popup
PopupActive = false;
PopupY = 24;
PopupXS = 0.1;
PopupYS = 0.1;
PopupSpringAtt = 0;
PopupTo = 1;

enum time{
	morning,
	day,
	evening,
	night,
}

time_go = function(_sec, _min = 0, _hour = 0, _day = 0){
	var _p = lerp(0, (_sec + ((_min * 60) + (_hour * 60) + (_day * 24 * 60))), 0.001);
	Second += _sec;
	Minute += _min;
	Hour += _hour;
	Day += _day;
	
	while(Second >= SecondK){
		Minute++;
		Second -= SecondK;
	}
	while(Minute >= 60){
		Hour++;
		Minute -= 60;
	}
	while(Hour >= 24){
		Day++;
		Hour -= 24;
	}
	
	if (Hour >= 0 && Hour < 6){
		if (Time != time.night){
			PopupActive = true;
			PopupXS = 1 + choose(-0.75, 0.75);
			PopupYS = 1 + choose(-0.75, 0.75);
			PopupTo = 1;
			alarm[1] = 1;
		}
		
		Time = time.night;
	}
	if (Hour >= 6 && Hour < 12){
		Time = time.morning;
	}
	if (Hour >= 12 && Hour < 18){
		if (Time != time.day){
			PopupActive = true
			PopupXS = 1 + choose(-0.75, 0.75);
			PopupYS = 1 + choose(-0.75, 0.75);
			PopupTo = 1;
			alarm[1] = 1;
		}
		
		Time = time.day;
	}
	if (Hour >= 18 && Hour < 24){
		Time = time.evening;
	}
	
	switch(Time){
		case time.night:
			ToNightK = lerp(ToNightK, 1, 0.04 + _p);
		break;
		case time.morning:
			ToNightK = lerp(ToNightK, 0.5, 0.02 + _p);
		break;
		case time.day:
			ToNightK = lerp(ToNightK, 0, 0.04 + _p);
		break;
		case time.evening:
			ToNightK = lerp(ToNightK, 0.5, 0.02 + _p);
		break;
	}
	
	var _ux = 0, _uy = 0, _del = 20, _obj;
	var _cx = ObCharacter.x, _cy = ObCharacter.y;
	var _xx, _yy;
	
	var _grow = 0, _summoned = 0;
	
	repeat(20 * (_sec + ((_min * 60) + (_hour * 60) + (_day * 24 * 60)))){
		_ux = irandom_range(-_del, _del);
		_uy = irandom_range(-_del, _del);
		_xx = _cx + (_ux * TILE_SIZE);
		_yy = _cy + (_uy * TILE_SIZE);
		
		_obj = collision_point(_xx, _yy, ObGrowing, false, false);
		if (_obj){
			_obj.grow();
			_grow++;
		}
		
		if (Time == time.night && !irandom(1000 * SecondK) && can_spawn()){
			if (point_distance(ObCharacter.x, ObCharacter.y, _xx, _yy) > 10 * TILE_SIZE){
				instance_create_depth(_xx, _yy, 0, ObEvilEye);
				_summoned++;
			}
		}
		if (Time == time.morning && !irandom(1000 * SecondK) && can_spawn()){
			if (point_distance(ObCharacter.x, ObCharacter.y, _xx, _yy) > 10 * TILE_SIZE){
				instance_create_depth(_xx, _yy, 0, ObHunter);
				_summoned++;
			}
		}
	}
	
	surface_update();
	show_debug_message($">>>> Time <<<<");
	show_debug_message($">> Time: {Time}");
	show_debug_message($">> Time k: {_p}");
	show_debug_message($">> Steps simulated: {20 * (_sec + ((_min * 60) + (_hour * 60) + (_day * 24 * 60)))}");
	show_debug_message($">> Time pass: s: {_sec} m: {_min} h: {_hour} d: {_day}");
	show_debug_message($">> Grow: {_grow}");
	show_debug_message($">> Summoned: {_summoned}");
	show_debug_message("\n");
}

surface_update = function(){
	if (ToNightK == 0) { exit; }
	var _cam = view_camera[0];
	var _cx = camera_get_view_x(_cam);
	var _cy = camera_get_view_y(_cam);
	
	if (!surface_exists(DarkSurf)){
		var _cw = camera_get_view_width(_cam);
		var _ch = camera_get_view_height(_cam);
		DarkSurf = surface_create(_cw, _ch, surface_rgba8unorm);
	}
	
	surface_set_target(DarkSurf);
	draw_clear_alpha(c_black, ToNightK);
	gpu_set_blendmode(bm_subtract);
	
	//draw_sprite_ext(SpLight, 0, ObCharacter.x - _cx, ObCharacter.y - _cy, 0.25, 0.25, 0, c_white, random_range(0.9, 1));
	draw_sprite_ext(SpLight, 0, ObCharacter.x - _cx, ObCharacter.y - _cy, 2, 2, 0, c_white, random_range(0.9, 1));
	
	with(ObBonfire){
		draw_sprite_ext(SpLight, 0, x - _cx, y - _cy, Intensivity, Intensivity, 0, c_white, random_range(0.9, 1));
	}
	
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	
	if (point_distance(ObCamera.x, ObCamera.y, ObCharacter.x, ObCharacter.y) > 0.1){
		alarm[2] = 1;
	}
}