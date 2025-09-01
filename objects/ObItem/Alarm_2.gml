/// @desc create
image_xscale = lerp(image_xscale, 1, 0.4);
image_yscale = lerp(image_yscale, 1, 0.4);

if (image_xscale != 1 && image_yscale != 1){
	alarm[2] = 1;
}