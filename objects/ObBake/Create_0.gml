event_inherited();

item_add = function(_item){
	if (Item && !item_find_flag(is_struct(_item) ? _item : _item.Item, flags.fuel)) { return false; }
	if (!_item) { return false; }
	var _struct;
	
	if (!is_struct(_item)){
		_struct = _item.Item;
	}else{
		_struct = _item;
	}
	
	if (Melt && item_find_flag(is_struct(_item) ? _item : _item.Item, flags.fuel)){
		melt(is_struct(_item) ? _item[$ "Fuel"] : _item.Item[$ "Fuel"]);
		return true;
	}
	
	Item = _struct;
	
	Melt = Item[$ "MeltDef"];
	alarm[3] = 10;
	image_index = 1;
	
	IsMelt = false;
	spring(0.3);
	return true;
}

melt = function(_steps = 1){
	if (!Item) { exit; }
	Melt -= _steps;

	if (!Melt){
		instance_create_depth(x, y + TILE_SIZE, 0, Item[$ "MeltRes"])
	
		Item = noone;
		IsMelt = true;
		image_index = 0;
	}
	
	spring(0.3);
}

IsMelt = false;
Melt = 0;
Item = noone;

SpringAtt = 0;