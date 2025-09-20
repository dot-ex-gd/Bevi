CanPress = false;
Title = text_get("text_keybinds");
Info = text_get("keybind_text_instruction");
Font = global.FontDark;

x = room_width / 2;

TextBinds = [
	text_get("keybind_move_left"),
	text_get("keybind_move_right"),
	text_get("keybind_move_up"),
	text_get("keybind_move_down"),
	text_get("keybind_interact"),
	text_get("keybind_inventory"),
	text_get("keybind_crafts"),
	text_get("keybind_craft"),
	text_get("keybind_save"),
	text_get("keybind_discard_from_inventory"),
	text_get("keybind_equip"),
	text_get("keybind_attack_mode"),
];
Binds = [
	ObController.KeybindMoveLeft,
	ObController.KeybindMoveRight,
	ObController.KeybindMoveUp,
	ObController.KeybindMoveDown,
	ObController.KeybindInteract,
	ObController.KeybindInventory,
	ObController.KeybindCrafts,
	ObController.KeybindCraft,
	ObController.KeybindSave,
	ObController.KeybindDiscardFromInventory,
	ObController.KeybindEquip,
	ObController.KeybindAttackMode,
];

Skip = 0;
Current = 0;
MaxShow = 5;

BackAlpha = 0;

Width = [];
var _len = array_length(TextBinds);

for(var i = 0; i < _len; i++){
	Width[i] = string_width(TextBinds[i]);
}

Change = false;
ChangeText = "";
do_write = function(){
	if (Change){
		if (ChangeText == ""){
			ChangeText = Binds[Current];
		}
		
		if (!keyboard_check_pressed(vk_enter)){
			if (keyboard_check_pressed(vk_backspace)){
				Binds[Current] = string_copy(Binds[Current], 0, string_length(Binds[Current]) - 1);
				
			}else if (keyboard_check_pressed(vk_escape)){
				Binds[Current] = ChangeText;
				Change = false;
				
			}else{
				Binds[Current] += keyboard_lastchar;
			}
		}
	}else{
		ChangeText = "";
	}
	
	keyboard_lastchar = "";
	
	ini_open("keybinds.ini");
	var _len = array_length(Binds);
	for(var i = 0; i < _len; i++){
		Valid[i] = is_valid(Binds[i]);
		
		if (Valid[i]){
			ini_write_string(TextBinds[i], "val", Binds[i]);
		}
	}
	ini_close();
}

Valid = [];
function is_valid(_line){
	_line = string_replace_all(_line, "|", " | ");
	_line = string_replace_all(_line, "+", " + ");
	_line = string_trim(_line);
	
	var _parts = string_split(_line, " ", true);
	var _len = array_length(_parts);
	
	_keywords = ["up", "left", "down", "right", "space", "enter", "ctrl", "esc", "tab"];
	
	is_separator = function(tok){
		return (tok == "|" || tok == "+");
	};
	
	is_keyword = function(tok){
		for(var k = 0; k < array_length(_keywords); k++){
			if (tok == _keywords[k]) { return true; }
		}
		return false;
	};
	
	var is_symbol = function(tok){
		if (tok == "") { return false; }
		if (is_separator(tok)) { return false; }
		if (is_keyword(tok)) { return true; }
		
		if (string_char_at(tok, 0) == "^"){
			if (string_length(tok) == 1) { return true; }
			if (string_length(tok) == 2) { return true; }
			return false;
		}
		
		if (string_length(tok) == 1) { return true; }
		
		return false;
	};
	
	if (_len == 0) { return false; }
	if (is_separator(_parts[0]) || is_separator(_parts[_len - 1])) {return false; }
	
	var expect_symbol = true, _tok, _rest;
	for(var i = 0; i < _len; i++){
		_tok = _parts[i];
		
		if (expect_symbol){
			if (!is_symbol(_tok)) { return false; }
			
			if (string_char_at(_tok, 0) == "^"){
				_rest = string_delete(_tok, 1, 1);
				if (is_keyword(_rest)) { return false; }
			}
			expect_symbol = false;
		}else{
			if (!is_separator(_tok)) { return false; }
			expect_symbol = true;
		}
	}
	
	return !expect_symbol;
}

for(var i = 0; i < _len; i++){
	Valid[i] = is_valid(Binds[i]);
}

alarm[0] = KEY_DELAY;