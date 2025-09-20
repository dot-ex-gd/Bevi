Buttons = [
	text_get("text_world_size") + ": ",
	text_get("text_world_smooth") + ": ",
	text_get("text_world_name") + ": ",
	text_get("text_create"), 
	text_get("text_back")
];
Select = 0;
Font = global.FontDark;

WorldSizeArr = [
	text_get("text_world_size_small"),
	text_get("text_world_size_medium"),
	text_get("text_world_size_big"),
	text_get("text_world_size_giant"),
]
SizeLevel = 0;
WorldSize = "";

WorldSmoothArr = [
	text_get("text_world_smooth_small"),
	text_get("text_world_smooth_medium"),
	text_get("text_world_smooth_big"),
]
SmoothLevel = 0;
WorldSmooth = "";

do_create = function(){
	var _world_w = 500;
	var _world_h = 500;
	var _height_map_need = 65;
	var _temperature_map_need = 5;
	
	
	switch(SizeLevel){
		case 1:
			_world_w = 1000;
			_world_h = 1000;
		break;
		case 2:
			_world_w = 4000;
			_world_h = 4000;
		break;
		case 3:
			_world_w = 10000;
			_world_h = 10000;
		break;
	}
	
	switch(SmoothLevel){
		case 1:
			_height_map_need = 85;
			_temperature_map_need = 10;
		break;
		case 2:
			_height_map_need = 100;
			_temperature_map_need = 15;
		break;
	}
	
	room_set_width(RmWorld, _world_w * TILE_SIZE);
	room_set_height(RmWorld, _world_h * TILE_SIZE);
	room_goto(RmWorld);
	
	if (WorldName == ""){
		WorldName = $"world{irandom(9999999999)}";
	}
	
	instance_create_depth(0, 0, 0, ObWorld, {WorldName : WorldName});
	ObWorld.HeightMapNeed = _height_map_need;
	ObWorld.TemperatureMapNeed = _temperature_map_need;
}

WorldName = "";
IsRename = false;
do_world_name = function(){
	if (keyboard_check_pressed(vk_enter)){
		IsRename = !IsRename;
		keyboard_lastchar = "";
	}
	
	if (IsRename && !keyboard_check_pressed(vk_enter)){
		if (!keyboard_check_pressed(vk_backspace)){
			WorldName = WorldName + string_lower(keyboard_lastchar);
		}
	
		if (keyboard_check_pressed(vk_backspace)){
			WorldName = string_copy(WorldName, 0, string_length(WorldName) - 1);
		}
	}
	
	WorldName = string_copy(WorldName, 0, 16);
	keyboard_lastchar = "";
}

do_back = function(){
	instance_destroy();
	
	instance_create_depth(x, y, depth, ObSelectButtons);
}

do_world_size = function(){
	if (SizeLevel == array_length(WorldSizeArr) - 1){
		SizeLevel = -1;
	}
	
	SizeLevel++;
}
do_world_smooth = function(){
	if (SmoothLevel == array_length(WorldSmoothArr) - 1){
		SmoothLevel = -1;
	}
	
	SmoothLevel++;
}
Do = [do_world_size, do_world_smooth, do_world_name, do_create, do_back];

var _len = array_length(Buttons);
for(var i = 0; i < _len; i++){
	Width[i] = string_width(Buttons[i]);
	Height[i] = string_height(Buttons[i]);
}

BackAlpha = 0.3;

CanPress = false;
alarm[0] = KEY_DELAY;