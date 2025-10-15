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

Protection = 0;

eat = function(_food){
	var _len = array_length(_food);
	
	for(var i = 0; i < _len; i += 2){
		if (_food[i] == food_stats.hp) { health_add(_food[i + 1]); }
		if (_food[i] == food_stats.mn) { mana_add(_food[i + 1]); }
		if (_food[i] == food_stats.xp) { xp_add(_food[i + 1]); }
	}
}

#region methods
get_damage = function(_damage) {
	Health -= clamp(_damage - Protection, 1, infinity);
	
	if (Health <= 0){
		instance_destroy(ObBar);
		global.PlayerExist = false;
		
		particle_create(x, y, SpDeath, [0, -1], 0.03);
		
		instance_destroy();
		
		instance_create_depth(0, 0, -16_000, ObDeathScreen);
	}
}
xp_add = function(_xp) {
	Xp += _xp;
	if (Xp >= NeedXp){
		Xp -= NeedXp;
		NeedXp *= 1.25;
		
		MaxHealth *= 1.07;
		MaxMana *= 1.05;
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
AttackModeText = text_get("text_is_attack_mode") + ": ";

step = function(){
	if (!effect_active(effect.stun)){
		var _to_x = (keyboard_check(MoveRight) - keyboard_check(MoveLeft)) * TILE_SIZE;
		var _to_y = (keyboard_check(MoveDown) - keyboard_check(MoveUp)) * TILE_SIZE;
	
		var _attack = collision_point(x + _to_x, y + _to_y, [ObEntity, AttackMode ? ObDestroyable : ObEntity], false, false);
	
		if (!tilemap_get_at_pixel(ObWorld.TilesCollision, x + _to_x, y + _to_y) && !_attack){
			x += _to_x;
			y += _to_y;
	
			DEPTH;
		}
	
		if (_attack){
			var _damage = 1;
			if (InArm && item_find_flag(InArm, _attack.PreferFlag)){
				_damage = InArm[$ "Damage"];
			}
		
			_attack.get_damage(_damage);
		}
	}
	
	StepPoints = 0;
	if (StepPoints < 1) { ObStepController.alarm[0] = ObStepController.StepTime; }
}

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
	if (_ind >= 0 && _ind <= array_length(Inventory) - 1 && Inventory[_ind]){
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

equip_get_recover = function(){
	var _rec = [];
	
	if (OnHead){
		if (item_find_flag(OnHead, flags.recover)){
			array_push(_rec, OnHead[$ "Food"]);
		}
	}
	if (OnBody){
		if (item_find_flag(OnBody, flags.recover)){
			array_push(_rec, OnBody[$ "Food"]);
		}
	}
	if (OnLeggings){
		if (item_find_flag(OnLeggings, flags.recover)){
			array_push(_rec, OnLeggings[$ "Food"]);
		}
	}
	if (OnFoot){
		if (item_find_flag(OnFoot, flags.recover)){
			array_push(_rec, OnFoot[$ "Food"]);
		}
	}
	
	return _rec;
}

equip_inarm_add = function(_ind, _struct){
	if (InArm == noone){
		inventory_delete(_ind, -1);
		InArm = _struct;
	}else{
		Inventory[_ind] = InArm;
		InArm = _struct;
	}
}
equip_onhead_add = function(_ind, _struct){
	if (OnHead == noone){
		inventory_delete(_ind, -1);
		OnHead = _struct;
	}else{
		Inventory[_ind] = OnHead;
		OnHead = _struct;
	}
}
equip_onbody_add = function(_ind, _struct){
	if (OnBody == noone){
		inventory_delete(_ind, -1);
		OnBody = _struct;
	}else{
		Inventory[_ind] = OnBody;
		OnBody = _struct;
	}
}
equip_onleggins_add = function(_ind, _struct){
	if (OnLeggings == noone){
		inventory_delete(_ind, -1);
		OnLeggings = _struct;
	}else{
		Inventory[_ind] = OnLeggings;
		OnLeggings = _struct;
	}
}
equip_onfoot_add = function(_ind, _struct){
	if (OnFoot == noone){
		inventory_delete(_ind, -1);
		OnFoot = _struct;
	}else{
		Inventory[_ind] = OnFoot;
		OnFoot = _struct;
	}
}
protection_update = function(){
	Protection = 0;
	
	if (OnHead){
		Protection += OnHead[$ "Protection"];
	}
	if (OnBody){
		Protection += OnBody[$ "Protection"];
	}
	if (OnLeggings){
		Protection += OnLeggings[$ "Protection"];
	}
	if (OnFoot){
		Protection += OnFoot[$ "Protection"];
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
		if (item_find_flag(_coll, flags.interactive) && !interactive_type_find(interactive_type.melt)){
			_coll.interactive();
		}
		if (item_find_flag(_coll, flags.pickup) && !interactive_type_find(interactive_type.melt)){
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
				
				if (!irandom(1)){
					_create = ObStoneTile;
				}else{
					_create = ObRock;
				}
				
				if (!irandom(10)){
					_create = ObIronOre;
					
					if (!irandom(3)){
						_create = ObGoldOre;
					}
				}
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

interactive_can_melt = function(){
	var _x = x + (InteractiveX * TILE_SIZE);
	var _y = y + (InteractiveY * TILE_SIZE);
	var _col = collision_point(_x, _y, ObBake, false, false);
	
	if (_col) { return true; } else { return false; }
}
interactive_treplace = function(){
	if (interactive_can_melt()) { exit; }
	
	var _x = x + (InteractiveX * TILE_SIZE);
	var _y = y + (InteractiveY * TILE_SIZE);
	if (InteractiveInArm){
		instance_create_depth(_x, _y, 0, InteractiveInArm[$ "Replaceble"]);
		InteractiveInArm = noone;
	}
}
interactive_tmelt = function(){
	if (!interactive_can_melt()){
		interactive_abort();
		exit;
	}
	
	var _x = x + (InteractiveX * TILE_SIZE);
	var _y = y + (InteractiveY * TILE_SIZE);
	var _col = collision_point(_x, _y, ObBake, false, false);
	
	if (_col.item_add(InteractiveInArm)){
		InteractiveInArm = noone;
	}else{
		interactive_abort();
	}
}
#endregion

Effects = array_create(20, 0);
effect_add = function(_effect, _count){
	Effects[_effect] += _count;
}
effects_lower = function(){
	var i, _len = array_length(Effects);
	
	for(i = 0; i < _len; i++){
		Effects[i]--;
		Effects[i] = max(Effects[i], 0);
	}
}
effect_active = function(_effect){
	return Effects[_effect];
}


protection_update();
inventory_weight_upd();