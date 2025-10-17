if (interactive){
	var _x = x + (interactiveX * TILE_SIZE);
	var _y = y + (interactiveY * TILE_SIZE);
	draw_sprite(spr_interactive, 0, _x, _y);
}

draw_self();