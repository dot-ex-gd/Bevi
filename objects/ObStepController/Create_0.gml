StepTime = 1;

update = function(_intensivity){
	with(ObEntity){
		StepPoints += StepPointsGive * _intensivity;
	
		alarm[0] = other.StepTime;
	}

	with(ObCharacter){
		StepPoints += StepPointsGive;
	}

	with(ObBonfire){
		Intensivity -= 0.001 * _intensivity;
		
		if (Intensivity < 0){
			instance_destroy();
		}
	}
}