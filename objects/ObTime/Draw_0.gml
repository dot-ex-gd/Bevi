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

draw_sprite(SpTimeBar, 0, _tx, _ty);

var _w = sprite_get_width(SpTimeBar);
CurX = lerp(CurX, (-_w / 2) + (Hour * (_w / 24) + (Minute / 60)), 0.1);
draw_sprite(SpTimePointer, 0, _tx + CurX, _ty - 6);


if (PopupActive){
	var _ind = Time == time.night;
	
	draw_sprite_ext(SpDN, _ind, _cx + _cw / 2, _cy + PopupY, PopupXS, PopupYS, sin(current_time / 500) * 4, c_white, 1);
}