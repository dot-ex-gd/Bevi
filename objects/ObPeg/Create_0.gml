event_inherited();

drop = function(){
	_drop_base();
	instance_create_depth(x, y, depth, ObPegWool);
}

Step = function(){
	var _dir = [irandom_range(-1, 1) * TILE_SIZE, irandom_range(-1, 1) * TILE_SIZE];
	
	if (!tilemap_get_at_pixel(ObWorld.TilesCollision, x + _dir[0], y + _dir[1]) && !collision_point(x + _dir[0], y + _dir[1], [ObCharacter, ObEntity], false, false)){
		x += _dir[0];
		y += _dir[1];
		
		DEPTH;
	}
	
	StepPoints--;
}