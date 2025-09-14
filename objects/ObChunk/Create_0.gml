LoadChunks = [];
Location = $"/worlds/{ObWorld.WorldName}"
Seed1 = ObWorld.Seed;
Seed2 = ObWorld.Seed2;

CurX = 0;
CurY = 0;
PrevX = 0;
PrevY = 0;

update = function(){
	var _x, _y;
	for(_x = -1; _x < 2; _x++){
		for(var _y = -1; _y < 2; _y++){
			if (CurX + _x < 0 || CurY + _y < 0) {continue; }
			if (!is_generate(CurX + _x, CurY + _y)){
				random_set_seed(((CurX + _x) * Seed1) & ((CurY + _y) * Seed2));
				generate(CurX + _x, CurY + _y);
			}else{
				if (!is_load(CurX + _x, CurY + _y)){
					load(CurX + _x, CurY + _y);
				}
			}
		}
	}
	
	random_set_seed(Seed1);
}

is_generate = function(_chunk_x, _chunk_y){
	var _id = $"X{_chunk_x}Y{_chunk_y}";
	return (file_exists($"{Location}/{_id}.buf"));
}

is_load = function(_chunk_x, _chunk_y){
	var i, _len = array_length(LoadChunks), _id = $"X{_chunk_x}Y{_chunk_y}";
	for(i = 0; i < _len; i++){
		if (LoadChunks[i] == _id) { return true; }
	}
	
	return false;
}

