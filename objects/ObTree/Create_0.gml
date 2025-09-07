///@desc
event_inherited();

drop = function(){
	_drop_base();
	
	var _xx = 0, _yy = 0;
	repeat(irandom_range(1, 3)){
		_xx = irandom_range(-1, 1);
		_yy = irandom_range(-1, 1);
		
		instance_create_depth(x + (TILE_SIZE * _xx), y + (TILE_SIZE * _yy), 0, ObLog);
	}
	repeat(irandom_range(1, 3)){
		_xx = irandom_range(-1, 1);
		_yy = irandom_range(-1, 1);
		
		instance_create_depth(x + (TILE_SIZE * _xx), y + (TILE_SIZE * _yy), 0, ObTreeSeed);
	}
	repeat(irandom(1)){
		_xx = irandom_range(-1, 1);
		_yy = irandom_range(-1, 1);
		
		instance_create_depth(x + (TILE_SIZE * _xx), y + (TILE_SIZE * _yy), 0, ObStick);
	}
}

repeat(irandom(5)){
	var _txx = irandom_range(-2, 2);
	var _tyy = irandom_range(-2, 2);
	
	if (!collision_point(x + (TILE_SIZE * _txx), y + (TILE_SIZE * _tyy), ObDeco, false, false)){
		instance_create_depth(x + (TILE_SIZE * _txx), y + (TILE_SIZE * _tyy), 0, ObLeafes);
	}
}