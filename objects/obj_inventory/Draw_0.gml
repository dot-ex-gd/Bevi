var _cam = view_camera[0];
var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);
var _cam_w = camera_get_view_width(_cam);
var _cam_h = camera_get_view_height(_cam);
x = _cam_x + (_cam_w / 2);
y = _cam_y + (_cam_h / 2);

backAlpha = lerp(backAlpha, BACK_ALPHA, BACK_ALPHA_SPEED);

draw_set_alpha(backAlpha);
	draw_set_color(c_black);
		draw_rectangle(_cam_x, _cam_y, _cam_x + _cam_w, _cam_y + _cam_h, false);
	draw_set_color(c_white);
draw_set_alpha(1);

draw_sprite(sprite_index, 0, x, y);

var _cells = array_length(obj_character.inventory);
var _left_border = 14;
var _top_border = 22;
var _x_offset = bbox_left + _left_border;
var _y_offset = bbox_top + _top_border;
var _inventory_cell_size = 20;
var _cell_x = 0, _cell_y = 0;
var _cell_item;
var _cell_x_offset, _cell_y_offset;
var _draw_cell_y_offset = -8;
var _draw_cell_item_y_offset = -7;

for(var _cell = 0; _cell < min(_cells, cellShowMax); _cell++){
	if (_cell + cellSkip < _cells){
		_cell_x_offset = _x_offset + (_cell_x * _inventory_cell_size);
		_cell_y_offset = _y_offset + (_cell_y * _inventory_cell_size);
		
		if (_cell == cellSelect - cellSkip){
			draw_sprite(spr_inventory_cell, 0, _cell_x_offset, _cell_y_offset + _draw_cell_y_offset);
		}
		
		_cell_item = obj_character.inventory[_cell + cellSkip];
		
		if (_cell_item){
			draw_sprite(_cell_item[$ "invSprite"], 0, _cell_x_offset, _cell_y_offset + _draw_cell_item_y_offset);
		}
	}
	
	_cell_x++;
	if (_cell_x % 3 == 0) { _cell_y++; _cell_x = 0; }
}