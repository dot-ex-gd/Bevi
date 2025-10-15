event_inherited();

RunAway = false;
drop = function(){
	_drop_base();
	instance_create_depth(x, y, depth, ObEvilEyeItem);
}

Step = function(){
	var _dir = [irandom_range(-1, 1) * TILE_SIZE, irandom_range(-1, 1) * TILE_SIZE];
	
	if (distance_to_object(ObCharacter) < 10 * TILE_SIZE){
		_dir = [sign(ObCharacter.x - x) * TILE_SIZE, sign(ObCharacter.y - y) * TILE_SIZE];
	}
	
	RunAway = false;
	var _near_fire = instance_nearest(x, y, ObBonfire);
	if (_near_fire && distance_to_point(_near_fire.x, _near_fire.y) <= 3 * TILE_SIZE && !irandom(3)){
		RunAway = true;
	}
	
	if ((ObTime.Time >= time.morning && ObTime.Time < time.evening) || RunAway){
		_dir = [-sign(ObCharacter.x - x) * TILE_SIZE, -sign(ObCharacter.y - y) * TILE_SIZE];
		
		if (distance_to_object(ObCharacter) >= ENTITY_ACTIVE_DISTANCE * TILE_SIZE){
			drop = function(){}
			instance_destroy();
		}
	}

	if (!tilemap_get_at_pixel(ObWorld.TilesCollision, x + _dir[0], y + _dir[1])){
		if (!collision_point(x + _dir[0], y + _dir[1], [ObEnemy, ObCharacter], false, false)){
			x += _dir[0];
			y += _dir[1];
			
			DEPTH;
		}else{
			if (collision_point(x + _dir[0], y + _dir[1], ObCharacter, false, false)){
				if (AttackPoints >= 1){
					ObCharacter.get_damage(Damage);
					AttackPoints--;
				}
			}
		}
	}
	
	StepPoints--;
}