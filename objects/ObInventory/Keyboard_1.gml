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
		if (Select < 0 || ObCharacter.InteractiveInArm != noone) { exit; }
        
		var _item = ObCharacter.Inventory[Select];
		if (_item){
			var _del = false;
			
			if (item_find_flag(_item, flags.weapon)){
				ObCharacter.equip_inarm_add(Select, _item);
				//_del = true;
			}
			if (item_find_flag(_item, flags.armor)){
				if (item_find_flag(_item, flags.head)){
					ObCharacter.equip_onhead_add(Select, _item);
				}
				if (item_find_flag(_item, flags.body)){
					ObCharacter.equip_onbody_add(Select, _item);
				}
				if (item_find_flag(_item, flags.leggins)){
					ObCharacter.equip_onleggins_add(Select, _item);
				}
				if (item_find_flag(_item, flags.boots)){
					ObCharacter.equip_onfoot_add(Select, _item);
				}
				
				ObCharacter.protection_update();
			}
			
			if (item_find_flag(_item, flags.food)){
				var _food = _item[$ "Food"];
				var _len = array_length(_food);
				
				for(var i = 0; i < _len; i += 2){
					if (_food[i] == food_stats.hp) { ObCharacter.health_add(_food[i + 1]); }
					if (_food[i] == food_stats.mn) { ObCharacter.mana_add(_food[i + 1]); }
					if (_food[i] == food_stats.xp) { ObCharacter.xp_add(_food[i + 1]); }
				}
				
				_del = true;
			}
			if (item_find_flag(_item, flags.placeble)){
				ObCharacter.interactive_inarm(_item, interactive_type.replace);
				_del = true;
			}
			if (item_find_flag(_item, flags.remeltable)){
				ObCharacter.interactive_inarm(_item, interactive_type.melt);
				_del = true;
			}
			
			if (_del) { ObCharacter.inventory_delete(Select, -1); }
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