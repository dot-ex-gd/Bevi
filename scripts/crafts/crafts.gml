global.Crafts = [];

enum craft{
	wrkb,
	rec,
	item,
	name,
	struct,
	count,
}
enum work_bench{
	inventory,
	workbench,
	any
}

///@func craft_add(workbench, reciepe, item, [count])
function craft_add(_workbench, _reciepe, _item, _name, _struct, _count = 1){
	array_push(global.Crafts, [_workbench, _reciepe, _item, _name, _struct, _count]);
}


function crafts_init(){
	global.Crafts = [];
	craft_add(work_bench.inventory, [ObStick, 1, ObRock, 1], ObWorkbench, text_get("item_workbench"), global.Items.Workbench);
	craft_add(work_bench.inventory, [ObStick, 3, ObRock, 4], ObStoneAxe, text_get("item_stone_axe"), global.Items.StoneAxe);
	craft_add(work_bench.inventory, [ObStick, 2, ObRock, 5], ObStonePickaxe, text_get("item_stone_pickaxe"), global.Items.StonePickaxe);
	craft_add(work_bench.inventory, [ObStick, 3, ObRock, 3], ObStoneSword, text_get("item_stone_sword"), global.Items.StoneSword);
}

function craft_get(_workbench, _container){
	var _cont_len = array_length(_container);
	
	var _ids = [];
	var _len = array_length(global.Crafts);
	
	var _can_craft = true, _need_count, _need_item, _craft_len, _already, _found, _item, i, j, k;
	
	for(i = 0; i < _len; i++){
		if (global.Crafts[i][craft.wrkb] != _workbench && _workbench != work_bench.any || 
			ObCharacter.InventoryWeight + global.Crafts[i][craft.struct][$ "Weight"] > ObCharacter.InventoryMaxWeight) { array_push(_ids, false); continue; }
		
		_item = global.Crafts[i];
		_craft_len = array_length(_item[craft.rec]);
		_can_craft = true;
		
		for(j = 0; j < _craft_len; j += 2){
			_need_item = _item[craft.rec][j];
			_need_count = _item[craft.rec][j + 1];
			
			if (_need_count <= 0) { continue; }
			
			_found = 0;
			
			for(k = 0; k < _cont_len; k++){
				_already = false;
				
				if (_already) { continue; }
				
				if (_container[k].Item == _need_item){
					_found ++;
					
					if (_found >= _need_count) { break; }
				}
			}
			
			if (_found < _need_count){
				_can_craft = false;
				break;
			}
		}
		
		if (_can_craft){
			array_push(_ids, true);
		}else{
			array_push(_ids, false);
		}
	}
	
	
	return _ids;
}