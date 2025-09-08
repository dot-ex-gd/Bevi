/// @func	particle_create(x, y, spr, dir, alp)
function particle_create(_x, _y, _spr, _dir = [0, 0], _alp = 0.1){
	var _obj = instance_create_depth(_x, _y, 0, ObParticle);
	_obj.Dir = _dir;
	_obj.sprite_index = _spr;
	_obj.Alpha = _alp;
}