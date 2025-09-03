event_inherited();

_drop_base = function(){ ObCharacter.xp_add(1 + image_index); }
drop = function(){ _drop_base(); }

_get_damage_base = function(_damage) { Health -= _damage; if (!Health) instance_destroy(); }
get_damage = function(_damage){
	_get_damage_base(_damage);
	spring(0.25);
}

SpringAtt = 0;

_grow_base = function() { if (!is_grow()) {image_index += GrowLevel; spring(0.25); }}
grow = function() { _grow_base(); }
is_grow = function() { return image_index == image_number - 1; }

DEPTH + 1;