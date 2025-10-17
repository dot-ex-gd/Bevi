saveDirectory = $"{WORLDS_DIR}/{obj_world.worldName}";

seed1 = obj_world.seed1;
seed2 = obj_world.seed2;

curX = 0;
curY = 0;
prevCurX = 0;
prevCurY = 0;

chunks_update = function(){
	var _chunk_x;
	var _chunk_y;
	
	for(var _x = -1; _x < 2; _x++){
		for(var _y = -1; _y < 2; _y++){
			_chunk_x = curX + _x;
			_chunk_y = curY + _y;
			
			if ((_chunk_x < 0) || (_chunk_y < 0)) { continue; }
			
			if (!is_chunk_generate(_chunk_x, _chunk_y)){
				random_set_seed((_chunk_x * seed1) & (_chunk_y * seed2));
				chunk_generate(_chunk_x, _chunk_y);
			}else{
				load_chunk(_chunk_x, _chunk_y);
			}
		}
	}
	
	random_set_seed(seed1);
}

is_chunk_generate = function(_chunk_x, _chunk_y){
	var _id = file_exists($"X{_chunk_x}Y{_chunk_y}");
	
	return (file_exists($"{saveDirectory}/{_id}.buf"));
}

load_chunk = function(_chunk_x, _chunk_y){
	
}

unload_chunk = function(_chunk_x, _chunk_y){
	var _chunk_in_tile_size = CHUNK_SIZE * TILE_SIZE;
	var _chunk_x_offset = _chunk_x * _chunk_in_tile_size;
	var _chunk_y_offset = _chunk_y * _chunk_in_tile_size;
	
	var _list = ds_list_create();
	var _count = collision_rectangle_list(_chunk_x_offset, _chunk_y_offset, _chunk_x_offset + _chunk_in_tile_size, _chunk_y_offset + _chunk_in_tile_size, obj_culling, true, true, _list, false);
	
	for(var i = 0; i < _count; i++){
		instance_destroy(_list[| i]);
	}
	
	ds_list_destroy(_list);
}

save_chunk = function(_chunk_x, _chunk_y){
	var _id = $"X{_chunk_x}Y{_chunk_y}";
	var _name = $"{saveDirectory}/{_id}.buf";
	file_delete(_name);
	
	var _buf_chunk = buffer_create(2048, buffer_grow, 1);
	
	var _chunk_in_tile_size = CHUNK_SIZE * TILE_SIZE;
	var _chunk_x_offset = _chunk_x * _chunk_in_tile_size;
	var _chunk_y_offset = _chunk_y * _chunk_in_tile_size;
	
	var _list = ds_list_create();
	var _delay = 8;
	var _count = collision_rectangle_list(_chunk_x_offset + _delay, _chunk_y_offset + _delay, _chunk_x_offset + _chunk_in_tile_size - _delay, _chunk_y_offset + _chunk_in_tile_size - _delay, obj_culling, true, true, _list, false);
	
	buffer_write(_buf_chunk, buffer_u16, _count);
	
	for(var i = 0; i < _count; i++){
		var _obj = _list[| i];
		var _obj_parent = object_get_parent(_obj.object_index);
		var _obj_name = object_get_name(_obj.object_index);
		
		buffer_write(_buf_chunk, buffer_string, _obj_name);
		buffer_write(_buf_chunk, buffer_u16, _obj.x - _chunk_x_offset);
		buffer_write(_buf_chunk, buffer_u16, _obj.y - _chunk_y_offset);
		
		switch(_obj_parent){
			default:
		}
	}
	
	buffer_save(_buf_chunk, _name);
	buffer_delete(_buf_chunk);
	ds_list_destroy(_list);
}

