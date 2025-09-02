event_inherited();

drop = function(){
	_drop_base();
	instance_create_depth(x, y, depth, ObEvilEyeItem);
}

Step = function(){
	var _dir = [sign(ObCharacter.x - x) * TILE_SIZE, sign(ObCharacter.y - y) * TILE_SIZE];

	if (!tilemap_get_at_pixel(ObWorld.TilesCollision, x + _dir[0], y + _dir[1])){
		if (collision_point(x + _dir[0], y + _dir[1], [ObCharacter, ObEnemy], false, false)){
			if (AttackPoints >= 1){
				ObCharacter.get_damage(Damage);
				AttackPoints--;
			}
		}else{
			x += _dir[0];
			y += _dir[1];
			
			DEPTH;
		}
	}
	
	StepPoints--;
}