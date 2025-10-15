///@desc character init

for(var i = 120; i < TileW - 120; i++){
	if (global.PlayerExist) { break; }
	
	for(var j = 120; j < TileH - 120; j++){
		if (tilemap_get(Tiles, i, j) == tile.grass && !tilemap_get(TilesCollision, i, j)){
			character_init(i, j);
			instance_create_depth(i * TILE_SIZE + TILE_SIZE / 2 + TILE_SIZE, j * TILE_SIZE + TILE_SIZE / 2, 0, ObDev);
			break;
		}
	}
}

alarm[6] = 10;