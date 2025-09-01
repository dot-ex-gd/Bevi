/// @func spring(intensivity)
function spring(_intensivity){
	SpringAtt = 0;
	image_xscale = 1 + _intensivity * choose(-1, 1);
	image_yscale = 1 + _intensivity * choose(-1, 1);
	
	alarm[1] = 1;
}

/// @func spring_alarm()
function spring_alarm(){
	image_xscale = lerp(lerp(image_xscale, 1, 0.4), 1, 0.3);
	image_yscale = lerp(lerp(image_yscale, 1, 0.4), 1, 0.3);

	SpringAtt++;

	if (SpringAtt < 20){
		alarm[1] = 1;
	}
}