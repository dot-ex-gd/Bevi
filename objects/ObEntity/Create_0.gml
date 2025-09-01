Step = function(){}

_get_damage_base = function(_damage){ Health -= _damage; if (!Health) instance_destroy(); spring(0.5); }
get_damage = function(_damage){ _get_damage_base(_damage); }


_drop_base = function(){ ObCharacter.xp_add(MaxHealth div 5); }
drop = function(){ _drop_base(); }

SpringAtt = 0;