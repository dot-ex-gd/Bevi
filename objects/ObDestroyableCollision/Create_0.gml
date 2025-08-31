event_inherited();

_drop_base = function(){ ObCharacter.xp_add(1); }
drop = function(){ _drop_base(); }

_get_damage_base = function(_damage) { Health -= _damage; if (!Health) instance_destroy(); }
get_damage = function(_damage){
	_get_damage_base(_damage);
	spring(0.25);
}

SpringAtt = 0;
spring = function(_intensivity){
	SpringAtt = 0;
	image_xscale = 1 + _intensivity * choose(-1, 1);
	image_yscale = 1 + _intensivity * choose(-1, 1);
	
	alarm[1] = 1;
}

DEPTH;