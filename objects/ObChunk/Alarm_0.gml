if (!Need){
	if (distance_to_point(ObCharacter.x, ObCharacter.y) <= CHUNK_SIZE / 2) { exit; }
}
Need = false;

x = ObCharacter.x;
y = ObCharacter.y;

var _pad = 5;
var _bbox_left, _bbox_top, _bbox_right, _bbox_bottom, _cull, _size = CHUNK_SIZE, _clist = CullList;
with(ObCulling){
	_bbox_left = x - sprite_width / 2;
	_bbox_top = y - sprite_height / 2;
	_bbox_right = x + sprite_width / 2;
	_bbox_bottom = y + sprite_height / 2;
	
	_cull = point_distance(x, y, other.x, other.y) >= _size;
	
	if (_cull){
		instance_deactivate_object(id);
		ds_list_add(_clist, [id, x, y]);
	}
}

var i = 0, _inst, _cull, _dsize = ds_list_size(CullList);

repeat(ds_list_size(CullList)){
	_inst = CullList[| i];
	
	_cull = !(point_distance(_inst[1], _inst[2], x, y) <= _size);
	
	if (!_cull){
		instance_activate_object(_inst[0]);
		ds_list_delete(CullList, i--);
	}
	
	++i;
}