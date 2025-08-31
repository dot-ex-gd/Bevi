switch(keyboard_lastchar){
	case "w":
	case "a":
	case "s":
	case "d":
		if (StepPoints >= 1){
			if (!InventoryOpen && !CraftOpen){
				var _to_x = (keyboard_check(MoveRight) - keyboard_check(MoveLeft)) * TILE_SIZE;
				var _to_y = (keyboard_check(MoveDown) - keyboard_check(MoveUp)) * TILE_SIZE;
				
				var _attack = collision_point(x + _to_x, y + _to_y, [ObEntity, ObDestroyableCollision], false, false);
				
				if (!tilemap_get_at_pixel(ObWorld.TilesCollision, x + _to_x, y + _to_y) && !_attack){
					x += _to_x;
					y += _to_y;
			
					DEPTH;
				}
			
				if (_attack){
					_attack.get_damage(1);
				}
				
				StepPoints -= 1;
				if (StepPoints < 1) { ObStepController.alarm[0] = ObStepController.StepTime; }
			}
		}
	break;
	case "i":
		inventory_open();
	break;
	case "I":
		craft_open();
	break;
	case "e":
		var _coll = collision_point(x, y, ObItem, 0, 1);
		if (_coll){
			var _ex = inventory_add(_coll.Item);
			
			if (_ex){
				instance_destroy(_coll);
			}
		}
	break;
}

keyboard_lastchar = "";