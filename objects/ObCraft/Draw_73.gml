var _x = camera_get_view_x(view_camera[0]) + xstart;
var _y = camera_get_view_y(view_camera[0]) + ystart;

x = _x;
y = _y;

draw_sprite(sprite_index, 0, x, y);

draw_set_font(global.FontRus);

var _len = array_length(Textes);
for(var i = 0; i < min(_len, MaxShow); i++){
	draw_text(bbox_left + 12, bbox_top + 10 + (12 * i), $"{(Select - Skip == i) ? ">" : ""}{Textes[i + Skip]}");
}