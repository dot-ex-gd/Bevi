depth = -16_000;

/// Time
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

time_go = function(_min, _hour = 0, _day = 0){
	var _p = (_min + (_hour * 60) + (_day * 24 * 60)) / (30);
	Minute += _min;
	Hour += _hour;
	Day += _day;
	
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
}

surface_update = function(){
	var _cam = view_camera[0];
	var _cx = camera_get_view_x(_cam);
	var _cy = camera_get_view_y(_cam);

	surface_set_target(DarkSurf);
	draw_clear_alpha(c_black, ToNightK);
	gpu_set_blendmode(bm_subtract);
	
	draw_set_alpha(random_range(0.9, 1));
	
	draw_sprite(SpLight, 0, ObCharacter.x - _cx, ObCharacter.y - _cy);
	
	draw_set_alpha(1);
	
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
}