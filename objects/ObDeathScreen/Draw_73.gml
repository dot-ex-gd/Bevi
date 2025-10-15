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

draw_set_halign(fa_center);
draw_text(_cam_x + _cam_w / 2, _cam_y + _cam_h / 2, DeathText);
draw_set_halign(fa_left);