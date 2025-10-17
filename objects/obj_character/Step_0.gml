if (stepPoints >= 1){
	var _dir_x = (keyboard_check(keyRight) - keyboard_check(keyLeft));
	var _dir_y = (keyboard_check(keyDown) - keyboard_check(keyUp));
	
	move(_dir_x, _dir_y);
}