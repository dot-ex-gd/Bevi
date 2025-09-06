event_inherited();

interactive = function(){
	image_index = !image_index;
	
	if (image_index){
		tilemap_set_at_pixel(ObWorld.TilesCollision, false, x + XDel, y + YDel);
	}else{
		tilemap_set_at_pixel(ObWorld.TilesCollision, true, x + XDel, y + YDel);
	}
}

drop = function(){}