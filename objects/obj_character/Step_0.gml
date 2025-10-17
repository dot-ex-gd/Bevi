if (stepPoints >= 1){
	var _case_modifier = keyboard_check(vk_control);
	var _dir_x = 0;
	var _dir_y = 0;
	
	if (!_case_modifier){
		var _move = true;
		if (keyboard_check_pressed(keyInteractive)){
			interactive_state(interactive);
			_move = false;
		}
		
		if (_move){
			_dir_x = (keyboard_check(keyRight) - keyboard_check(keyLeft));
			_dir_y = (keyboard_check(keyDown) - keyboard_check(keyUp));
		}
	}
	
	var _change_inventory_state = (keyboard_check_pressed(keyInventory));
	if (_change_inventory_state){
		if (!_case_modifier){
			inventory_open();
		}
	}
	
	move(_dir_x, _dir_y);
}