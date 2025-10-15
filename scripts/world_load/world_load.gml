/// @desc	world_load(filename)
/// @func	load selected world

function world_load(_filename){
	var _dir = $"{GLOBAL_DIR}{WORLD_DIR}/{_filename}";
	
	var _buff_tiles = buffer_load($"{_dir}/tiles.buf");
	var _buff_instances = buffer_load($"{_dir}/instances.buf");
	var i, j, _size_w = buffer_read(_buff_tiles, buffer_u16), _size_h = buffer_read(_buff_tiles, buffer_u16);
	
	room_width = _size_w * TILE_SIZE;
	room_height = _size_h * TILE_SIZE;
	
	init_all();
	var _tiles = ObWorld.Tiles, _coll = ObWorld.TilesCollision;
	
	var _buffer_collision = buffer_load($"{_dir}/coll.buf");
	for(i = 0; i < _size_w; i++){
		for(j = 0; j < _size_h; j++){
			if (_buff_tiles != -1){
				tilemap_set(_tiles, buffer_read(_buff_tiles, buffer_u8), i, j);
			}
			
			if (_buffer_collision != -1){
				tilemap_set(_coll, buffer_read(_buffer_collision, buffer_u8), i, j);
			}
		}
	}
	buffer_delete(_buff_tiles);
	buffer_delete(_buffer_collision);
	
	var _buff_character = buffer_load($"{_dir}/character.buf");
	if (_buff_character != -1){
		var _x = buffer_read(_buff_character, buffer_u32);
		var _y = buffer_read(_buff_character, buffer_u32);
		var _hp = buffer_read(_buff_character, buffer_u32);
		var _mhp = buffer_read(_buff_character, buffer_u32);
		var _mn = buffer_read(_buff_character, buffer_u32);
		var _mmn = buffer_read(_buff_character, buffer_u32);
		var _xp = buffer_read(_buff_character, buffer_u32);
		var _nxp = buffer_read(_buff_character, buffer_u32);
		var _inarm = buffer_read(_buff_character, buffer_string);
		var _onhead = buffer_read(_buff_character, buffer_string);
		var _onbody = buffer_read(_buff_character, buffer_string);
		var _onleggins = buffer_read(_buff_character, buffer_string);
		var _onfoot = buffer_read(_buff_character, buffer_string);
		var _inv = buffer_read(_buff_character, buffer_string);
		var _char = instance_create_depth(_x, _y, 0, ObCharacter);
		
		buffer_delete(_buff_character);
		
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
		
		_char.inventory_weight_upd();
		_char.protection_update();
		global.PlayerExist = true;
		ObWorld.character_init(_x, _y);
	}
	
	var _buff_world = buffer_load($"{_dir}/world.buf");
	if (_buff_world != -1){
		ObTime.Day = buffer_read(_buff_world, buffer_u16);
		ObTime.Night = buffer_read(_buff_world, buffer_u16);
		ObTime.Second = buffer_read(_buff_world, buffer_u16);
		ObTime.Minute = buffer_read(_buff_world, buffer_u16);
		ObTime.Hour = buffer_read(_buff_world, buffer_u16);
		ObTime.ToNightK = buffer_read(_buff_world, buffer_f16);
		ObTime.Time = buffer_read(_buff_world, buffer_u8);
		ObTime.LightIntensity = buffer_read(_buff_world, buffer_u16);
		ObTime.SolarEclipse = buffer_read(_buff_world, buffer_bool);
		ObTime.LunarEclipse = buffer_read(_buff_world, buffer_bool);
		ObTime.surface_update();
		
		buffer_delete(_buff_world);
	}
}

function world_list_load(){
	var _list = [];
	var _buff_worlds = buffer_load($"world_list.txt");
	
	if (_buff_worlds != -1){	
		_list = json_parse(buffer_read(_buff_worlds, buffer_string));
	}
	
	if (_buff_worlds){
		buffer_delete(_buff_worlds);
	}
	
	return _list;
}