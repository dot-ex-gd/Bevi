CanPress = false;
Buttons = [text_get("text_select_world"), text_get("text_new_world"), text_get("text_tlanguage"), text_get("text_back")];
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

LanguageName = text_get("text_language");
do_language = function(){
    global.Language = !global.Language;
    LanguageName = text_get("text_language");
    
    ini_open("/settings.ini");
    ini_write_real("global", "lang", global.Language);
    ini_close();
    
    room_restart();
}
do_back = function(){
	instance_destroy();
	
	instance_create_depth(152, 88, -200, ObButtonPlay, {Number : false});
	instance_create_depth(152, 104, -200, ObButtonExit, {Number : true});
}

Do = [do_sworld, do_nworld, do_language, do_back];
DoDT = ["", "", ": " + LanguageName, ""];

var _len = array_length(Buttons);
for(var i = 0; i < _len; i++){
	Width[i] = string_width(Buttons[i] + DoDT[i]);
	Height[i] = string_height(Buttons[i] + DoDT[i]);
}

BackAlpha = 0.3;