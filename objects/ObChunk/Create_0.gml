Need = true;

ObjectList = ds_list_create();
CullList = ds_list_create();

culling = function(){
	var _cull, _size = CHUNK_SIZE, _clist = CullList;
	
	with(ObCulling){
		if (point_distance(x, y, other.x, other.y) >= _size){
			instance_deactivate_object(id);
			ds_list_add(_clist, [id, x, y, object_index]);
		}
	}
}

unculling = function(){
	var i = 0, _inst, _cull, _dsize = ds_list_size(CullList), _size = CHUNK_SIZE;

	repeat(ds_list_size(CullList)){
		_inst = CullList[| i];
	
		if ((point_distance(_inst[1], _inst[2], x, y) <= _size)){
			instance_activate_object(_inst[0]);
			ds_list_delete(CullList, i--);
		}
	
		++i;
	}
}

TimeToCull = 0;

x = CHUNK_SIZE / 2;
y = CHUNK_SIZE / 2;