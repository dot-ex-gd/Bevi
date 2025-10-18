if (DEBUG){
	show_debug_message($"crafts key detect start. cellSelect: {cellSelect} | cellSkip: {cellSkip}");
}

var _crafts = array_length(canCraft);
var _skip_delta = 0;

if (keyboard_check_pressed(keyUp)){
	cellSelect--;
	_skip_delta--;
}
if (keyboard_check_pressed(keyDown)){
	cellSelect++;
	_skip_delta++;
}

if (keyboard_check_pressed(keyCraft)){
	if (canCraft[cellSelect][1]){
		var _item = global.crafts[canCraft[cellSelect][0]];
		var _container_len = array_length(container);
		
		for(var _item_ind = 0; _item_ind < array_length(_item[craft.recipe]); _item_ind += 2){
			var _need_item = _item[craft.recipe][_item_ind];
			var _need_item_count = _item[craft.recipe][_item_ind + 1];
			
			if (_need_item_count <= 0) { continue; }
			
			var _found = 0;
			for(var _container_ind = 0; _container_ind < _container_len; _container_ind++){
				if (container[_container_ind][$ "item"] == _need_item){
					_found++;
					
					obj_character.inventory_delete(_container_ind, -1);
					_container_ind--;
					_container_len--;
					
					if (_found >= _need_item_count) { break; }
				}
			}
		}
		
		obj_character.inventory_add(global.crafts[canCraft[cellSelect][0]][craft.struct]);
		update();
	}
}

cellSelect = clamp(cellSelect, 0, _crafts - 1);

if ((cellSelect >= cellShowMax + cellSkip) || (cellSelect <= cellSkip)){
	cellSkip += _skip_delta;
	cellSkip = clamp(cellSkip, 0, _crafts - cellShowMax);
	cellSkip = max(0, cellSkip);
}

if (DEBUG){
	show_debug_message($"Inventory key detect end. cellSelect: {cellSelect} | cellSkip: {cellSkip}");
}