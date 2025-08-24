///@desc	step
with(ObEntity){
	StepPoints += StepPointsGive;
	
	alarm[0] = other.StepTime;
}

with(ObCharacter){
	StepPoints += StepPointsGive;
}