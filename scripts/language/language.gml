global.languages = [];
global.languagesConf = [];
global.languageSprite = noone;
global.languageFont = noone;
global.languageLocalization = noone;

/// @desc return text from localization file using _index as first key
function get_text_localize(_index){
	var _licalization_file = $"{SAVE_DIR}{LOCALIZATION_DIR}{global.languageLocalization}";
	var _offset = 1; // key/index --> text
	
	if (!file_exists(_licalization_file)){
		if (DEBUG){
			show_debug_message($"localisation file {_licalization_file} does not exist");
		}
		
		return "";
	}
	
	var _localization_csv = load_csv(_licalization_file);
	var _grid_height = ds_grid_height(_localization_csv);
	var _return_text = "";
	
	for(var _col = 0; _col < _grid_height; _col++){
		if (_localization_csv[# 0, _col] == _index){
			_return_text = _localization_csv[# 1, _col];
			break;
		}
	}
	
	if (_return_text == ""){
		if (DEBUG){
			show_debug_message($"text with key {_index} does not found");
		}
		
		ds_grid_destroy(_localization_csv);
		return "";
	}
	
	_return_text = string_replace_all(_return_text, "\\n", "\n");
	
	ds_grid_destroy(_localization_csv);
	return string_lower(_return_text);
}

/// @desc load from config file
function change_language(_lang_config){
	if (DEBUG){
		show_debug_message($"change language: {_lang_config}");
	}
	
	if (sprite_exists(global.languageSprite)){
		sprite_delete(global.languageSprite);
	}
	if (font_exists(global.languageFont)){
		font_delete(global.languageFont);
	}
	
	var _id = $"{SAVE_DIR}{LOCALIZATION_DIR}";
	var _image_num = 0;
	var _letters = "";
	var _sprite = "";
	
	var _conf_file = load_csv($"{_id}{_lang_config}");
	
	var _height = ds_grid_height(_conf_file);
	for(var _col = 0; _col < _height; _col++){
		switch(_conf_file[# 0, _col]){
			case "letters":
				_letters = _conf_file[# 1, _col];
			break;
			case "sprite":
				_sprite = _conf_file[# 1, _col];
			break;
			case "loc":
				global.languageLocalization = _conf_file[# 1, _col];
			break;
		}
	}
	
	ds_grid_destroy(_conf_file);
	
	_image_num = string_length(_letters);
	
	if (DEBUG){
		show_debug_message($"temp img num: {_image_num}");
		show_debug_message($"temp letters: {_letters}");
		show_debug_message($"temp sprite: {_sprite}");
	}
	
	global.languageSprite = sprite_add($"{_id}{_sprite}", _image_num - 1, true, false, 0, 0);
	global.languageFont = font_add_sprite_ext(global.languageSprite, _letters, true, -1);
	
	if (DEBUG){
		show_debug_message($"langFont: {global.languageFont}");
		show_debug_message($"langLoc: {global.languageLocalization}");
		show_debug_message($"langSpr: {global.languageSprite}");
	}
}

function get_languages(){
	global.languages = [];
	global.languagesConf = [];
	
	
	var _file_name = file_find_first($"{SAVE_DIR}{LOCALIZATION_DIR}" + "*.csv", fa_directory);
	var _max_try = 200;
	
	while(_file_name != ""){
		var _split = string_split(_file_name, "_");
		var _split_len = array_length(_split);
		
		if (array_contains(global.languages, _file_name) || array_contains(global.languagesConf, _file_name)){
			if (DEBUG){
				show_debug_message($"language array already contain this value: {_file_name} | exit");
			}
			break;
		}
		
		if (_split_len > 1){
			array_push(global.languagesConf, _file_name);
		}else{
			array_push(global.languages, _file_name);
		}
		
		if (DEBUG){
			show_debug_message($"reading localization files... {_file_name}");
		}
		
		_file_name = file_find_next();
		
		_max_try--;
		if (!_max_try) { break; }
	}
	
	file_find_close();
	
	if (DEBUG){
		show_debug_message($"localization config files: {global.languagesConf}");
		show_debug_message($"localization files: {global.languages}");
	}
}

get_languages();
change_language(global.languagesConf[1]);
show_message(get_text_localize("item_rock_dsc"));