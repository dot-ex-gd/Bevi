event_inherited();

drop = function(){
	_drop_base();
	//instance_create_depth(x, y, depth, ObEvilEyeItem);
}

Step = function(){
	if (distance_to_object(ObCharacter) < 10 * TILE_SIZE){
		var _x, _y;
		
		while(AttackPoints >= 1){
			repeat(irandom_range(4, 10)){
				_x = irandom_range(-2, 2);
				_y = irandom_range(-2, 2);
				
				instance_create_depth(ObCharacter.x + (_x * TILE_SIZE), ObCharacter.y + (_y * TILE_SIZE), 0, ObThornAttack);
			}
			
			AttackPoints--;
		}
	}
	
	StepPoints--;
	DEPTH;
}

spring(0.5);