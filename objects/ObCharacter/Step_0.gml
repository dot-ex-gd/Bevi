switch(keyboard_lastchar){
	case "w":
	case "a":
	case "s":
	case "d":
		if (StepPoints >= 1){
			if (InventoryOpen) { exit; }
		
			var _to_x = (keyboard_check(MoveRight) - keyboard_check(MoveLeft)) * TILE_SIZE;
			var _to_y = (keyboard_check(MoveDown) - keyboard_check(MoveUp)) * TILE_SIZE;
		
			if (!tilemap_get_at_pixel(ObWorld.TilesCollision, x + _to_x, y + _to_y)){
				x += _to_x;
				y += _to_y;
			
				depth = -y;
			}
		
			StepPoints -= 1;
			if (StepPoints < 1){ ObStepController.alarm[0] = ObStepController.StepTime; }
		}
	break;
	case "i":
		InventoryOpen = !InventoryOpen;
		
		if (InventoryOpen){
			instance_create_depth(INV_WDEL, INV_HDEL, -99999, ObInventoryBack);
		}else{
			instance_destroy(ObInventoryBack);
		}
	break;
	case "e":
		var _coll = collision_point(x, y, ObItem, 0, 1);
		if (_coll){
			if (InventoryWeight + _coll.Item.Weight <= InventoryMaxWeight){
				array_push(Inventory, _coll.Item);
				InventoryWeight += _coll.Item.Weight;
				
				instance_destroy(_coll);
			}
		}
	break;
}

keyboard_lastchar = "";