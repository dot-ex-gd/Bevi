///@desc tile fill

var _tile = 0, _str = "", _txx = 0, _tyy = 0, _obj, _inst = 0, _carr, _ctem;
for(var i = 0; i < TileW; i++){
	for(var j = 0; j < TileH; j++){
		_carr = HeightMap[# i, j];
		_ctem = TemperatureMap[# i, j];
		
		if (_carr <= 0.494){
			_tile = tile.water;
			
			if (_carr <= 0.49){
				tilemap_set(TilesCollision, true, i, j);
			}
		}else if (_carr <= 0.498){
			_tile = tile.sand;
		}else if (_carr <= 0.53){
			_tile = tile.grass;
			
			if (_ctem > 0.46){
				_tile = tile.sand;
			}
		}else if (_carr <= 1){
			if (_ctem <= 0.46){
				_tile = tile.stone;
			}
		}
		
		if (_ctem <= 0){
			_tile = choose(tile.slime_blue, tile.slime_green, tile.slime_red, tile.slime_yellow);
			tilemap_set(TilesCollision, false, i, j);
		}
		
		tilemap_set(Tiles, _tile, i, j);
	}
}

GenerationStageCurrent++;
alarm[2] = 2;