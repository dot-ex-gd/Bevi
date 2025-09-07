///@desc
event_inherited();

drop = function(){
	_drop_base();
	
	if (is_grow()){
		instance_create_depth(x, y, 0, ObManaFlowerFruit);
		
		var _xx, _yy;
		repeat(irandom_range(1, 3)){
			_xx = irandom_range(-1, 1) * TILE_SIZE;
			_yy = irandom_range(-1, 1) * TILE_SIZE;
			
			instance_create_depth(x + _xx, y + _yy, 0, ObManaFlowerSeed);
		}
	}
}