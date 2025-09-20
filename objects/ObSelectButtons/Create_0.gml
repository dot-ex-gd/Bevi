CanPress = false;
Buttons = [text_get("text_select_world"), text_get("text_new_world"), text_get("text_back")];
Select = 0;

Font = global.FontDark;

do_sworld = function(){
	instance_destroy();
	
	instance_create_depth(x, y, -200, ObSelectWorld);
}
do_nworld = function(){
	instance_destroy();
	
	instance_create_depth(x, y, -200, ObCreateWorld);
}
do_back = function(){
	instance_destroy();
	
	instance_create_depth(152, 88, -200, ObButton);
}

Do = [do_sworld, do_nworld, do_back];

var _len = array_length(Buttons);
for(var i = 0; i < _len; i++){
	Width[i] = string_width(Buttons[i]);
	Height[i] = string_height(Buttons[i]);
}

BackAlpha = 0.3;

alarm[0] = KEY_DELAY;