switch(keyboard_lastchar){
	case "A":
		AttackMode = !AttackMode;
	break;
	case CMoveUp:
	case CMoveLeft:
	case CMoveDown:
	case CMoveRight:
		if (!Interactive){
			if (StepPoints >= 1){
				if (!InventoryOpen && !CraftOpen){
					var _to_x = (keyboard_check(MoveRight) - keyboard_check(MoveLeft)) * TILE_SIZE;
					var _to_y = (keyboard_check(MoveDown) - keyboard_check(MoveUp)) * TILE_SIZE;
					
					var _attack = collision_point(x + _to_x, y + _to_y, [ObEntity, AttackMode ? ObDestroyable : ObEntity], false, false);
					
					if (!tilemap_get_at_pixel(ObWorld.TilesCollision, x + _to_x, y + _to_y) && !_attack){
						x += _to_x;
						y += _to_y;
			
						DEPTH;
					}
			
					if (_attack){
						var _damage = 1;
						if (InArm && item_find_flag(InArm, _attack.PreferFlag)){
							_damage = InArm[$ "Damage"];
						}
						
						_attack.get_damage(_damage);
					}
				
					StepPoints -= 1;
					if (StepPoints < 1) { ObStepController.alarm[0] = ObStepController.StepTime; }
				}
			}
		}else{	// interactive
			var _to_x = (keyboard_check(MoveRight) - keyboard_check(MoveLeft));
			var _to_y = (keyboard_check(MoveDown) - keyboard_check(MoveUp));
			
			InteractiveX += _to_x;
			InteractiveY += _to_y;
			
			InteractiveX = clamp(InteractiveX, -1, 1);
			InteractiveY = clamp(InteractiveY, -1, 1);
		}
	break;
	case "i":
		inventory_open();
	break;
	case "I":
		craft_open();
	break;
	case "e":
		if (!InventoryOpen && !CraftOpen){
			Interactive = !Interactive;
			
			if (item_find_flag(InArm, flags.pickaxe)){
				InteractiveType = interactive_type.dig;
			}
			if (item_find_flag(InteractiveInArm, flags.placeble)){
				InteractiveType = interactive_type.replace;
			}
			if (item_find_flag(InteractiveInArm, flags.remeltable)){
				InteractiveType = interactive_type.melt;
			}
			
			if (!Interactive){
				var _x = x + (InteractiveX * TILE_SIZE);
				var _y = y + (InteractiveY * TILE_SIZE);
				
				switch(InteractiveType){
					case interactive_type.interactive:
						var _coll = collision_point(_x, _y, ObInstances, 0, 1);
				
						if (_coll){
							if (item_find_flag(_coll, flags.interactive)){
								_coll.interactive();
							}
							if (item_find_flag(_coll, flags.pickup)){
								_coll.pickup();
							}
						}
					break;
					case interactive_type.dig:
						if (item_find_flag(InArm, flags.pickaxe)){
							var _coll = tilemap_get_at_pixel(ObWorld.Tiles, _x, _y);
							var _create = noone;
							var _time = 1;
							
							switch(_coll){
								case tile.grass:
									_time = 5;
									_create = ObGrassTile;
								break;
								case tile.stone:
									_time = 20;
									_create = ObStoneTile;
									
									if (!irandom(25)) { _create = ObIronOre; }
								break;
								case tile.sand:
									_time = 2;
									_create = ObSandTile;
								break;
							}
							
							if (_create){
								ObStepController.update(_time);
								instance_create_depth(_x, _y, 0, _create);
							}
						}
					break;
					case interactive_type.replace:
						if (InteractiveInArm){
							instance_create_depth(_x, _y, 0, InteractiveInArm[$ "Replaceble"]);
							InteractiveInArm = noone;
						}
						
						InteractiveType = interactive_type.interactive;
					break;
					case interactive_type.melt:
						var _col = collision_point(_x, _y, ObBake, false, false);
						
						if (_col){
							if (_col.item_add(InteractiveInArm)){
								InteractiveInArm = noone;
							}else{
								interactive_abort();
							}
						}else{
							interactive_abort();
						}
						
						InteractiveType = interactive_type.interactive;
					break;
				}
			}else{
				InteractiveX = 0;
				InteractiveY = 0;
			}
		}
	break;
}

keyboard_lastchar = "";