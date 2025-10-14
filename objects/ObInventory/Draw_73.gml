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

draw_set_font(global.FontLight);

var _len = array_length(ObCharacter.Inventory);
var _x = 0, _x1 = bbox_left + 14;
var _y = 0, _y1 = bbox_top + 22;
var _slot;
for(var i = 0; i < min(_len, MaxShow); i++){
	if (i == Select - Skip){
		draw_sprite(SpUIInventorySelectCell, 0, _x1 + (_x * 20), _y1 + (_y * 20));
		
		draw_set_halign(fa_center);
		draw_text(bbox_right + 48, bbox_top + 5, text_get(ObCharacter.Inventory[i + Skip][$ "Name"]));
		draw_text_ext(bbox_right + 48, bbox_top + 16, text_get(ObCharacter.Inventory[i + Skip][$ "Name"] + "_dsc"), 8, 100);
		draw_set_halign(fa_left);
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
if (ObCharacter.OnHead){
	draw_sprite(ObCharacter.OnHead[$ "InvSprite"], 0, _x1 + (20 * 3) + 4, _y1);
}
if (ObCharacter.OnBody){
	draw_sprite(ObCharacter.OnBody[$ "InvSprite"], 0, _x1 + (20 * 3) + 4, _y1 + (20 * 1));
}
if (ObCharacter.OnLeggings){
	draw_sprite(ObCharacter.OnLeggings[$ "InvSprite"], 0, _x1 + (20 * 3) + 4, _y1 + (20 * 2));
}
if (ObCharacter.OnFoot){
	draw_sprite(ObCharacter.OnFoot[$ "InvSprite"], 0, _x1 + (20 * 3) + 4, _y1 + (20 * 3));
}

draw_set_halign(fa_center);

draw_text(x, bbox_bottom - 6, $"{TextWeight}: {ObCharacter.InventoryWeight}{TextKG}/{ObCharacter.InventoryMaxWeight}{TextKG}\n{TextProtection}: {ObCharacter.Protection}");
draw_text(x, bbox_top + 5, $"{TextInventory}");

draw_set_halign(fa_left);