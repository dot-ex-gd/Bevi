if (Select < array_length(Buttons)){
	world_delete(Buttons[Select]);
	
	Buttons = world_list_load();
	array_push(Buttons, text_get("text_back"));
}