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
	
	
	
	
	
	
	
	
	
	
}