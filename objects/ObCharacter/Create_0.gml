///@desc
StepPoints = 1;
StepPointsGive = 1;

/// stats
MaxHealth = 100;
Health = 100;

MaxMana = 10;
Mana = 10;

NeedXp = 100;
Xp = 0;

#region methods
get_damage = function(_damage) {
	Health -= _damage;
}
xp_add = function(_xp) {
	Xp += _xp;
	if (Xp >= NeedXp){
		Xp -= NeedXp;
		NeedXp *= 1.25;
	}
}
health_add = function(_hp){
	Health += _hp;
	Health = clamp(Health, 0, MaxHealth);
}
mana_add = function(_mn){
	Mana += _mn;
	Mana = clamp(Mana, 0, MaxMana);
}
#endregion

/// movement
CMoveUp = "w";
CMoveLeft = "a";
CMoveDown = "s";
CMoveRight = "d";

MoveUp = ord(string_upper(CMoveUp));
MoveLeft = ord(string_upper(CMoveLeft));
MoveDown = ord(string_upper(CMoveDown));
MoveRight = ord(string_upper(CMoveRight));

AttackMode = false;

/// inventory
InventoryMaxWeight = 20;
InventoryWeight = 0;
InventoryOpen = false;
Inventory = [];

#region methods
inventory_delete = function(_ind, _c){
	array_delete(Inventory, _ind, _c);
	inventory_weight_upd();
}

inventory_add = function(_item){
	if (is_struct(_item)){
		if (InventoryWeight + _item[$ "Weight"] > InventoryMaxWeight) { return 0; }
		
		array_push(Inventory, _item);
		inventory_weight_upd();
		
		return 1;
	}
	
	return 0;
}

inventory_weight_upd = function(){
	InventoryWeight = 0;
	var i = 0;
	var _len = array_length(Inventory);
	
	for( ; i < _len; i++){
		InventoryWeight += Inventory[i][$ "Weight"];
	}
}

inventory_throw = function(_ind){
	if (_ind <= array_length(Inventory) - 1 && Inventory[_ind]){
		instance_create_depth(x, y, -y, Inventory[_ind].Item);
		
		inventory_delete(_ind, -1);
	}
}

inventory_open = function(){
	if (!CraftOpen){
		InventoryOpen = !InventoryOpen;

		if (InventoryOpen){
			instance_create_depth(INV_WDEL, INV_HDEL, -99999, ObInventory);
		}else{
			instance_destroy(ObInventory);
		}
	}
}
#endregion

/// Equip
InArm = noone;
OnHead = noone;
OnBody = noone;
OnLeggings = noone;
OnFoot = noone;

equip_inarm_add = function(_ind, _struct){
	if (InArm == noone){
		inventory_delete(_ind, -1);
		InArm = _struct;
	}else{
		Inventory[_ind] = InArm;
		InArm = _struct;
	}
}

/// craft
CraftOpen = false;

craft_open = function(){
	if (!InventoryOpen){
		CraftOpen = !CraftOpen;
	
		if (CraftOpen){
			instance_create_depth(INV_WDEL, INV_HDEL, -99999, ObCraft);
		}else{
			instance_destroy(ObCraft);
		}
	}
}

/// interactive
InteractiveType = [];
InteractiveInArm = noone;
Interactive = false;
InteractiveX = 0;
InteractiveY = 0;

enum interactive_type{
	interactive,
	dig,
	replace,
	melt,
}
#region methods
interactive_type_find = function(_need){
	var _len = array_length(InteractiveType);
	
	for(var i = 0; i < _len; i++){
		if (InteractiveType[i] == _need) { return true; }
	}
	
	return false;
}

interactive_inarm = function(_item, _type){
	array_push(InteractiveType, _type);
	InteractiveX = 0;
	InteractiveY = 0;
	
	Interactive = true;
	InteractiveInArm = _item;
}

interactive_abort = function(){
	if (inventory_add(InteractiveInArm)){
		InteractiveInArm = noone;
		Interactive = false;
	}
}

interactive_tinteractive = function(){
	var _x = x + (InteractiveX * TILE_SIZE);
	var _y = y + (InteractiveY * TILE_SIZE);
	var _coll = collision_point(_x, _y, ObInstances, 0, 1);
	
	if (_coll){
		if (item_find_flag(_coll, flags.interactive)){
			_coll.interactive();
		}
		if (item_find_flag(_coll, flags.pickup)){
			_coll.pickup();
		}
	}
}
interactive_tdig = function(){
	var _x = x + (InteractiveX * TILE_SIZE);
	var _y = y + (InteractiveY * TILE_SIZE);
	if (item_find_flag(InArm, flags.pickaxe)){
		var _coll = tilemap_get_at_pixel(ObWorld.Tiles, _x, _y);
		var _create = noone;
		var _time = 1;
		
		switch(_coll){
			case tile.grass:
				_time = 5;
				_create = ObGrassTile;
			break;
			case tile.stone:
				_time = 20;
				_create = ObStoneTile;
				
				if (!irandom(25)) { _create = ObIronOre; }
			break;
			case tile.sand:
				_time = 2;
				_create = ObSandTile;
			break;
		}
		
		if (_create){
			ObStepController.update(_time);
			instance_create_depth(_x, _y, 0, _create);
		}
	}
}
interactive_treplace = function(){
	var _x = x + (InteractiveX * TILE_SIZE);
	var _y = y + (InteractiveY * TILE_SIZE);
	if (InteractiveInArm){
		instance_create_depth(_x, _y, 0, InteractiveInArm[$ "Replaceble"]);
		InteractiveInArm = noone;
	}
}
interactive_tmelt = function(){
	var _x = x + (InteractiveX * TILE_SIZE);
	var _y = y + (InteractiveY * TILE_SIZE);
	var _col = collision_point(_x, _y, ObBake, false, false);
	
	if (_col){
		if (_col.item_add(InteractiveInArm)){
			InteractiveInArm = noone;
		}else{
			interactive_abort();
		}
	}else{
		interactive_abort();
	}
}
#endregion