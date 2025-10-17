///@desc

if (!MapsInitializing){
	/// maps init
	for(var i = 0; i < TileW; i++){
		for(var j = 0; j < TileH; j++){
			HeightMap[# i, j] = irandom_range(1, 1_000);
			TemperatureMap[# i, j] = irandom_range(1, 1_000);
		}
	}
	
	/// desert
	change_temperature();
	change_temperature(100, 2, [10, 20], [5, 20], [-40, 40], [8, 20], [-125, -75]);
	
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