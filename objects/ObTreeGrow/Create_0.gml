///@desc
event_inherited();

drop = function(){
	_drop_base();
	
	if (floor(image_index) >= 1){
		var _xx = 0, _yy = 0;
		repeat(1){
			_xx = irandom_range(-1, 1);
			_yy = irandom_range(-1, 1);
			
			instance_create_depth(x + (TILE_SIZE * _xx), y + (TILE_SIZE * _yy), 0, ObLog);
		}
		repeat(irandom(1)){
			_xx = irandom_range(-1, 1);
			_yy = irandom_range(-1, 1);
			
			instance_create_depth(x + (TILE_SIZE * _xx), y + (TILE_SIZE * _yy), 0, ObStick);
		}
	}
}

IsDestroy = false;
grow = function(){
	_grow_base();
	
	if (is_grow()){
		if (IsDestroy){
			drop = function(){}
			instance_destroy();
			
			instance_create_depth(x, y, 0, ObTree);
		}
		
		IsDestroy = true;
	}
}