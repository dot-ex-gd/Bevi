if (global.PlayerExist){
	var _cx = ObCharacter.x div CHUNK_SIZE div TILE_SIZE;
	var _cy = ObCharacter.y div CHUNK_SIZE div TILE_SIZE;
	
	
	if (_cx != CurX || _cy != CurY){
		var _x, _y;
		for(_x = -1; _x < 2; _x++){
			for(_y = -1; _y < 2; _y++){
				save(CurX + _x, CurY + _y);
			}
		}
	}
	
	CurX = _cx;
	CurY = _cy;
}

if (CurX != PrevX || CurY != PrevY){
	var _x, _y;
	for(_x = -2; _x < 3; _x++){
		for(_y = -2; _y < 3; _y++){
			unload(PrevX + _x, PrevY + _y);
		}
	}
	
	update();
	
	PrevX = CurX;
	PrevY = CurY;
}