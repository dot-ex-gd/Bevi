///@desc init
TileW = room_width div TILE_SIZE + 1;
TileH = room_height div TILE_SIZE + 1;

/// tiles create
TileLayer = layer_create(100);
TileLayerCollision = layer_create(100);

Tiles = layer_tilemap_create(TileLayer, 0, 0, TiGround, TileW, TileH);
TilesCollision = layer_tilemap_create(TileLayerCollision, 0, 0, TiCollision, TileW, TileH);

tilemap_clear(Tiles, tile.grass);
layer_set_visible(TileLayerCollision, false);

HeightMap = ds_grid_create(TileW, TileH);
TemperatureMap = ds_grid_create(TileW, TileH);

global.PlayerExist = false;


if (!IsLoad){
	alarm[0] = 2;
}else{
	managers_init();
	world_load(WorldName);
	Generation = true;
}