StepTime = 1;

update = function(_steps){
	with(ObEntity){
		StepPoints += StepPointsGive * _steps;
	
		alarm[0] = other.StepTime;
	}
	with(ObEnemy){
		AttackPoints += AttackPointsGive * _steps;
		AttackPoints = clamp(AttackPoints, 0, AttackPointsMax);
	
		alarm[0] = other.StepTime;
	}

	with(ObCharacter){
		StepPoints += StepPointsGive;
	}

	with(ObBonfire){
		Intensivity -= 0.0001 * _steps;
		
		if (Intensivity < 0){
			instance_destroy();
		}
	}
	
	with(ObBake){
		melt(_steps);
	}
	
	ObTime.time_go(_steps);
	ObTime.surface_update();
	
	ObChunk.alarm[0] = 1;
}