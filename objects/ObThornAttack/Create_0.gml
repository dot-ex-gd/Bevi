event_inherited();

drop = function(){
	_drop_base();
	//instance_create_depth(x, y, depth, ObEvilEyeItem);
}

Step = function(){
	if (image_index > 0.5){
		
		var _col = collision_point(x, y, ObCharacter, false, false);
		if (_col){
			_col.get_damage(Damage);
		}
		
		drop = function(){}
		instance_destroy();
	}
	
	if (!image_index){
		image_index += choose(0.5, 1);
		
		spring(0.25);
	}
	
	StepPoints--;
}

DEPTH - 16;