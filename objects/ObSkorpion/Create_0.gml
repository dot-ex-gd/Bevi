event_inherited();

drop = function(){
	_drop_base();
	//instance_create_depth(x, y, depth, ObEvilEyeItem);
}

Step = function(){
	if (distance_to_object(ObCharacter) < 5 * TILE_SIZE){
		var _dir = [sign(ObCharacter.x - x) * TILE_SIZE, sign(ObCharacter.y - y) * TILE_SIZE];
	}else{
		var _dir = [irandom_range(-1, 1) * TILE_SIZE, irandom_range(-1, 1) * TILE_SIZE];
		
		if (ObTime.Time >= time.evening){
			if (Base && instance_exists(Base)){
				_dir = [sign(Base.x - x) * TILE_SIZE, sign(Base.y - y) * TILE_SIZE];
			}else{
				Base = -1;
			}
		}
	}

	if (!tilemap_get_at_pixel(ObWorld.TilesCollision, x + _dir[0], y + _dir[1])){
		if (!collision_point(x + _dir[0], y + _dir[1], [ObEnemy, ObCharacter], false, false)){
			x += _dir[0];
			y += _dir[1];
			
			DEPTH;
			
			if (ObTime.Time >= time.evening){
				if (Base && instance_exists(Base)){
					if (distance_to_object(Base) < 1){
						Base.Skorp = noone;
						instance_destroy();
					}
				}	
			}
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