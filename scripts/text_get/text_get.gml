/// @func text_get(index)
function text_get(_index){ 
	var _file_name = "localisation.csv";
	var _delay = 1;	//	INDEX -> first language

	if (!file_exists(_file_name)){
		show_debug_message("text_get: The file does not exist!") ; 
		return "";
	}
	
	var _csv = load_csv(_file_name);
	var _grid_height = ds_grid_height(_csv);
	var _text = "";
	
	for(var i = 0; i < _grid_height; i++){
		if (ds_grid_get(_csv, 0, i) == _index){
			_text = ds_grid_get(_csv, _delay + global.Language, i);
		}
	}	
	 
	if (_text == ""){
		show_debug_message($"text_get: Text with index {_index} not found!");
		return "";
	}
	
	_text = string_replace_all(_text, "\\n", "\n");
	
	return string_lower(_text);
}