global.crafts = [];

enum craft{
	banch,
	recipe,
	struct,
	count,
}

enum benches{
	inventory,
	workbench,
	dark_creator,
	any,
}

function craft_add(_bench, _recipe, _struct, _count = 1){
	array_push(global.crafts, [_bench, _recipe, _struct, _count]);
}

function crafts_get(_bench, _container){
	var _container_len = array_length(_container);
	
	var _item_ids = [];
	var _crafts_len = array_length(global.crafts);
	
	var _can_craft = true;
	
	for(var _id = 0; _id < _crafts_len; _id++){
		var _cur_craft = global.crafts[_id];
		if (
			(_cur_craft[craft.banch] != _bench && _cur_craft[craft.banch] != benches.any) || 
			((obj_character.inventoryWeight + _cur_craft[craft.struct][$ "weight"]) > obj_character.inventoryWeightMax)
		){
			continue;
		}
		
		var _craft_len = array_length(_cur_craft[craft.recipe]);
		_can_craft = true;
		
		for(var _recipe_ind = 0; _recipe_ind < _craft_len; _recipe_ind += 2){
			var _need_item = _cur_craft[craft.recipe][_recipe_ind];
			var _need_item_count = _cur_craft[craft.recipe][_recipe_ind + 1];
			
			if (_need_item_count <= 0) { continue; }
			
			var _found_item = 0;
			
			for(var _container_ind = 0; _container_ind < _container_len; _container_ind++){
				if (_container[_container_ind][$ "item"] == _need_item){
					_found_item++;
					
					if (_found_item >= _need_item_count) { break; }
				}
			}
			
			if (_found_item < _need_item_count){
				_can_craft = false;
				break;
			}
		}
		
		array_push(_item_ids, [_id, _can_craft]);
	}
	
	return _item_ids;
}

#region CRAFTS

function crafts_init(){
	craft_add(benches.inventory, [obj_stick, 1, obj_rock, 2], global.items.rock);
}

#endregion