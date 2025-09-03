///@desc
event_inherited();

grow = function(){
	_grow_base();
	
	if (!irandom(200) && is_grow() && distance_to_object(ObCharacter) < 10 * TILE_SIZE){
		drop = function(){}
		instance_destroy();
		instance_create_depth(x, y, 0, ObThorn);
	}
}

drop = function(){
	_drop_base();
	
	if (is_grow()){
		instance_create_depth(x, y, 0, ObHearthFlowerFruit);
		instance_create_depth(x, y, 0, ObHearthFlowerSeed);
	}
}