generate = function(_chunk_x, _chunk_y){
	var _x, _y, _obj, _rand, _tile, _tiles = ObWorld.Tiles, _map_t;
	var _ts2 = TILE_SIZE / 2;
	
	var _chunk_xoffset = _chunk_x * CHUNK_SIZE * TILE_SIZE;
	var _chunk_yoffset = _chunk_y * CHUNK_SIZE * TILE_SIZE;
	
	var _in_chunk_xoffset = _chunk_x * CHUNK_SIZE;
	var _in_chunk_yoffset = _chunk_y * CHUNK_SIZE;
	
	var _xpos = _chunk_x;
	var _ypos = _chunk_y;
	
	for(_x = _xpos; _x < _xpos + CHUNK_SIZE; _x++){
		for(_y = _ypos; _y < _ypos + CHUNK_SIZE; _y++){
			_tile = tilemap_get(_tiles, _x + _in_chunk_xoffset, _y + _in_chunk_yoffset);
			_obj = noone;
			_map_t = ObWorld.TemperatureMap[# _x + _in_chunk_xoffset, _y + _in_chunk_yoffset];
			
			_rand = irandom(250);
			switch(_tile){
				case tile.grass:
					switch(_rand){
						case 1: case 2: case 3: case 4:
							_obj = ObTree;
						break;
						case 5:
							_obj = ObPeg;
						break;
						case 6: case 7:
							_obj = irandom(2) ? ObStick : ObRock;
						break;
						case 8: case 9: case 10: case 11: case 12:
							_obj = ObGrass;
						break;
						case 13: case 14:
							_obj = irandom(1) ? ObManaFlower : ObHearthFlower;
						break;
					}
				break;
				case tile.sand:
					switch(_rand){
						case 1: case 2: case 3:
							if (_map_t > 0.46){
								_obj = ObSkorpionSpawner;
							}
						break;
						case 4: case 5: case 6: case 7: case 8: case 9:
							if (_map_t > 0.46){
								_obj = ObDesertTree;
							}
						break;
						case 10: case 11: case 12:
							_obj = ObDesertSpikes;
						break;
					}
				break;
			}
			
			if (_obj){
				instance_create_depth(_x * TILE_SIZE + _ts2 + _chunk_xoffset, _y * TILE_SIZE + _ts2 + _chunk_yoffset, 0, _obj);
			}
		}
	}
	
	if (!is_load(_chunk_x, _chunk_y)){
		array_push(LoadChunks, $"X{_chunk_x}Y{_chunk_y}");
	}
}

load = function(_chunk_x, _chunk_y){
	var _id = $"X{_chunk_x}Y{_chunk_y}";
	var _name = $"{Location}/{_id}.buf";
	
	var _buff_chunk = buffer_load(_name);
	if (_buff_chunk == -1){
		exit;
	}
	
	var _chunk_xoffset = (_chunk_x + CurX) * CHUNK_SIZE * TILE_SIZE;
	var _chunk_yoffset = (_chunk_y + CurY) * CHUNK_SIZE * TILE_SIZE;
	
	var _chunk_size = CHUNK_SIZE * TILE_SIZE;
	
	buffer_seek(_buff_chunk, buffer_seek_start, 0);
	var _count = buffer_read(_buff_chunk, buffer_u32);
	
	var i, _struct;
	var _parent_name;
	var _x;
	var _y;
	var _obj_name;
	var _step_points;
	var _health;
	var _imi;
	var _attack_points;
	var _index;
	var _parent_ind;
	for(i = 0; i < _count; i++){
		_struct = {};
		_parent_name = buffer_read(_buff_chunk, buffer_string);
		_x = buffer_read(_buff_chunk, buffer_u32);
		_y = buffer_read(_buff_chunk, buffer_u32);
		_obj_name = buffer_read(_buff_chunk, buffer_string);
		_parent_ind = asset_get_index(_parent_name);
		
		switch(object_get_parent(_parent_ind)){
			case ObEntity:
				_step_points = buffer_read(_buff_chunk, buffer_u32);
				_health = buffer_read(_buff_chunk, buffer_u32);
				
				_struct = {StepPoints: _step_points, Health: _health};
			break;
			case ObEnemy:
				_step_points = buffer_read(_buff_chunk, buffer_u32);
				_health = buffer_read(_buff_chunk, buffer_u32);
				_attack_points = buffer_read(_buff_chunk, buffer_u32);
				
				_struct = {StepPoints: _step_points, Health: _health, AttackPoints: _attack_points};
			break;
			case ObGrowing:
				_imi = buffer_read(_buff_chunk, buffer_u32);
				_health = buffer_read(_buff_chunk, buffer_u32);
				
				_struct = {image_index: _imi, Health: _health};
			break;
			case ObDestroyable:
				_health = buffer_read(_buff_chunk, buffer_u32);
				
				_struct = {Health: _health};
			break;
		}
		
		_index = asset_get_index(_obj_name);
		if (_index != -1){
			instance_create_depth(_x, _y, 0, _index, _struct);
		}else{
			show_message($"i {i}: {_obj_name}");
		}
		delete _struct;
	}
	
	buffer_delete(_buff_chunk);
	if (!is_load(_chunk_x, _chunk_y)){
		array_push(LoadChunks, $"X{_chunk_x}Y{_chunk_y}");
	}
}

unload = function(_chunk_x, _chunk_y){
	var _chunk_xoffset = _chunk_x * CHUNK_SIZE * TILE_SIZE;
	var _chunk_yoffset = _chunk_y * CHUNK_SIZE * TILE_SIZE;
	
	var _chunk_size = CHUNK_SIZE * TILE_SIZE;
	
	var _list = ds_list_create();
	var _count = collision_rectangle_list(_chunk_xoffset, _chunk_yoffset, _chunk_xoffset + _chunk_size, _chunk_yoffset + _chunk_size, ObCulling, 1, 1, _list, false);
	
	var i, _len = ds_list_size(_list);
	for(i = 0; i < _len; i++){
		_list[| i].drop = function(){}
		instance_destroy(_list[| i]);
	}
	
	if (is_load(_chunk_x, _chunk_y)){
		var _len = array_length(LoadChunks), _id = $"X{_chunk_x}Y{_chunk_y}";
		
		for(var i = 0; i < _len; i++){
			if (LoadChunks[i] == $"X{_chunk_x}Y{_chunk_y}"){
				array_delete(LoadChunks, i, -1);
				break;
			}
		}
	}
}

save = function(_chunk_x, _chunk_y){
	var _id = $"X{_chunk_x}Y{_chunk_y}";
	var _name = $"{Location}/{_id}.buf";
	file_delete(_name);
	
	var _buff_chunk = buffer_create(1024 * 1024 * 8, buffer_grow, 1);
	
	var _chunk_xoffset = _chunk_x * CHUNK_SIZE * TILE_SIZE;
	var _chunk_yoffset = _chunk_y * CHUNK_SIZE * TILE_SIZE;
	
	var _chunk_size = CHUNK_SIZE * TILE_SIZE;
	
	var _list = ds_list_create();
	var _delay = 8;
	var _count = collision_rectangle_list(_chunk_xoffset + _delay, _chunk_yoffset + _delay, _chunk_xoffset + _chunk_size - _delay, _chunk_yoffset + _chunk_size - _delay, ObCulling, 1, 1, _list, false);
	
	buffer_seek(_buff_chunk, buffer_seek_start, 0);
	buffer_write(_buff_chunk, buffer_u32, _count);
	
	var i;
	var _obj;
	var _parent;
	var _parent_name;
	var _obj_index;
	var _obj_name;
	
	for(i = 0; i < _count; i++){
		_obj = _list[| i];
		_parent = object_get_parent(_obj.object_index);
		_parent_name = object_get_name(_obj.object_index);
		buffer_write(_buff_chunk, buffer_string, _parent_name);
		buffer_write(_buff_chunk, buffer_u32, _obj.x);
		buffer_write(_buff_chunk, buffer_u32, _obj.y);
		buffer_write(_buff_chunk, buffer_string, object_get_name(_obj.object_index));
		
		switch(_parent){
			case ObEntity:
				buffer_write(_buff_chunk, buffer_u32, _obj.StepPoints);
				buffer_write(_buff_chunk, buffer_u32, _obj.Health);
			break;
			case ObEnemy:
				buffer_write(_buff_chunk, buffer_u32, _obj.StepPoints);
				buffer_write(_buff_chunk, buffer_u32, _obj.Health);
				buffer_write(_buff_chunk, buffer_u32, _obj.AttackPoints);
			break;
			case ObGrowing:
				buffer_write(_buff_chunk, buffer_u32, _obj.image_index);
				buffer_write(_buff_chunk, buffer_u32, _obj.Health);
			break;
			case ObDestroyable:
				buffer_write(_buff_chunk, buffer_u32, _obj.Health);
			break;
		}
	}
	
	buffer_save(_buff_chunk, _name);
	buffer_delete(_buff_chunk);
	ds_list_destroy(_list);
}

alarm[0] = 5;