var _x = camera_get_view_x(view_camera[0]) + xstart;
var _y = camera_get_view_y(view_camera[0]) + ystart;

x = _x;
y = _y;

draw_sprite(sprite_index, 0, x, y);

draw_set_font(global.FontRus);

var _len = array_length(DoCraft);
for(var i = 0; i < min(_len, MaxShow); i++){
	if (i == Select - Skip){
		draw_sprite(SpUIInventorySelectCell, 0, bbox_left + 14, bbox_top + 22 + (i * 20));
	}
	
	
	draw_sprite(object_get_sprite(global.Crafts[i + Skip][craft.item]), 0, bbox_left + 14, bbox_top + 21 + (i * 20));
}

draw_text(bbox_left + 8, bbox_top + 5, $"{TextCraft}");