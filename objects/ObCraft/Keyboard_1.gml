var _dir = 0;
var _len = array_length(DoCraft);

switch(keyboard_lastchar){
	case "s":
		Select++;
		_dir = 1;
	break;
	case "w":
		Select--;
		_dir = -1;
	break;
	case "c":
	case "C":
		Update();
		
		if (DoCraft[Select] >= 0){
			var _item = global.Crafts[DoCraft[Select]];
			var _container = ObCharacter.Inventory;
			var _cont_len = array_length(_container);
			var _need_item;
			var _need_count;
			var _found;
			var _already;
			
			for(var i = 0; i < array_length(_item[craft.rec]); i += 2){
				_need_item = _item[craft.rec][i];
				_need_count = _item[craft.rec][i + 1];
				
				if (_need_count <= 0) { continue; }
				
				_found = 0;
				
				for(var j = 0; j < _cont_len; j++){
					_already = false;
					
					if (_already) { continue; }
					
					if (_container[j].Item == _need_item){
						_found ++;
						
						ObCharacter.inventory_delete(j, -1);
						
						j--;
						_cont_len--;
						
						if (_found >= _need_count) { break; }
					}
				}
			}
			
			ObCharacter.inventory_add(global.Crafts[DoCraft[Select]][craft.struct]);
			Update();
		}
	break;
}

Select = clamp(Select, 0, _len - 1);

if (Select >= MaxShow && _dir > 0){
	Skip += _dir;
}
if (Select <= _len && _dir < 0){
	Skip += _dir;
}

Skip = clamp(Skip, 0, _len - MaxShow);
Skip = max(0, Skip);