event_inherited();

drop = function(){}

Step = function(){
	var _dir = [irandom_range(-1, 1) * TILE_SIZE, irandom_range(-1, 1) * TILE_SIZE];
	var _near_enemy = instance_nearest(x, y, ObEnemy);
	
	if (distance_to_point(ObCharacter.x, ObCharacter.y) < 10 * TILE_SIZE){
		_dir = [sign(ObCharacter.x - x) * TILE_SIZE, sign(ObCharacter.y - y) * TILE_SIZE];
	}
	
	if (_near_enemy){
		if (distance_to_point(_near_enemy.x, _near_enemy.y) < 5 * TILE_SIZE){
			_dir = [sign(_near_enemy.x - x) * TILE_SIZE, sign(_near_enemy.y - y) * TILE_SIZE];
		}
	}
	
	var _coll = collision_point(x + _dir[0], y + _dir[1], [ObCharacter, ObEntity], false, false);
	
	if (!tilemap_get_at_pixel(ObWorld.TilesCollision, x + _dir[0], y + _dir[1]) && !_coll){
		x += _dir[0];
		y += _dir[1];
	
		DEPTH;
	}
	
	var _enemy_coll = collision_point(x + _dir[0], y + _dir[1], ObEnemy, false, false);
	if (_enemy_coll){
		if (DamageType == _enemy_coll.PreferFlag){
			_enemy_coll.get_damage(Damage);
		}else{
			_enemy_coll.get_damage(1);
		}
	}
	
	StepPoints--;
}