/// @desc	world_load(filename)
/// @func	load selected world

function world_load(_filename){
	var _buff_tiles = buffer_load($"/Worlds/{_filename}/tiles.buf");
    var _buffer_collision = buffer_load($"/Worlds/{_filename}/coll.buf");
	var _buff_instances = buffer_load($"/Worlds/{_filename}/instances.buf");
	var _buf_character = buffer_load($"/Worlds/{_filename}/character.buf");
	
	var i, j, _size_w = buffer_read(_buff_tiles, buffer_u16), _size_h = buffer_read(_buff_tiles, buffer_u16), _tiles = ObWorld.Tiles, _coll = ObWorld.TilesCollision;
	
	room_width = _size_w * TILE_SIZE;
	room_height = _size_h * TILE_SIZE;
	
	for(i = 0; i < _size_w; i++){
		for(j = 0; j < _size_h; j++){
			tilemap_set(_tiles, buffer_read(_buff_tiles, buffer_u8), i, j);
			tilemap_set(_coll, buffer_read(_buffer_collision, buffer_u8), i, j);
		}
	}
	
	var _x = buffer_read(_buf_character, buffer_u32);
	var _y = buffer_read(_buf_character, buffer_u32);
	var _hp = buffer_read(_buf_character, buffer_u32);
	var _mhp = buffer_read(_buf_character, buffer_u32);
	var _mn = buffer_read(_buf_character, buffer_u32);
	var _mmn = buffer_read(_buf_character, buffer_u32);
	var _xp = buffer_read(_buf_character, buffer_u32);
	var _nxp = buffer_read(_buf_character, buffer_u32);
	var _inarm = buffer_read(_buf_character, buffer_string);
	var _onhead = buffer_read(_buf_character, buffer_string);
	var _onbody = buffer_read(_buf_character, buffer_string);
	var _onleggins = buffer_read(_buf_character, buffer_string);
	var _onfoot = buffer_read(_buf_character, buffer_string);
	var _inv = buffer_read(_buf_character, buffer_string);
	var _char = instance_create_depth(_x, _y, 0, ObCharacter);
	_char.Health = _hp;
	_char.MaxHealth = _mhp;
	_char.Mana = _mn;
	_char.MaxMana = _mmn;
	_char.Xp = _xp;
	_char.NeedXp = _nxp;
	
	if (string_length(_inarm)){
		_char.InArm = json_parse(_inarm);
	}
	if (string_length(_onhead)){
		_char.OnHead = json_parse(_onhead);
	}
	if (string_length(_onbody)){
		_char.OnBody = json_parse(_onbody);
	}
	if (string_length(_onleggins)){
		_char.OnLeggings = json_parse(_onleggins);
	}
	if (string_length(_onfoot)){
		_char.OnFoot = json_parse(_onfoot);
	}
	if (string_length(_inv)){
		_char.Inventory = json_parse(_inv);
	}
	
	global.PlayerExist = true;
	ObWorld.character_init(_x, _y);
	
	buffer_delete(_buff_tiles);
	//buffer_delete(_buff_instances);
	buffer_delete(_buf_character);
}

function world_list_load(){
	var _list = [];
	var _buff_worlds = buffer_load($"/Worlds/world_list.txt");
	
	if (_buff_worlds != -1){	
		_list = json_parse(buffer_read(_buff_worlds, buffer_string));
	}
	
	if (_buff_worlds){
		buffer_delete(_buff_worlds);
	}
	return _list;
}