///@desc character init

for(var i = 1; i < TileW - 1; i++){
	if (global.PlayerExist) { break; }
	
	for(var j = 1; j < TileH - 1; j++){
		if (tilemap_get(Tiles, i, j) == tile.grass && !tilemap_get(TilesCollision, i, j)){
			character_init(i, j);
			break;
		}
	}
}

alarm[6] = 10;