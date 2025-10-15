var _cam = view_camera[0];
var _cx = camera_get_view_x(_cam);
var _cy = camera_get_view_y(_cam);
var _cw = camera_get_view_width(_cam);
var _ch = camera_get_view_height(_cam);

if (!surface_exists(DarkSurf)){
	DarkSurf = surface_create(_cw, _ch, surface_rgba8unorm);
	surface_update();
}
draw_surface(DarkSurf, _cx, _cy);

var _tx = _cx + _cw / 2;
var _ty = _cy + 10;

draw_sprite(SpTimeBar, (LunarEclipse || SolarEclipse), _tx, _ty);

var _w = sprite_get_width(SpTimeBar);
CurX = lerp(CurX, (-_w / 2) + (Hour * (_w / 24) + (Minute / 60)), 0.1);
draw_sprite(SpTimePointer, (LunarEclipse || SolarEclipse), _tx + CurX, _ty - 6);


if (PopupActive){
	var _ind = Time == time.night;
	
	if (LunarEclipse && SolarEclipse){
		draw_sprite_ext(SpDN, 4, _cx + _cw / 2, _cy + PopupY, PopupXS, PopupYS, sin(current_time / 500) * 4, c_white, 1);
	}else{
		draw_sprite_ext(SpDN, _ind + ((LunarEclipse || SolarEclipse) * 2), _cx + _cw / 2, _cy + PopupY, PopupXS, PopupYS, sin(current_time / 500) * 4, c_white, 1);
	}
}

if (SolarEclipse || LunarEclipse){
	if (CurrentFrame % (10 - SolarEclipse - LunarEclipse) == 0){
		repeat(irandom_range(1, 5) + ((SolarEclipse + LunarEclipse) * 5)){
			particle_create(_tx + irandom_range(-15, 15), _ty + irandom_range(-5, 5), SpEclipseParticle, [random_range(-0.1, 0.1), -random_range(0.25, 0.5)], random_range(0.05, 0.1));
		}
		
		CurrentFrame = 1;
	}
	
	CurrentFrame ++;
}