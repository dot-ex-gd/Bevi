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
		
		var _xx, _yy;
		repeat(irandom_range(1, 3)){
			_xx = irandom_range(-1, 1) * TILE_SIZE;
			_yy = irandom_range(-1, 1) * TILE_SIZE;
			
			instance_create_depth(x + _xx, y + _yy, 0, ObHearthFlowerSeed);
		}
	}
}