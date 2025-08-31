DEPTH + 16;
interactive = function(){
	show_debug_message("int");
	if (ObCharacter.inventory_add(Item)){
		show_debug_message("des");
		instance_destroy();
	}
}