if (Select >= 0 && Select < array_length(ObCharacter.Inventory)){
	if (item_find_flag(ObCharacter.Inventory[Select], flags.food)){
		var _arr = ObCharacter.Inventory[Select][$ "Food"];
		
		for(var i = 0; i < array_length(_arr); i += 2){
			switch(_arr[i]){
				case food_stats.hp:
					ObBar.HpAdd = _arr[i + 1];
				break;
				case food_stats.xp:
					ObBar.XpAdd = _arr[i + 1];
				break;
				case food_stats.mn:
					ObBar.ManaAdd = _arr[i + 1];
				break;
			}
		}
	}
}