load_chunk = function(_chunk_x, _chunk_y){
	var _id = $"X{_chunk_x}Y{_chunk_y}";
	var _name = $"{saveDirectory}/{_id}.buf";
	
	var _buf_chunk = buffer_load(_name);
	if (_buf_chunk == -1){
		if (DEBUG){
			show_debug_message($"Error openning chunk buffer: X: {_chunk_x} Y: {_chunk_y}");
		}
		
		exit;
	}
	
	var _chunk_in_tile_size = CHUNK_SIZE * TILE_SIZE;
	var _chunk_x_offset = _chunk_x * _chunk_in_tile_size;
	var _chunk_y_offset = _chunk_y * _chunk_in_tile_size;
	
	var _count = buffer_read(_buf_chunk, buffer_u16);
	for(var i = 0; i < _count; i++){
		var _struct = {};
		var _obj_name = buffer_read(_buf_chunk, buffer_string);
		var _asset = asset_get_index(_obj_name);
		
		if (_asset){
			var _obj_x = buffer_read(_buf_chunk, buffer_u16);
			var _obj_y = buffer_read(_buf_chunk, buffer_u16);
			
			switch(object_get_parent(_obj_name)){
				default:
			}
			
			var _instance = instance_create_depth(_obj_x + _chunk_x_offset, _obj_y + _chunk_y_offset, 0, _asset, _struct);
			_instance.image_xscale = 1;
			_instance.image_yscale = 1;
		}else{
			if (DEBUG){
				show_debug_message($"Error load chunk: X: {_chunk_x} Y: {_chunk_y}\nFailed to load object: {_obj_name} (as {_asset})");
			}
		}
		
		delete _struct;
	}
}

chunk_generate = function(_chunk_x, _chunk_y){
	var _chunk_in_tile_size = CHUNK_SIZE * TILE_SIZE;
	var _chunk_x_offset = _chunk_x * _chunk_in_tile_size;
	var _chunk_y_offset = _chunk_y * _chunk_in_tile_size;
	
	var _in_chunk_x_offset = _chunk_x * CHUNK_SIZE;
	var _in_chunk_y_offset = _chunk_y * CHUNK_SIZE;
	
	for(var _x = 0; _x < CHUNK_SIZE; _x++){
		for(var _y = 0; _y < CHUNK_SIZE; _y++){
			content_generate(_x, _y, _in_chunk_x_offset, _in_chunk_y_offset, _chunk_x_offset, _chunk_y_offset);
		}
	}
}

content_generate = function(_x, _y, _in_chunk_x, _in_chunk_y, _chunk_x_offset, _chunk_y_offset){
	var _x_offset = _x + _in_chunk_x;
	var _y_offset = _y + _in_chunk_y;
	
	var _tile = tilemap_get(obj_world_tiles.tilesetMain, _x_offset, _y_offset);
	var _map_height = obj_world_maps.heightMap[# _x_offset, _y_offset];
	var _map_temperature = obj_world_maps.temperatureMap[# _x_offset, _y_offset];
	var _obj = noone;
	var _params = {};
	
	var _rand = irandom(500);
	switch(_tile){
		case tile.grass:
			switch(_rand){
				case 0: case 1: case 2: case 3: case 4:
					_obj = obj_peg;
				break;
				case 5:
				
				break;
				case 6: case 7:
				
				break;
				case 8: case 9: case 10: case 11: case 12:
				
				break;
				case 13: case 14:
				
				break;
				default:
				
				break;
			}
		break;
		case tile.sand:
			switch(_rand){
				case 0: case 1: case 2:
				
				break;
				case 3: case 4: case 5: case 6: case 7: case 8:
				
				break;
				case 9: case 10: case 11:
				
				break;
				default:
				
				break;
			}
		break;
		case tile.stone:
		
		break;
	}
	
	if (_obj){
		var _obj_x_offset = (TILE_SIZE / 2) + _chunk_x_offset;
		var _obj_y_offset = (TILE_SIZE / 2) + _chunk_y_offset;
		
		instance_create_depth(_x * TILE_SIZE + _obj_x_offset, _y * TILE_SIZE + _obj_y_offset, 0, _obj, _params);
	}
	
	delete _params;
}

alarm[0] = 5;