/// @desc instances load (fixed)

if (!buffer_exists(ILIBuff)) {
    show_debug_message("No buffer available.");
    InstancesLoad = false;
    exit;
}

ILIX += 200;
ILIX = clamp(ILIX, 0, ILISize);

var _end = min(ILIX, ILISize);
var _start = max(0, _end - 200);

for (var i = _start; i < _end; ++i) {
	var bytes_left = buffer_get_size(ILIBuff) - buffer_tell(ILIBuff);
	if (bytes_left < 8){
		show_debug_message("Buffer underrun: not enough bytes for two u32");
		break;
	}
	
	var _x = buffer_read(ILIBuff, buffer_u32);
	var _y = buffer_read(ILIBuff, buffer_u32);
	
	bytes_left = buffer_get_size(ILIBuff) - buffer_tell(ILIBuff);
	if (bytes_left <= 0){
		show_debug_message("Buffer underrun: no bytes left for string");
		break;
	}
	var _ind = buffer_read(ILIBuff, buffer_string);
	
	var _asset = asset_get_index(_ind);
	if (_asset != -1){
		instance_create_depth(_x, _y, 0, _asset);
	}else{
		show_debug_message("Asset not found: " + string(_ind));
	}
	
	if (i >= ILISize - 1) break;
}

if (_end >= ILISize){
	if (buffer_exists(ILIBuff)){
		buffer_delete(ILIBuff);
	}
	InstancesLoad = false;
}else{
	ILIX = _end;
	if (ILIX % 600 == 0){
		ObChunk.culling();
	}
	alarm[10] = 2;
}
