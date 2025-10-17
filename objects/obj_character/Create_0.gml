xp = 0;
hp = 0;
mana = 0;

keyUp = ord("W");
keyDown = ord("S");
keyLeft = ord("A");
keyRight = ord("D");

check_collision = function(_dir_x, _dir_y){
	return false;
}

moevePermament = false;
move = function(_dir_x, _dir_y){
	if (_dir_x == 0 && _dir_y == 0) { exit; }
	
	if (!check_collision(_dir_x, _dir_y)){
		x += _dir_x * TILE_SIZE;
		y += _dir_y * TILE_SIZE;
	}
	
	stepPoints --;
	obj_step_controller.step();
}