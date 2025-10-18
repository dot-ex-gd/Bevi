if (DEBUG){
	show_debug_message($"Inventory key detect start. cellSelect: {cellSelect} | cellSkip: {cellSkip}");
}

if (keyboard_check_pressed(keyThrow)){
	obj_character.inventory_throw(cellSelect);
}

var _cells = array_length(obj_character.inventory);
var _skip_delta = 0;

if (keyboard_check_pressed(keyLeft)){
	cellSelect--;
	_skip_delta--;
}
if (keyboard_check_pressed(keyRight)){
	cellSelect++;
	_skip_delta++;
}
if (keyboard_check_pressed(keyUp)){
	cellSelect -= 3;
	_skip_delta -= 3;
}
if (keyboard_check_pressed(keyDown)){
	cellSelect += 3;
	_skip_delta += 3;
}

cellSelect = clamp(cellSelect, 0, _cells - 1);

if ((cellSelect >= cellShowMax + cellSkip) || (cellSelect <= cellSkip)){
	cellSkip += _skip_delta;
	cellSkip = clamp(cellSkip, 0, _cells - cellShowMax);
	cellSkip = max(0, cellSkip);
}

if (DEBUG){
	show_debug_message($"Inventory key detect end. cellSelect: {cellSelect} | cellSkip: {cellSkip}");
}