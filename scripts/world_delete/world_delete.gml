/// @desc	world_delete(filename)
function world_delete(_filename){
	var _list = [];
	var _buff_worlds = buffer_load($"world_list.txt");
	
	if (_buff_worlds != -1){	
		_list = json_parse(buffer_read(_buff_worlds, buffer_string));
	}
	
	for(var i = 0; i < array_length(_list); i++){
		if (_list[i] == _filename){
			array_delete(_list, i, -1);
			directory_destroy($"Worlds/{_filename}");
			break;
		}
	}
	
	var _new_buff = buffer_create(32, buffer_grow, 1);
	buffer_write(_new_buff, buffer_string, json_stringify(_list));
	
	if (_buff_worlds){
		buffer_delete(_buff_worlds);
	}
	
	buffer_save(_new_buff, $"world_list.txt");
	buffer_delete(_new_buff);
	return _list;
}