if (!Anger){
	event_inherited();
}else{
	if (global.PlayerExist && distance_to_point(ObCharacter.x, ObCharacter.y) < ENTITY_ACTIVE_DISTANCE * TILE_SIZE){
		anger_step();
	}
}

