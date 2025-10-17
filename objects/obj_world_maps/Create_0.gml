worldWidth = obj_world.worldWidth;
worldHeight = obj_world.worldHeight;

maps_init = function(){
	heightMap = ds_grid_create(worldWidth, worldHeight);
	temperatureMap = ds_grid_create(worldWidth, worldHeight);
	
	if (DEBUG){
		show_debug_message($"maps init");
	}
}

maps_randomize = function(){
	for(var _x = 0; _x < worldWidth; _x++){
		for(var _y = 0; _y < worldHeight; _y++){
			heightMap[# _x, _y] = irandom_range(1, 1_000);
			temperatureMap[# _x, _y] = irandom_range(1, 1_000);
		}
	}
	
	if (DEBUG){
		show_debug_message($"maps randomize");
	}
}

map_smooth = function(_map, _smooth){
	repeat(_smooth){
		for(var _x = 0; _x < worldWidth; _x++){
			for(var _y = 0; _y < worldHeight; _y++){
				_map[# _x, _y] = ds_grid_get_mean(_map, _x - 1, _y - 1, _x + 1, _y + 1);
			}
		}
		
		if (DEBUG){
			show_debug_message($"smooth {_map}");
		}
	}
}

maps_clear = function(){
	ds_grid_destroy(heightMap);
	ds_grid_destroy(temperatureMap);
	
	if (DEBUG){
		show_debug_message($"maps clear");
	}
}

if (isGenerate){
	maps_init();
	maps_randomize();
	
	map_smooth(heightMap, obj_world.worldHeightMapSmooth);
	map_smooth(temperatureMap, obj_world.worldTemperatureMapSmooth);
}