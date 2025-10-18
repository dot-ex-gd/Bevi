depth = -10_000;
image_alpha = 0;

cellSkip = 0;
cellSelect = 0;

cellShowMax = 4;

backAlpha = 0;


canCraft = [];
update = function(){
	canCraft = crafts_get(bench, container);
}
update();


keyUp = ord("W");
keyDown = ord("S");
keyCraft = ord("C");