event_inherited();

drop = function(){
	_drop_base();
	instance_create_depth(x, y, depth, ObItemSlime);
}

Step = function(){
	var _dir = [irandom_range(-1, 1) * TILE_SIZE, irandom_range(-1, 1) * TILE_SIZE];
	
	if (distance_to_object(ObCharacter) < 4 * TILE_SIZE){
		_dir = [sign(ObCharacter.x - x) * TILE_SIZE, sign(ObCharacter.y - y) * TILE_SIZE];
	}

	if (!tilemap_get_at_pixel(ObWorld.TilesCollision, x + _dir[0], y + _dir[1])){
		if (!collision_point(x + _dir[0], y + _dir[1], [ObEnemy, ObCharacter], false, false)){
			x += _dir[0];
			y += _dir[1];
			
			DEPTH;
		}
		if (collision_point(x + _dir[0], y + _dir[1], ObCharacter, false, false)){
			if (AttackPoints >= 1){
				ObCharacter.get_damage(Damage);
				AttackPoints--;
			}
		}
	}
	
	StepPoints--;
}