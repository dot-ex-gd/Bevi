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

xp_add = function(_xp) {
	Xp += _xp;
	if (Xp >= NeedXp){
		Xp -= NeedXp;
		NeedXp *= 1.25;
	}
}

/// movement
MoveUp = ord("W");
MoveLeft = ord("A");
MoveDown = ord("S");
MoveRight = ord("D");

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
	if (InventoryWeight + _item[$ "Weight"] > InventoryMaxWeight) { return 0; }
	
	array_push(Inventory, _item);
	inventory_weight_upd();
	
	return 1;
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
InteractiveX = 0;
InteractiveY = 0;
Interactive = false;