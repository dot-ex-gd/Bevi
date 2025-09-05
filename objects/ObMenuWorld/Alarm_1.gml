if (Smooth < SmoothNeed){
	alarm[1] = 5;
	
	update();
	Smooth++;
	
	if (Smooth % 5 == 0 && (SmoothNeed - Smooth > 20)){
		add_noise(-0.08, 0.08);
	}
}else{
	finalize();
}