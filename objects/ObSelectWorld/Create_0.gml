CanPress = false;
Buttons = [];
Select = 0;

Font = global.Font;

Buttons = world_list_load();
array_push(Buttons, text_get("text_back"));

var _len = array_length(Buttons);
for(var i = 0; i < _len; i++){
	Width[i] = string_width(Buttons[i]);
	Height[i] = string_height(Buttons[i]);
}

load = function(){
	if (Select == array_length(Buttons) - 1){
		instance_destroy();
		
		instance_create_depth(x, y, depth, ObSelectButtons);
	}else{
		room_goto(RmWorld);
		instance_create_depth(0, 0, 0, ObWorld, {WorldName : Buttons[Select], IsLoad : true});
	}
}