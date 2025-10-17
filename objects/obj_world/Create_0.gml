random_set_seed(seed1);

room_width = worldWidth * TILE_SIZE;
room_height = worldHeight * TILE_SIZE;

if (isGenerate){
	if (DEBUG){
		show_debug_message($"world generation");
	}
}else{
	if (DEBUG){
		show_debug_message($"world load");
	}
}

instance_create_depth(0, 0, 0, obj_world_maps, {isGenerate: isGenerate});
instance_create_depth(0, 0, 0, obj_world_tiles, {isGenerate: isGenerate});
instance_create_depth(0, 0, 0, obj_chunk);