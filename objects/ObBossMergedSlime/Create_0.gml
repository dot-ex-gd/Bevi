event_inherited();

drop = function(){
	_drop_base();
	if (!ObBossesController.IsMergedSlimeDefeat){
		ObBossesController.IsMergedSlimeDefeat = true;
		instance_create_depth(x, y, depth, ObSlimePet1);
	}
	instance_create_depth(x, y, depth, ObItemSlime);
}

Step = function(){
	var _distance = distance_to_object(ObCharacter);
	if (_distance < 20 * TILE_SIZE){
		var _dir = [sign(ObCharacter.x - x) * TILE_SIZE, sign(ObCharacter.y - y) * TILE_SIZE];
		
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
		
		if (_distance < 3 * TILE_SIZE && !irandom(5)){
			instance_create_depth(ObCharacter.x, ObCharacter.y, -ObCharacter.y, ObBossMergedSlimeStunAttack);
		}
	}else{
		if (!irandom(3)){
			drop = function(){};
			instance_destroy();
		}
	}
	
	StepPoints--;
}