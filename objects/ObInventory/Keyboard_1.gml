var _len = array_length(ObCharacter.Inventory);
var _dir = 0;

switch(keyboard_lastchar){
	case "q":
		ObCharacter.inventory_throw(Select);
	break;
	case "s":
		Select += 3;
		_dir = 3;
	break;
	case "w":
		Select -= 3;
		_dir = -3;
	break;
	case "a":
		Select--;
		_dir = -1;
	break;
	case "d":
		Select++;
		_dir = 1;
	break;
	
	case "e":
		var _item = ObCharacter.Inventory[Select];
		if (_item){
			
			if (item_find_flag(_item, flags.weapon)){
				ObCharacter.equip_inarm_add(Select, _item);
			}
			if (item_find_flag(_item, flags.placeble)){
				ObCharacter.interactive_inarm(_item, interactive_type.replace);
				ObCharacter.inventory_delete(Select, -1);
			}
			if (item_find_flag(_item, flags.remeltable)){
				ObCharacter.interactive_inarm(_item, interactive_type.melt);
				ObCharacter.inventory_delete(Select, -1);
			}
		}
	break;
	case "E":
		var _item = ObCharacter.InArm;
		if (_item){
			var _att = ObCharacter.inventory_add(_item);
			
			if (_att){
				ObCharacter.InArm = noone;
			}
		}
	break;
}

Select = clamp(Select, 0, _len - 1);

if (Select >= MaxShow){
	if (_dir > 0){
		Skip += _dir;
	}
}
if (Select <= MaxShow){
	if (_dir < 0){
		Skip += _dir;
	}
}

Skip = clamp(Skip, 0, _len - MaxShow);
Skip = max(0, Skip);