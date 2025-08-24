global.Crafts = [];

enum craft{
	wrkb,
	rec,
	item,
	name,
	count
}
enum work_bench{
	workbench
}

///@func craft_add(workbench, reciepe, item, [count])
function craft_add(_workbench, _reciepe, _item, _name, _count = 1){
	array_push(global.Crafts, [_workbench, _reciepe, _item, _name, _count]);
}


function crafts_init(){
	global.Crafts = [];
	craft_add(work_bench.workbench, [ObStick, 1, ObRock, 1], ObWorkbench, text_get("item_workbench"));
}

function craft_get(_workbench, _container){
	var _cont_len = array_length(_container);
	
	var _ids = [];
	var _len = array_length(global.Crafts);
	
	var _can_craft = true, _need_count, _need_item, _craft_len, _already, _found, _item, i, j, k;
	
	for(i = 0; i < _len; i++){
		if (global.Crafts[i][craft.wrkb] != _workbench) { continue; }
		
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