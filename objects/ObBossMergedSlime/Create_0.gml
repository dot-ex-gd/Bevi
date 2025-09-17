event_inherited();

drop = function(){
	_drop_base();
	ObBossesController.IsMergedSlimeDefeat = true;
	instance_create_depth(x, y, depth, ObItemSlime);
}

Step = function(){
	if (distance_to_object(ObCharacter) < 20 * TILE_SIZE){
		var _dir = [sign(ObCharacter.x - x) * TILE_SIZE, sign(ObCharacter.y - y) * TILE_SIZE];
	}else{
		if (!irandom(5)){
			drop = function(){};
			instance_destroy();
		}
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