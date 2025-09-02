var _x = camera_get_view_x(view_camera[0]) + xstart;
var _y = camera_get_view_y(view_camera[0]) + ystart;

x = _x;
y = _y;

draw_sprite(sprite_index, 0, x, y);

var _width = sprite_width;
var _sw = sprite_width;
switch(BarIndex){
	case 1:
		_width = (ObCharacter.Xp / ObCharacter.NeedXp) * _sw;
	break;
	case 2:
		_width = (ObCharacter.Health / ObCharacter.MaxHealth) * _sw;
	break;
	case 3:
		_width = (ObCharacter.Mana / ObCharacter.MaxMana) * _sw;
	break;
}

draw_sprite_part(sprite_index, BarIndex, 0, 0, _width, sprite_height, bbox_left, bbox_top);