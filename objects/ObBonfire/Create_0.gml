event_inherited();

Intensivity = 1;

drop = function(){
	if (irandom(1)){
		instance_create_depth(x, y, depth, ObCoal);
	}
}
interactive = function(){
	instance_destroy();
}

image_index = 1;