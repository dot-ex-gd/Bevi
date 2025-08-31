event_inherited();

interactive = function(){
	ObTime.time_go(100);
	ObTime.surface_update();
	
	ObStepController.update(100);
}