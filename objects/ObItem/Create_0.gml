DEPTH + 16;
pickup = function(){
	if (ObCharacter.inventory_add(Item)){
		instance_destroy();
	}
}

interactive = function(){
	show_debug_message($"interactive not set: {object_get_name(self)}");
}

image_xscale = random(0.1);
image_yscale = random(0.1);

alarm[2] = 1;