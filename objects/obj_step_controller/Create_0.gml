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
	with(obj_chunk){
		alarm[0] = STEP_DELAY;
	}
	
	if (DEBUG){
		show_debug_message("another step!");
	}
}