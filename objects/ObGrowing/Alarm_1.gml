///@desc spring
image_xscale = lerp(lerp(image_xscale, 1, 0.4), 1, 0.3);
image_yscale = lerp(lerp(image_yscale, 1, 0.4), 1, 0.3);

SpringAtt++;

if (SpringAtt < 20){
	alarm[1] = 1;
}