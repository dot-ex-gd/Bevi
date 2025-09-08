if (global.PlayerExist){
	if (!Need){
		if (distance_to_point(ObCharacter.x, ObCharacter.y) <= CHUNK_SIZE / 2) { exit; }
	}
	Need = false;

	x = ObCharacter.x;
	y = ObCharacter.y;
}

culling();
unculling();