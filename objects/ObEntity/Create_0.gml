Step = function(){}

_get_damage_base = function(_damage){ Health -= _damage; if (!Health) instance_destroy(); spring(0.5); }
get_damage = function(_damage){ _get_damage_base(_damage); }


_drop_base = function(){ ObCharacter.xp_add(MaxHealth div 5); }
drop = function(){ _drop_base(); }

SpringAtt = 0;
spring = function(_intensivity){
	SpringAtt = 0;
	image_xscale = 1 + _intensivity * choose(-1, 1);
	image_yscale = 1 + _intensivity * choose(-1, 1);
	
	alarm[1] = 1;
}