if (global.playerExists){
	var _char_in_chunk_x = obj_character.x div CHUNK_SIZE div TILE_SIZE;
	var _char_in_chunk_y = obj_character.y div CHUNK_SIZE div TILE_SIZE;
	
	if (_char_in_chunk_x != curX || _char_in_chunk_y != curY){
		for(var _x = -1; _x < 2; _x++){
			for(var _y = -1; _y < 2; _y++){
				save_chunk(curX + _x, curY + _y);
			}
		}
	}
	
	curX = _char_in_chunk_x;
	curY = _char_in_chunk_y;
}else{
	alarm[0] = 5;
}

if (curX != prevCurX || curY != prevCurY){
	for(var _x = -1; _x < 2; _x++){
		for(var _y = -1; _y < 2; _y++){
			unload_chunk(prevCurX + _x, prevCurY + _y);
		}
	}
	
	chunks_update();
	
	prevCurX = curX;
	prevCurY = curY;
}