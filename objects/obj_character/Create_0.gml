global.playerExists = true;

xpMax = 100;
xp = 0;

hpMax = 100;
hp = hpMax;

manaMax = 25;
mana = manaMax;

#region INTERACTIVE
keyInteractive = ord("E");

interactive = false;
interactiveX = 0;
interactiveY = 0;
interactiveXMax = 1;
interactiveYMax = 1;
interactiveXMin = -1;
interactiveYMin = -1;

interactive_state = function(_interactive, _new_state = !interactive){
	interactive = _new_state;
	
	if (_interactive){
		get_interactive();
	}
	
	interactiveX = 0;
	interactiveY = 0;
	
	if (DEBUG){
		show_debug_message("Interactive state change!");
	}
}

get_interactive = function(){
	var _x = x + (interactiveX * TILE_SIZE);
	var _y = y + (interactiveY * TILE_SIZE);
	
	var _item = collision_point(_x, _y, obj_item, false, true);
	if (_item){
		_item.interactive();
	}
	
	if (DEBUG){
		show_debug_message("Interactive!");
	}
}

#endregion

#region CRAFTS
keyCrafts = ord("I");

isCraftsOpen = false;
crafts_open = function(){
	if (isInventoryOpen) { exit; }
	isCraftsOpen = !isCraftsOpen;
	
	if (isCraftsOpen){
		instance_create_depth(0, 0, 0, obj_inventory_craft);
	}else{
		instance_destroy(obj_inventory_craft);
	}
	
	if (DEBUG){
		show_debug_message($"Crafts open: {isCraftsOpen}");
	}
}

#endregion

#region INVENTORY
keyInventory = ord("I");

isInventoryOpen = false;
inventory_open = function(){
	if (isCraftsOpen) { exit; }
	isInventoryOpen = !isInventoryOpen;
	
	if (isInventoryOpen){
		instance_create_depth(0, 0, 0, obj_inventory);
	}else{
		instance_destroy(obj_inventory);
	}
	
	if (DEBUG){
		show_debug_message($"Inventory open: {isInventoryOpen}");
	}
}

inventory = [];
inventoryWeight = 0;
inventoryWeightMax = 20;

inventory_add = function(_item){
	if (inventoryWeight + _item[$ "weight"] <= inventoryWeightMax){
		array_push(inventory, _item);
		inventory_weight_update();
		
		if (DEBUG){
			show_debug_message($"Character's inventory: {inventory}");
		}
		
		return true;
	}
	
	return false;
}

inventory_weight_update = function(){
	inventoryWeight = 0;
	
	for(var _index = 0; _index < array_length(inventory); _index++){
		inventoryWeight += inventory[_index][$ "weight"];
	}
}

inventory_throw = function(_item_index){
	var _len = array_length(inventory);
	
	if (_item_index >= 0 && _item_index <= _len - 1 && inventory[_item_index]){
		instance_create_depth(x, y, 0, inventory[_item_index][$ "item"]);
		
		inventory_delete(_item_index, -1);
	}
}

inventory_delete = function(_index, _count){
	array_delete(inventory, _index, _count);
	
	inventory_weight_update();
	
	if (DEBUG){
		show_debug_message($"Character's inventory: {inventory}");
	}
}

#endregion

#region MOVEMENT
keyUp = ord("W");
keyDown = ord("S");
keyLeft = ord("A");
keyRight = ord("D");

check_collision = function(_dir_x, _dir_y){
	return false;
}

moevePermament = false;
move = function(_dir_x, _dir_y){
	if (_dir_x == 0 && _dir_y == 0) { exit; }

	var _next_step = true;
	
	if (!interactive){
		if (!check_collision(_dir_x, _dir_y)){
			x += _dir_x * TILE_SIZE;
			y += _dir_y * TILE_SIZE;
		}
	}else{
		interactiveX += _dir_x;
		interactiveY += _dir_y;
		
		interactiveX = clamp(interactiveX, interactiveXMin, interactiveXMax);
		interactiveY = clamp(interactiveY, interactiveYMin, interactiveYMax);
		
		_next_step = false;
	}
	
	if (_next_step){
		stepPoints --;
		obj_step_controller.step();
	}
}
#endregion




instance_create_depth(x, y, 0, obj_camera);