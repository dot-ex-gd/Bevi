DEPTH + TILE_SIZE;

pickup = function(){
	if (obj_character.inventory_add(item)){
		instance_destroy();
	}else{
		if (DEBUG){
			show_debug_message($"cannot pickup object: {object_get_name(object_index)} | inventory is full");
			show_debug_message($"item: {item}");
		}
	}
	
	
	if (DEBUG){
		show_debug_message($"pickup object: {object_get_name(object_index)}");
		show_debug_message($"item: {item}");
	}
}

interactive = function(){
	if (DEBUG){
		show_debug_message($"interactive not set for object: {object_get_name(object_index)}");
	}
}