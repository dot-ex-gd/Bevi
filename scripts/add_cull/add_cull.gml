/// @desc
/// @func
function add_cull(_obj){
	var _bbox_left, _bbox_top, _bbox_right, _bbox_bottom, _cull, _size = CHUNK_SIZE, _clist = ObChunk.CullList;
	var _pad = 5;
	
	with(_obj){
		_bbox_left = x - sprite_width / 2;
		_bbox_top = y - sprite_height / 2;
		_bbox_right = x + sprite_width / 2;
		_bbox_bottom = y + sprite_height / 2;
		
		_cull = point_distance(x, y, ObChunk.x, ObChunk.y) >= _size;
			
		if (_cull){
			instance_deactivate_object(id);
			ds_list_add(_clist, [id, x, y]);
		}
	}
}