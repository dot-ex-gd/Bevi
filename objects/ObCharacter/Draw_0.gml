if (Interactive){
	draw_sprite(SpTileSelect, 0, x + InteractiveX * TILE_SIZE, y + InteractiveY * TILE_SIZE);
}

if (InteractiveInArm && InteractiveType == interactive_type.replace){
	draw_sprite_ext(InteractiveInArm[$ "ReplacebleSprite"], 0, x + InteractiveX * TILE_SIZE, y + InteractiveY * TILE_SIZE, 1, 1, 0, c_white, 0.75);
}

draw_self();