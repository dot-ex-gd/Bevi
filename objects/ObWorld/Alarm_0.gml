///@desc

if (!MapsInitializing){
	/// maps init
	for(var i = 0; i < TileW; i++){
		for(var j = 0; j < TileH; j++){
			HeightMap[# i, j] = random(1);
			TemperatureMap[# i, j] = 0;
		
			if (i == 0 || j == 0 || i == TileW - 1 || j == TileH - 1){
				tilemap_set(TilesCollision, true, i, j);
			}
		}
	}
	
	/// desert
	var _xx = 0, _yy = 0;
	repeat(10){
		_xx = irandom_range(200, TileW - 200);
		_yy = irandom_range(200, TileH - 200);
		
		ds_grid_add_disk(TemperatureMap, _xx, _yy, irandom_range(30, 50), 2);
		repeat(irandom_range(20, 100)){
			ds_grid_add_disk(TemperatureMap, _xx + irandom_range(-70, 70), _yy + irandom_range(-70, 70), irandom_range(5, 11), 1);
		}
	}
	
	MapsInitializing = true;
}

if (HeightMapIteration != HeightMapNeed){
	var j;
	
	for(var i = 0; i < TileW; i++){
		for(j = 0; j < TileH; j++){
			HeightMap[# i, j] = ds_grid_get_mean(HeightMap, i - 1, j - 1, i + 1, j + 1);
		}
	}
	
	show_debug_message($"arr itt: {HeightMapIteration + 1}");
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
		
		show_debug_message($"tem itt: {TemperatureMapIteration + 1}");
		TemperatureMapIteration++;
	}else{
		GenerationStageCurrent ++;
		alarm[1] = 2;
		exit;
	}
}

alarm[0] = 1;