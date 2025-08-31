var _x = camera_get_view_x(view_camera[0]) + xstart;
var _y = camera_get_view_y(view_camera[0]) + ystart;

x = _x;
y = _y;

draw_sprite(sprite_index, 0, x, y);

draw_set_font(global.FontRus);

var _len = array_length(DoCraft);
var i = 0, j = 0;
var _item;
var _x1 = bbox_left + 14, _y1 = bbox_top + 22, _len2;

for(var i = 0; i < min(_len, MaxShow); i++){
	if (i == Select - Skip){
		if (DoCraft[i + Skip]){
			draw_sprite(SpUICraftSelectCell, 0, _x1, _y1 + (i * 20));
		}else{
			draw_sprite(SpUIInventorySelectCell, 0, _x1, _y1 + (i * 20));
		}
	}
	
	_item = global.Crafts[i + Skip];
	draw_sprite(_item[craft.struct][$ "InvSprite"], 0, _x1, _y1 + (i * 20));
	
	_len2 = array_length(_item[craft.rec]);
	for(var j = 0; j < _len2; j += 2){
		draw_sprite(object_get_sprite(_item[craft.rec][j]), 0, _x1 + (21 + (20 * j / 2)), _y1 + (i * 20));
		draw_text(_x1 + (21 + (20 * j / 2) + 4), _y1 + (i * 20) + 4, global.Crafts[i + Skip][craft.rec][j + 1]);
		
		if (j == _len2 - 2){
			draw_text(_x1 + (21 + (20 * (j + 1) / 2) + 4), _y1 + (i * 20) + 4, $"{global.Crafts[i + Skip][craft.struct][$ "Weight"]}{TextKG}");
		}
	}
}

draw_text(bbox_left + 8, bbox_top + 5, $"{TextCraft}");