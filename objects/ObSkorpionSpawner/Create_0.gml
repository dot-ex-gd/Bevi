///@desc
event_inherited();

drop = function(){
	_drop_base();
}

Skorp = noone;
grow = function(){
	if (!irandom(5)){
		if (!Skorp && can_spawn() && ObTime.Time < time.evening){
			Skorp = instance_create_depth(x, y, 0, ObSkorpion, {Base : id});
		}
	}
	
	if (!instance_exists(Skorp)){
		Skorp = noone;
	}
}