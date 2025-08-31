///@desc
event_inherited();

drop = function(){
	_drop_base();
	
	if (is_grow()){
		instance_create_depth(x, y, 0, ObHearthFlowerFruit);
		instance_create_depth(x, y, 0, ObHearthFlowerSeed);
	}
}