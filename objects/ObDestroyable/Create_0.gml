_drop_base = function(){ ObCharacter.xp_add(1); }
drop = function(){ _drop_base(); }

_get_damage_base = function(_damage) { Health -= _damage; if (!Health) instance_destroy(); }
get_damage = function(_damage){
	_get_damage_base(_damage);
	spring(0.25);
}

SpringAtt = 0;

DEPTH;