if (CanPress){
	if (get_pressed(ObController.KeybindAttackMode)){
		AttackMode = !AttackMode;
	}

	var _ml, _mr, _mu, _md;
	_ml = get_pressed(ObController.KeybindMoveLeft);
	_mr = get_pressed(ObController.KeybindMoveRight);
	_mu = get_pressed(ObController.KeybindMoveUp);
	_md = get_pressed(ObController.KeybindMoveDown);
	if (_ml || _mr || _mu || _md){
		if (!Interactive){
			if (StepPoints >= 1){
				if (!InventoryOpen && !CraftOpen){
					step();
				}
			}
		}else{	// interactive
			var _to_x = (_mr - _ml);
			var _to_y = (_md - _mu);
		
			InteractiveX += _to_x;
			InteractiveY += _to_y;
		
			InteractiveX = clamp(InteractiveX, -1, 1);
			InteractiveY = clamp(InteractiveY, -1, 1);
		}
	}
	if (get_pressed(ObController.KeybindCrafts)){
		craft_open();
	}
	if (get_pressed(ObController.KeybindInventory)){
		inventory_open();
	}
	if (get_pressed(ObController.KeybindInteract)){
		if (!InventoryOpen && !CraftOpen){
			Interactive = !Interactive;
		
			var _obj = collision_point(x + InteractiveX * TILE_SIZE, y + InteractiveY * TILE_SIZE, ObDestroyableCollisionInteractive, false, false);
			if (_obj){
				_obj.interactive();
			}
		
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
		
			InteractiveType = [];
		}
	}
	
	CanPress = false;
	alarm[0] = KEY_DELAY;
}