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

var _player_spawn = false;
var _counter = 1_000;
while(!_player_spawn){
	var _x = irandom_range(TILE_SIZE, room_width - TILE_SIZE);
	var _y = irandom_range(TILE_SIZE, room_height - TILE_SIZE);
	_x = _x div TILE_SIZE;
	_y = _y div TILE_SIZE;
	
	var _half_tile = TILE_SIZE / 2;
	
	if (tilemap_get(obj_world_tiles.tilesetMain, _x, _y) == tile.grass){
		instance_create_depth(_x * TILE_SIZE + _half_tile, _y * TILE_SIZE + _half_tile, 0, obj_character);
		
		_player_spawn = true;
	}

	_counter--;
}