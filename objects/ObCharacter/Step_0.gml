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
			
			if (!InArm && !InteractiveInArm){
				array_push(InteractiveType, interactive_type.interactive);
			}
			if (item_find_flag(InArm, flags.pickaxe)){
				array_push(InteractiveType, interactive_type.dig);
			}
			if (item_find_flag(InteractiveInArm, flags.placeble)){
				array_push(InteractiveType, interactive_type.replace);
			}
			if (item_find_flag(InteractiveInArm, flags.remeltable)){
				array_push(InteractiveType, interactive_type.melt);
			}
			
			if (!Interactive){
				if (interactive_type_find(interactive_type.interactive)){
					interactive_tinteractive();
				}
				if (interactive_type_find(interactive_type.dig)){
					interactive_tdig();
				}
				if (interactive_type_find(interactive_type.replace)){
					interactive_treplace();
				}
				if (interactive_type_find(interactive_type.melt)){
					interactive_tmelt();
				}
			}else{
				InteractiveX = 0;
				InteractiveY = 0;
			}
		}
	break;
}

keyboard_lastchar = "";