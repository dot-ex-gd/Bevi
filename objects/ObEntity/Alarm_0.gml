///@desc step
if (global.PlayerExist && distance_to_point(ObCharacter.x, ObCharacter.y) < ENTITY_ACTIVE_DISTANCE * TILE_SIZE){
	while(StepPoints >= 1){
		Step();
	}
}