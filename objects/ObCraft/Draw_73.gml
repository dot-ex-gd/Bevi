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

draw_sprite(sprite_index, 0, x, y);
draw_set_font(global.Font);

var _len = array_length(DoCraft);
var _max = min(_len, MaxShow);
var _x1 = bbox_left + 14;
var _y1 = bbox_top + 22;
var _entry_index;
var _item;
var _rec;
var _len2;
var _comp_obj;
var _comp_amount;
var _comp_x_offset;
var _item_y;

for(var i = 0; i < _max; i++){
	_entry_index = i + Skip;
	
	if (i == Select - Skip){
		if (DoCraft[_entry_index]){
			draw_sprite(SpUICraftSelectCell, 0, _x1, _y1 + (i * 20));
		} else {
			draw_sprite(SpUIInventorySelectCell, 0, _x1, _y1 + (i * 20));
		}
	}
	
	_item = global.Crafts[_entry_index];
	draw_sprite(_item[craft.struct][$ "InvSprite"], 0, _x1, _y1 + (i * 20));
	
	_rec = _item[craft.rec];
	_len2 = array_length(_rec);
	for(var j = 0; j < _len2; j += 2){
		_comp_obj = _rec[j];
		_comp_amount = _rec[j + 1];
		_comp_x_offset = 21 + (20 * j / 2);
		_item_y = _y1 + (i * 20);
		
		draw_sprite(object_get_sprite(_comp_obj), 0, _x1 + _comp_x_offset, _item_y);
		draw_text(_x1 + _comp_x_offset + 4, _item_y + 4, _comp_amount);
		
		if (j == _len2 - 2){
			draw_set_halign(fa_right);
			draw_text(bbox_right - 6, _item_y + 4, string(_item[craft.struct][$ "Weight"]) + TextKG);
			draw_set_halign(fa_left);
		}
	}
}

draw_text(bbox_left + 8, bbox_top + 5, TextCraft);