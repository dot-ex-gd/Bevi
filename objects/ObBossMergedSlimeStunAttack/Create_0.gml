event_inherited();

ObCharacter.effect_add(effect.stun, 2);

drop = function(){
}

Step = function(){
	spring(0.25);
	
	get_damage(1);
	
	StepPoints--;
}

DEPTH - 16;