tileMainLayer = layer_create(100);
tileCollisionLayer = layer_create(200);

if (isGenerate){
	if (DEBUG){
		show_debug_message($"world generation");
	}
}else{
	if (DEBUG){
		show_debug_message($"world load");
	}
}

tilesetMain = layer_tilemap_create(tileMainLayer, 0, 0, ti_main, obj_world.worldWidth, obj_world.worldHeight);
tilesetCollision = layer_tilemap_create(tileCollisionLayer, 0, 0, ti_collision, obj_world.worldWidth, obj_world.worldHeight);

tSlimeBiome = 0;
tSandLevel = 640;

hStoneLevel = 1000;
hGrassLevel = 510;
hSandLevel = 496;
hWaterLevel = 492;
hDeepWaterLevel = 485;

tiles_fill = function(){
	if (DEBUG){
		show_debug_message("tile fill!");
	}
	
	var _width = obj_world.worldWidth;
	var _height = obj_world.worldHeight;
	
	var _tile = tile.void, _cur_height, _cur_temperature;
	for(var _x = 0; _x < _width; _x++){
		for(var _y = 0; _y < _height; _y++){
			_cur_height = obj_world_maps.heightMap[# _x, _y];
			_cur_temperature = obj_world_maps.temperatureMap[# _x, _y];
			
			if (_cur_height <= hWaterLevel){
				_tile = tile.water;
				
				if (_cur_height <= hDeepWaterLevel){
					tilemap_set(tilesetCollision, tile_collision.collision, _x, _y);
				}
			}else if (_cur_height <= hSandLevel){
				_tile = tile.sand;
			}else if (_cur_height <= hGrassLevel){
				_tile = tile.grass;
				
				if (_cur_temperature >= tSandLevel){
					_tile = tile.sand;
				}
			}else if (hStoneLevel){
				if (_cur_temperature <= tSandLevel){
					_tile = tile.stone;
				}
			}
			
			tilemap_set(tilesetMain, _tile, _x, _y);
		}
	}
	
	if (DEBUG){
		show_debug_message("tile fill complete!");
	}
}

tiles_fill();