draw_set_font(global.languageFont);

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

var _cells = array_length(canCraft);
var _left_border = 14;
var _top_border = 22;
var _x_offset = bbox_left + _left_border;
var _y_offset = bbox_top + _top_border;
var _inventory_cell_size = 20;
var _cell_y_offset;
var _draw_cell_y_offset = -8;
var _draw_cell_item_y_offset = -7;

for(var _cell = 0; _cell < min(_cells, cellShowMax); _cell++){
	_cell_y_offset = _y_offset + (_cell * _inventory_cell_size);
	
	if (_cell = cellSelect - cellSkip){
		if (canCraft[_cell + cellSkip][1]){
			draw_sprite(spr_inventory_crafts_cell_can, 0, _x_offset, _cell_y_offset + _draw_cell_y_offset);
		}else{
			draw_sprite(spr_inventory_crafts_cell, 0, _x_offset, _cell_y_offset + _draw_cell_y_offset);
		}
	}
	
	var _craft_item = global.crafts[canCraft[_cell + cellSkip][0]];
	draw_sprite(_craft_item[craft.struct][$ "invSprite"], 0, _x_offset, _cell_y_offset + _draw_cell_item_y_offset);
	
	var _recipe = _craft_item[craft.recipe];
	var _recipe_len = array_length(_recipe);
	
	for(var _recipe_ind = 0; _recipe_ind < _recipe_len; _recipe_ind += 2){
		var _recipe_item = _recipe[_recipe_ind];
		var _recipe_item_count = _recipe[_recipe_ind + 1];
		var _recipe_x_offset = _inventory_cell_size + (_inventory_cell_size * (_recipe_ind / 2));
		
		draw_sprite(object_get_sprite(_recipe_item), 0, _x_offset + _recipe_x_offset, _cell_y_offset + _draw_cell_item_y_offset);
		draw_text(_x_offset + _recipe_x_offset, _cell_y_offset + _draw_cell_item_y_offset, _recipe_item_count);
	}
}