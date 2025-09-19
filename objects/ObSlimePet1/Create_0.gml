event_inherited();

drop = function(){}

Step = function(){
	var _dir = [sign(ObCharacter.x - x) * TILE_SIZE, sign(ObCharacter.y - y) * TILE_SIZE];
	
	if (distance_to_point(ObCharacter.x, ObCharacter.y) < 10 * TILE_SIZE){
		if (!tilemap_get_at_pixel(ObWorld.TilesCollision, x + _dir[0], y + _dir[1]) && !collision_point(x + _dir[0], y + _dir[1], [ObCharacter, ObEntity], false, false)){
			x += _dir[0];
			y += _dir[1];
		
			DEPTH;
		}
		
		spring(0.25);
	}
	
	StepPoints--;
}