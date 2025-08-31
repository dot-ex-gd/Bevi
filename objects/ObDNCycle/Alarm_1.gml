PopupXS = lerp(lerp(PopupXS, PopupTo - 0.25, 0.15), PopupTo, 0.15);
PopupYS = lerp(lerp(PopupYS, PopupTo - 0.25, 0.15), PopupTo, 0.15);

PopupSpringAtt++;

if (PopupSpringAtt > 80){
	PopupTo = .25;
	PopupXS += random_range(-0.05, 0.05);
	PopupYS += random_range(-0.05, 0.05);
}

if (PopupSpringAtt < 100){
	alarm[1] = 1;
}else{
	PopupSpringAtt = 0;
	PopupActive = false;
}