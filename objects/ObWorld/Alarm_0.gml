///@desc

if (!MapsInitializing){
	/// maps init
	for(var i = 0; i < TileW; i++){
		for(var j = 0; j < TileH; j++){
			HeightMap[# i, j] = random(1);
			TemperatureMap[# i, j] = random(0.25);
		
			if (i == 0 || j == 0 || i == TileW - 1 || j == TileH - 1){
				tilemap_set(TilesCollision, true, i, j);
			}
		}
	}
	
	/// desert
	change_temperature();
	change_temperature(100, 2, [10, 20], [5, 20], [-40, 40], [8, 20], [-0.72, -0.125]);
	
	MapsInitializing = true;
}

if (HeightMapIteration != HeightMapNeed){
	var j;
	
	for(var i = 0; i < TileW; i++){
		for(j = 0; j < TileH; j++){
			HeightMap[# i, j] = ds_grid_get_mean(HeightMap, i - 1, j - 1, i + 1, j + 1);
		}
	}
	
	HeightMapIteration++;
	
	if (HeightMapNeed == HeightMapIteration){
		GenerationStageCurrent ++;
	}
}else{
	if (TemperatureMapIteration != TemperatureMapNeed){
		var j;
		
		for(var i = 0; i < TileW; i++){
			for(j = 0; j < TileH; j++){
				TemperatureMap[# i, j] = ds_grid_get_mean(TemperatureMap, i - 1, j - 1, i + 1, j + 1);
			}
		}
		
		TemperatureMapIteration++;
	}else{
		GenerationStageCurrent ++;
		alarm[1] = 2;
		exit;
	}
}

alarm[0] = 1;