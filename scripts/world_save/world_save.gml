/// @desc	world_save(filename)
/// @func	save current world

function world_save(_filename){
	if (!directory_exists($"/Worlds")){
		directory_create($"/worlds");
	}
	if (!directory_exists($"/Worlds/{_filename}")){
		directory_create($"/Worlds/{_filename}");
	}
	
	world_list_save(_filename);
	
	var _buff_tiles = buffer_create(4096, buffer_grow, 1); // tiles
	
	var i, j, _size_w = room_width div TILE_SIZE + 1, _size_h = room_height div TILE_SIZE + 1, _tiles = ObWorld.Tiles;
	buffer_write(_buff_tiles, buffer_u16, _size_w);
	buffer_write(_buff_tiles, buffer_u16, _size_h);
	
	for(i = 0; i < _size_w; i++){
		for(j = 0; j < _size_h; j++){
			buffer_write(_buff_tiles, buffer_u8, tilemap_get(_tiles, i, j));
		}
	}
	
	var _cull = ObChunk.CullList;
	var _cull_size = ds_list_size(_cull);
	var _buff_instances = buffer_create(4096, buffer_grow, 1);
	buffer_write(_buff_instances, buffer_u32, _cull_size + instance_number(ObCulling));
	
	with(ObCulling){
		buffer_write(_buff_instances, buffer_u32, x);
		buffer_write(_buff_instances, buffer_u32, y);
		buffer_write(_buff_instances, buffer_string, object_get_name(object_index));
	}
	for(var i = 0; i < _cull_size; i++){
		buffer_write(_buff_instances, buffer_u32, _cull[| i][1]);
		buffer_write(_buff_instances, buffer_u32, _cull[| i][2]);
		buffer_write(_buff_instances, buffer_string, object_get_name(_cull[| i][3]));
	}
	
	var _buf_character = buffer_create(128, buffer_grow, 1);
	buffer_write(_buf_character, buffer_u32, ObCharacter.x);
	buffer_write(_buf_character, buffer_u32, ObCharacter.y);
	buffer_write(_buf_character, buffer_u32, ObCharacter.Health);
	buffer_write(_buf_character, buffer_u32, ObCharacter.MaxHealth);
	buffer_write(_buf_character, buffer_u32, ObCharacter.Mana);
	buffer_write(_buf_character, buffer_u32, ObCharacter.MaxMana);
	buffer_write(_buf_character, buffer_u32, ObCharacter.Xp);
	buffer_write(_buf_character, buffer_u32, ObCharacter.NeedXp);
	buffer_write(_buf_character, buffer_string, json_stringify(ObCharacter.InArm));
	buffer_write(_buf_character, buffer_string, json_stringify(ObCharacter.OnHead));
	buffer_write(_buf_character, buffer_string, json_stringify(ObCharacter.OnBody));
	buffer_write(_buf_character, buffer_string, json_stringify(ObCharacter.OnLeggings));
	buffer_write(_buf_character, buffer_string, json_stringify(ObCharacter.OnFoot));
	buffer_write(_buf_character, buffer_string, json_stringify(ObCharacter.Inventory));
	
	
	buffer_save(_buff_tiles, $"/Worlds/{_filename}/tiles.buf");
	buffer_save(_buff_instances, $"/Worlds/{_filename}/instances.buf");
	buffer_save(_buf_character, $"/Worlds/{_filename}/character.buf");
	buffer_delete(_buff_tiles);
	buffer_delete(_buff_instances);
	buffer_delete(_buf_character);
}

function world_list_save(_filename){
	var _buff_worlds = buffer_load($"/Worlds/world_list.txt");
	var _buff_new = buffer_create(32, buffer_grow, 1);
	var _list = [];
	
	if (_buff_worlds != -1){
		_list = json_parse(buffer_read(_buff_worlds, buffer_string));
	}
	
	var _find = false;
	for(var i = 0; i < array_length(_list); i++){
		if (_list[i] == _filename){
			_find = true;
		}
	}
	
	if (!_find){
		array_push(_list, _filename);
	}
	
	buffer_write(_buff_new, buffer_string, json_stringify(_list));
	
	file_delete($"/Worlds/world_list.txt");
	buffer_save(_buff_new, $"/Worlds/world_list.txt");
	
	if (buffer_exists(_buff_worlds)){
		buffer_delete(_buff_worlds);
	}
	
	buffer_delete(_buff_new);
}