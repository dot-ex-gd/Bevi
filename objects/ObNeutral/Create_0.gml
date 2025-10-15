event_inherited();

Anger = false;

_anger_step_base = function() {}
anger_step = function() { _anger_step_base(); }

get_damage = function(_damage) { _get_damage_base(_damage); Anger = true; }