var _x = camera_get_view_x(view_camera[0]) + xstart;
var _y = camera_get_view_y(view_camera[0]) + ystart;

x = _x;
y = _y;

draw_sprite(sprite_index, 0, x, y);

var _width = sprite_width;
var _sw = sprite_width;
var _text = "";
var _add_text = "";
switch(BarIndex){
	case 1:
		_width = (ObCharacter.Xp / ObCharacter.NeedXp) * _sw;
		if (XpAdd != 0){
			_add_text += $"+{XpAdd}";
		}
		
		_text = $"{TextXp}:{floor(ObCharacter.Xp)}{_add_text}/{floor(ObCharacter.NeedXp)}";
	break;
	case 2:
		_width = (ObCharacter.Health / ObCharacter.MaxHealth) * _sw;
		if (HpAdd != 0){
			_add_text += $"+{HpAdd}";
		}
		
		_text = $"{TextHp}:{floor(ObCharacter.Health)}{_add_text}/{floor(ObCharacter.MaxHealth)}";
	break;
	case 3:
		_width = (ObCharacter.Mana / ObCharacter.MaxMana) * _sw;
		if (ManaAdd != 0){
			_add_text += $"+{ManaAdd}";
		}
		
		_text = $"{TextMana}:{floor(ObCharacter.Mana)}{_add_text}/{floor(ObCharacter.MaxMana)}";
	break;
}


draw_set_halign(fa_center);
draw_text(x, y + 6, _text);
draw_set_halign(fa_left);

draw_sprite_part(sprite_index, BarIndex, 0, 0, _width, sprite_height, bbox_left, bbox_top);

HpAdd = 0;
XpAdd = 0;
ManaAdd = 0;