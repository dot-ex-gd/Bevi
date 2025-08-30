var _x = camera_get_view_x(view_camera[0]) + xstart;
var _y = camera_get_view_y(view_camera[0]) + ystart;

x = _x;
y = _y;

draw_sprite(sprite_index, 0, x, y);

draw_set_font(global.FontRus);

var _len = array_length(ObCharacter.Inventory);
var _x = 0, _x1 = bbox_left + 14;
var _y = 0, _y1 = bbox_top + 22;
var _slot;
for(var i = 0; i < min(_len, MaxShow); i++){
	if (i == Select - Skip){
		draw_sprite(SpUIInventorySelectCell, 0, _x1 + (_x * 20), _y1 + (_y * 20));
	}
	
	if (i + Skip < _len){
		_slot = ObCharacter.Inventory[i + Skip];
		
		if (_slot){
			draw_sprite(_slot[$ "InvSprite"], 0, _x1 + (_x * 20), bbox_top + 21 + (_y * 20));
		}
	}
	
	_x++;
	if (_x == 3) { _y++; _x = 0; }
}

if (ObCharacter.InArm){
	draw_sprite(ObCharacter.InArm[$ "InvSprite"], 0, _x1 + (20 * 4) + 4, _y1 + 21);
}

draw_text(bbox_left + 8, bbox_bottom - 6, $"{TextWeight}: {ObCharacter.InventoryWeight}{TextKG}/{ObCharacter.InventoryMaxWeight}{TextKG}");
draw_text(bbox_left + 8, bbox_top + 5, $"{TextInventory}");