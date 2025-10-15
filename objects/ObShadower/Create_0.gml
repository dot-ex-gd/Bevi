event_inherited();

drop = function(){
	_drop_base();
	//instance_create_depth(x, y, depth, ObEvilEyeItem);
}

get_damage = function(_damage){
	_get_damage_base(_damage);
	
	if (ObCharacter.AttackMode == true){
		ObCharacter.get_damage(Damage);
		image_alpha = true;
	}
}

Step = function(){
	if (ObTime.Time == time.morning){
		drop = function(){}
		instance_destroy();
	}
	
	StepPoints--;
}

image_alpha = random_range(0.05, 0.1);