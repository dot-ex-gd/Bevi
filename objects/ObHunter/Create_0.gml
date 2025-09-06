event_inherited();

drop = function(){
	_drop_base();
	//instance_create_depth(x, y, depth, ObEvilEyeItem);
}


Item = noone;
ItemSprite = noone;
Step = function(){
	if (!Item){
		var _near_item = instance_nearest(x, y, ObItem);
		
		if (_near_item){
			var _dir = [sign(_near_item.x - x)  * TILE_SIZE, sign(_near_item.y - y)  * TILE_SIZE];
			
			if (point_distance(_near_item.x, _near_item.y, x, y) < TILE_SIZE){
				Item = _near_item.Item;
				ItemSprite = _near_item.Item[$ "InvSprite"];
				instance_destroy(_near_item);
			}
		}
	}else{
		var _dir = [-sign(ObCharacter.x - x) * TILE_SIZE, -sign(ObCharacter.y - y) * TILE_SIZE];
	}
	
	if (!collision_point(x + _dir[0], y + _dir[1], [ObCollision, ObEntity], false, false)){
		x += _dir[0];
		y += _dir[1];
		
		DEPTH;
		
		if (Item && distance_to_object(ObCharacter) > 20 * TILE_SIZE){
			drop = function(){}
			instance_destroy();
		}
	}
	
	StepPoints--;
}