image_alpha = lerp(image_alpha, 0, Alpha);

if (image_alpha <= 0.05){
	instance_destroy();
}

x += Dir[0];
y += Dir[1];

DEPTH;