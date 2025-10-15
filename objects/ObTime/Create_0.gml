depth = -16_000;

LunarEclipse = false;
LunarEclipsePeriod = 8;
SolarEclipse = false;
SolarEclipsePeriod = 20;
CurrentFrame = 0;

/// Time
Second = 0;
SecondK = 5;
Minute = 0;
Hour = 12;
Day = 1;
Night = 1;
Time = time.day;
ToNightK = 0;
DarkSurf = -1;
CurX = 0;

LightIntensity = 1;

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

active_popup = function(){
	PopupActive = true;
	PopupXS = 1 + choose(-0.75, 0.75);
	PopupYS = 1 + choose(-0.75, 0.75);
	PopupTo = 1;
	alarm[1] = 1;
}

give_reward = function(_reward, _spray = 5){
	var _x = ObCharacter.x + irandom_range(-_spray, _spray) * TILE_SIZE;
	var _y = ObCharacter.y + irandom_range(-_spray, _spray) * TILE_SIZE;
	instance_create_depth(_x, _y, 0, _reward);
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
			active_popup();
			
			if (SolarEclipse){
				SolarEclipse = false;
				give_reward(ObEssenceOfDay);
			}
			if (Day % SolarEclipsePeriod == 0){
				SolarEclipse = true;
			}
			
			ObController.save();
		}
		
		Time = time.night;
	}
	if (Hour >= 6 && Hour < 12){
		Time = time.morning;
	}
	if (Hour >= 12 && Hour < 18){
		if (Time != time.day){
			active_popup();
			
			Night++;
			
			if (LunarEclipse){
				LunarEclipse = false;
				give_reward(ObEssenceOfNight);
			}
			if (Night % LunarEclipsePeriod == 0){
				LunarEclipse = true;
			}
			
			ObController.save();
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
	
	repeat(20 * (_sec + ((_min * 60) + (_hour * 60) + (_day * 24 * 60)))){
		_ux = irandom_range(-_del, _del);
		_uy = irandom_range(-_del, _del);
		_xx = _cx + (_ux * TILE_SIZE);
		_yy = _cy + (_uy * TILE_SIZE);
		
		_obj = collision_point(_xx, _yy, ObGrowing, false, false);
		if (_obj){
			_obj.grow();
		}
		
		if (can_spawn() && point_distance(ObCharacter.x, ObCharacter.y, _xx, _yy) > 10 * TILE_SIZE){
			try_spawn(_xx, _yy);
		}
	}
	
	surface_update();
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
	
	if (!LunarEclipse && !SolarEclipse){
		draw_clear_alpha(c_black, ToNightK);
		gpu_set_blendmode(bm_subtract);
	
		draw_night_light();
	
		gpu_set_blendmode(bm_normal);
	}else{
		draw_clear_alpha(c_white, lerp(1, 1 - ToNightK, 0.72));
		
		draw_set_alpha(0.5);
		draw_night_light();
		draw_set_alpha(1);
	}
	
	surface_reset_target();
	
	if (point_distance(ObCamera.x, ObCamera.y, ObCharacter.x, ObCharacter.y) > 0.1){
		alarm[2] = 1;
	}
}

draw_night_light = function(){
	var _cam = view_camera[0];
	var _cx = camera_get_view_x(_cam);
	var _cy = camera_get_view_y(_cam);
	var _li = LightIntensity;

	with(ObBonfire){
		draw_sprite_ext(SpLight, 0, x - _cx, y - _cy, Intensivity * _li, Intensivity * _li, 0, c_white, random_range(0.9, 1));
	}
}

try_spawn = function(_xx, _yy){
	var _rand = irandom(1000);
	var _spawn_obj = noone;
	var _params = {};

	switch(Time){
		case time.night:
			if (_rand == 0 && !(LunarEclipse || SolarEclipse)){
				_spawn_obj = ObEvilEye;
			}else if (_rand == 0 && !irandom(3)){
				_spawn_obj = ObWhisper;
			}
		break;
		case time.morning:
			if (_rand == 0){
				_spawn_obj = ObHunter;
			}
		break;
		case time.day:
			if (!(LunarEclipse || SolarEclipse)){
				if (_rand >= 0 && _rand <= 8){
					var _tile = tilemap_get_at_pixel(ObWorld.Tiles, _xx, _yy);
		
					switch(_tile){
						case tile.slime_blue:
							_params = {image_index : 0};
						case tile.slime_green:
							if (_tile == tile.slime_green){
								_params = {image_index : 1};
							}
						case tile.slime_red:
							if (_tile == tile.slime_red){
								_params = {image_index : 2};
							}
						case tile.slime_yellow:
							if (_tile == tile.slime_yellow){
								_params = {image_index : 3};
							}
					
							_spawn_obj = ObSlime;
						break;
					}
				}
			}else{
				if (_rand == 10){
					_spawn_obj = ObWhisper;
				}
			}
		break;
		case time.evening:
			if (_rand >= 0 && _rand <= 80){
				if (collision_point(_xx, _yy, ObTree, true, true)){
					_xx += choose(-1, 1) * TILE_SIZE;
					_yy += choose(-1, 1) * TILE_SIZE;
					
					
					if (!collision_point(_xx, _yy, ObShadower, true, true)){
						_spawn_obj = ObShadower;
					}
				}
			}
		break;
	}

	if (_spawn_obj){
		instance_create_depth(_xx, _yy, 0, _spawn_obj, _params);
	}
}