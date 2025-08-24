Update();

switch(keyboard_lastchar){
	case "q":
		if (Select <= array_length(ObCharacter.Inventory) - 1 && ObCharacter.Inventory[Select]){
			ObCharacter.InventoryWeight -= ObCharacter.Inventory[Select].Weight;
			
			instance_create_depth(ObCharacter.x, ObCharacter.y, -ObCharacter.y, ObCharacter.Inventory[Select].Item);
			
			array_delete(ObCharacter.Inventory, Select, -1);
			array_delete(Textes, Select, -1);
		}
	break;
	case "s":
		Select++;
		Select = clamp(Select, 0, array_length(Textes) - 1);
		
		if (Select >= MaxShow && (MaxShow + Skip <= array_length(Textes) - 1)){
			Skip++;
		}
	break;
	case "w":
		Select--;
		Select = clamp(Select, 0, array_length(Textes) - 1);
		
		if (Select <= 1){
			if (Skip){
				Skip--;
			}
		}
	break;
	case "c":
	case "C":
		if (DoCraft[Select]){
			var _need = global.Crafts[Select];
			var _item = global.Crafts[Select];
			var _container = ObCharacter.Inventory;
			var _cont_len = array_length(ObCharacter.Inventory);
			
			for(var i = 0; i < array_length(_item[craft.rec]); i += 2){
				var _need_item = _item[craft.rec][i];
				var _need_count = _item[craft.rec][i + 1];
				
				if (_need_count <= 0) { continue; }
				
				var _found = 0;
				
				for(var j = 0; j < _cont_len; j++){
					var _already = false;
					
					if (_already) { continue; }
					
					if (_container[j].Item == _need_item){
						_found ++;
						array_delete(ObCharacter.Inventory, j, -1);
						
						if (_found >= _need_count) { break; }
					}
				}
			}
			
			instance_create_depth(ObCharacter.x, ObCharacter.y, -ObCharacter.y, global.Crafts[Select][craft.item]);
		}
	break;
}