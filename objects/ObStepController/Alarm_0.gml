///@desc	step
with(ObEntity){
	StepPoints += StepPointsGive;
	
	alarm[0] = other.StepTime;
}

with(ObCharacter){
	StepPoints += StepPointsGive;
}

ObDNCycle.time_go(10);
ObDNCycle.surface_update();