Buttons = [
	text_get("text_tiles_width") + ":", text_get("text_tiles_height") + ":", 
	text_get("text_height_map_iterations") + ":", text_get("text_temperature_map_iterations") + ":",
	text_get("text_create"), text_get("text_back")
];
Select = 0;

WorldWidth = 500;
WWMax = 5000;
WWMin = 450;

WorldHeight = 500;
WHMax = 5000;
WHMin = 450;

HMI = 65;
HMIMin = 0;
HMIMax = 200;

TMI = 6;
TMIMin = 0;
TMIMax = 100;

Font = global.Font;

var _len = array_length(Buttons);
for(var i = 0; i < _len; i++){
	Width[i] = string_width(Buttons[i]);
	Height[i] = string_height(Buttons[i]);
}

do_twidth = function(){
	if (keyboard_lastchar == "a" || mouse_wheel_down()){
		WorldWidth -= 10;
		WorldWidth = clamp(WorldWidth, WWMin, WWMax);
	}
	if (keyboard_lastchar == "d" || mouse_wheel_up()){
		WorldWidth += 10;
		WorldWidth = clamp(WorldWidth, WWMin, WWMax);
	}
	
	if (keyboard_check_pressed(ord("A")) && keyboard_check_pressed(ord("D"))){
		WorldWidth = 500;
	}
	if (keyboard_check_pressed(ord("A")) && keyboard_check_pressed(ord("E"))){
		WorldWidth = WWMin;
	}
	if (keyboard_check_pressed(ord("D")) && keyboard_check_pressed(ord("E"))){
		WorldWidth = WWMax;
	}
	
	keyboard_lastchar = "";
}
do_theight = function(){
	if (keyboard_lastchar == "a" || mouse_wheel_down()){
		WorldHeight -= 10;
		WorldHeight = clamp(WorldHeight, WHMin, WHMax);
	}
	if (keyboard_lastchar == "d" || mouse_wheel_up()){
		WorldHeight += 10;
		WorldHeight = clamp(WorldHeight, WHMin, WHMax);
	}
	if (keyboard_check_pressed(ord("A")) && keyboard_check_pressed(ord("D"))){
		WorldHeight = 500;
	}
	if (keyboard_check_pressed(ord("A")) && keyboard_check_pressed(ord("E"))){
		WorldHeight = WHMin;
	}
	if (keyboard_check_pressed(ord("D")) && keyboard_check_pressed(ord("E"))){
		WorldHeight = WHMax;
	}
	
	keyboard_lastchar = "";
}
do_hmi = function(){
	if (keyboard_lastchar == "a" || mouse_wheel_down()){
		HMI--;
		HMI = clamp(HMI, HMIMin, HMIMax);
	}
	if (keyboard_lastchar == "d" || mouse_wheel_up()){
		HMI++;
		HMI = clamp(HMI, HMIMin, HMIMax);
	}
	if (keyboard_check_pressed(ord("A")) && keyboard_check_pressed(ord("D"))){
		HMI = 65;
	}
	if (keyboard_check_pressed(ord("A")) && keyboard_check_pressed(ord("E"))){
		HMI = HMIMin;
	}
	if (keyboard_check_pressed(ord("D")) && keyboard_check_pressed(ord("E"))){
		HMI = HMIMax;
	}
	
	keyboard_lastchar = "";
}
do_tmi = function(){
	if (keyboard_lastchar == "a" || mouse_wheel_down()){
		TMI--;
		TMI = clamp(TMI, TMIMin, TMIMax);
	}
	if (keyboard_lastchar == "d" || mouse_wheel_up()){
		TMI++;
		TMI = clamp(TMI, TMIMin, TMIMax);
	}
	if (keyboard_check_pressed(ord("A")) && keyboard_check_pressed(ord("D"))){
		TMI = 6;
	}
	if (keyboard_check_pressed(ord("A")) && keyboard_check_pressed(ord("E"))){
		TMI = TMIMin;
	}
	if (keyboard_check_pressed(ord("D")) && keyboard_check_pressed(ord("E"))){
		TMI = TMIMax;
	}
	
	keyboard_lastchar = "";
}
do_create = function(){
	room_set_width(RmWorld, WorldWidth * TILE_SIZE);
	room_set_height(RmWorld, WorldHeight * TILE_SIZE);
	room_goto(RmWorld);
	
	instance_create_depth(0, 0, 0, ObWorld);
	ObWorld.HeightMapNeed = HMI;
	ObWorld.TemperatureMapNeed = TMI;
}
do_back = function(){
	instance_destroy();
	
	instance_create_depth(x, y, depth, ObSelectButtons);
}

Do = [do_twidth, do_theight, do_hmi, do_tmi, do_create, do_back];