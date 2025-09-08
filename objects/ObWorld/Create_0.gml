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

ILISize = -1;
ILIBuff = -1;
ILIX = 0;
InstancesLoad = false;
ILT = text_get("text_instances_generation");
instances_load_init = function(_buff){
	ILISize = buffer_read(_buff, buffer_u32);
	ILIBuff = _buff;
	InstancesLoad = true;
	
	alarm[10] = 2;
}