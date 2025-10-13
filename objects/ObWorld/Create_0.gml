random_set_seed(Seed);

depth = -16_000;
GenerationStage = [
	text_get("text_height_map_generation"), text_get("text_temperature_map_generation"), text_get("text_tile_fill"), 
	text_get("text_managers_initializing"), text_get("text_instances_generation"), text_get("text_culling"), 
	text_get("text_character_spawn_find")
];
						
Generation = false;
GenerationStageCurrent = 0;

MapsInitializing = false;
HeightMapIteration = 0;
TemperatureMapIteration = 0;

InstancesX = 1;
InstancesY = 1;

alarm[11] = 2;

managers_init = function(){
	instance_create_depth(0, 0, 0, ObController);
	instance_create_depth(0, 0, -16_000, ObTime);
	instance_create_depth(0, 0, 0, ObStepController);
	instance_create_depth(0, 0, 0, ObChunk);
	instance_create_depth(0, 0, 0, ObBossesController);
}
character_init = function(i, j){
	if (!global.PlayerExist){
		instance_create_depth(i * TILE_SIZE + TILE_SIZE / 2, j * TILE_SIZE + TILE_SIZE / 2, 0, ObCharacter);
	}
	instance_create_depth(i * TILE_SIZE, j * TILE_SIZE, 0, ObCamera);
	
	instance_create_depth(96, 168, 0, ObXpBar);
	instance_create_depth(160, 168, 0, ObHealthBar);
	instance_create_depth(224, 168, 0, ObManaBar);
	global.PlayerExist = true;
}

AdviceText = text_get("text_dev_advice");
get_advice = function(){
    AdviceCount = real(text_get("text_dev_advice_count"));
    Advice = text_get($"text_dev_advice_{irandom_range(1, AdviceCount)}");
}
get_advice();
alarm[10] = 60;


/// @func change_temperature(bias, count, main_size, second_count, second_bias, second_size, temperature)
change_temperature = function(_bias = 200, _count = 5, _main_size = [20, 50], _second_count = [20, 100], _second_bias = [-70, 70], _second_size = [5, 11], _temperature = [2, 1]){
	repeat(_count){
		var _xx = irandom_range(_bias, TileW - _bias);
		var _yy = irandom_range(_bias, TileH - _bias);
	
		ds_grid_add_disk(TemperatureMap, _xx, _yy, irandom_range(_main_size[0], _main_size[1]), _temperature[0]);
		repeat(irandom_range(_second_count[0], _second_count[1])){
			ds_grid_add_disk(TemperatureMap, _xx + irandom_range(_second_bias[0], _second_bias[1]), _yy + irandom_range(_second_bias[0], _second_bias[1]), irandom_range(_second_size[0], _second_size[1]), _temperature[1]);
		}
	}
}

create_border = function(){
    for(var i = 0; i < TileW; i++){
    	for(var j = 0; j < TileH; j++){
    		if (i == 0 || j == 0 || i == TileW - 1 || j == TileH - 1){
    			tilemap_set(TilesCollision, true, i, j);
    		}
    	}
    }
}