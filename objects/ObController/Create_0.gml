Debug = false;
View = true;

save = function(){
	world_save(ObWorld.WorldName);
	particle_create(ObCharacter.x, ObCharacter.y, SpSave, [0, -1]);
}