///@desc tile fill

var _tile = 0, _str = "", _txx = 0, _tyy = 0, _obj, _inst = 0, _carr, _ctem;
for(var i = 0; i < TileW; i++){
	for(var j = 0; j < TileH; j++){
		_carr = HeightMap[# i, j];
		_ctem = TemperatureMap[# i, j];
		
		if (_carr <= HWaterLevel){
			_tile = tile.water;
			
			if (_carr <= HDeepWaterLevel){
				tilemap_set(TilesCollision, true, i, j);
			}
		}else if (_carr <= HSandLevel){
			_tile = tile.sand;
		}else if (_carr <= HGrassLevel){
			_tile = tile.grass;
			
			if (_ctem > TSandLevel){
				_tile = tile.sand;
			}
		}else if (_carr <= HStoneLevel){
			if (_ctem < TSandLevel){
				_tile = tile.stone;
			}
		}
		
		if (_ctem <= TSlimeBiome){
			_tile = choose(tile.slime_blue, tile.slime_green, tile.slime_red, tile.slime_yellow);
			tilemap_set(TilesCollision, false, i, j);
		}
		
		tilemap_set(Tiles, _tile, i, j);
	}
}

GenerationStageCurrent++;
alarm[2] = 2;