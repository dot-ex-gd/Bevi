function get_pressed(_line){
	_line = string_replace_all(_line, "|", " | ");
	_line = string_replace_all(_line, "+", " + ");
	_line = string_trim(_line);

	var _parts = string_split(_line, " ", true);
	var _len = array_length(_parts);

	var _blocks = [];
	var _current_block = [];
	
	var i, t;
	for(i = 0; i < _len; i++){
		t = _parts[i];
		if (t == "|"){
			if (array_length(_current_block) > 0){
				array_push(_blocks, _current_block);
				_current_block = [];
			}
		}else if (t == "+"){
			continue;
		}else{
			array_push(_current_block, t);
		}
	}
	
	if (array_length(_current_block) > 0){
		array_push(_blocks, _current_block);
	}

	if (array_length(_blocks) == 0) { return false; }

	function check_token(_tok){
		var _len_tok = string_length(_tok);
		if (_len_tok == 0) { return false; }

		if (string_char_at(_tok, 1) == "^"){
			if (string_length(_tok) < 2) { return false; }
			var _base = string_delete(_tok, 1, 1);
			
			if (string_length(_base) == 1){
				return (keyboard_check(vk_shift) && keyboard_check(ord(string_upper(_base))));
			}else{
				var _vk = get_vk(_base);
				return (keyboard_check(_vk) && keyboard_check(vk_shift));
			}
		}

		if (_len_tok == 1){
			return keyboard_check(ord(string_upper(_tok)));
		}

		return keyboard_check(get_vk(_tok));
	};
	
	var i, j, _len = array_length(_blocks), _block_len, _block, _temp;
	for(i = 0; i < _len; i++){
		_block = _blocks[i];
		_temp = true;
		_block_len = array_length(_block);
		
		for(j = 0; j < array_length(_block); j++){
			if (!check_token(_block[j])){
				_temp = false;
				break;
			}
		}
		if (_temp) { return true; }
	}

	return false;
}

function get_vk(_line){
	switch(_line){
		case "left": return vk_left;
		case "right": return vk_right;
		case "up": return vk_up;
		case "down": return vk_down;
		case "space": return vk_space;
		case "enter": return vk_enter;
		case "ctrl": return vk_control;
		case "esc": return vk_escape;
		case "tab": return vk_tab;
	}

	return vk_anykey;
}
