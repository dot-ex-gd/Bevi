timeDelta = 1;

step = function(){
	if (alarm[0] <= 0){
		alarm[0] = STEP_DELAY;
	}
}

update = function(){
	with(obj_entity){
		stepPoints += stepPointsGive * other.timeDelta;
	}
	
	if (DEBUG){
		show_debug_message("another step!");
	}
}