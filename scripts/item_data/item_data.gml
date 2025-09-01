enum flags{
	axe,
	sword,
	pickaxe,
	
	pickup,
	
	weapon,
	armor,
	
	workbench,
	
	placeble,
	
	head,
	body,
	leggins,
	boots,
	
	interactive,
	remeltable,
	food,
	fuel,
}

global.Items = {
	Rock : {
		Name : "item_rock",
		Weight : 0.1,
		Item : ObRock,
		InvSprite : SpRock,
		Flags : [flags.pickup],
		Strength : false,
	},
	Stick : {
		Name : "item_stick",
		Weight : 0.12,
		Item : ObStick,
		InvSprite : SpStick,
		Flags : [flags.pickup, flags.remeltable, flags.fuel],
		Fuel : 1,
		Strength : false,
	},
	Workbench : {
		Name : "item_workbench",
		Weight : 10,
		Item : ObWorkbench,
		InvSprite : SpWorkbench,
		Flags : [flags.pickup, flags.placeble, flags.workbench],
		Strength : false,
	},
	StoneAxe : {
		Name : "item_stone_axe",
		Weight : 1,
		Item : ObStoneAxe,
		InvSprite : SpStoneAxe,
		Flags : [flags.axe, flags.pickup, flags.weapon],
		Strength : true,
		StrengthMax : 15,
		StrengthCur : 15,
		Damage : 4,
	},
	StoneSword : {
		Name : "item_stone_sword",
		Weight : 1,
		Item : ObStoneSword,
		InvSprite : SpStoneSword,
		Flags : [flags.sword, flags.pickup, flags.weapon],
		Strength : true,
		StrengthMax : 30,
		StrengthCur : 30,
		Damage : 5,
	},
	StonePickaxe : {
		Name : "item_stone_pickaxe",
		Weight : 1,
		Item : ObStonePickaxe,
		InvSprite : SpStonePickaxe,
		Flags : [flags.pickaxe, flags.pickup, flags.weapon],
		Strength : true,
		StrengthMax : 15,
		StrengthCur : 15,
		Damage : 3,
	},
	PegWool : {
		Name : "item_peg_wool",
		Weight : 0.01,
		Item : ObPegWool,
		InvSprite : SpPegWool,
		Flags : [flags.pickup, flags.remeltable, flags.fuel],
		Fuel : 4,
		Strength : false,
	},
	Log : {
		Name : "item_log",
		Weight : 1.2,
		Item : ObLog,
		InvSprite : SpLog,
		Flags : [flags.pickup, flags.remeltable, flags.fuel],
		Fuel : 5,
		Strength : false,
	},
	Bed : {
		Name : "item_bed",
		Weight : 4,
		Item : ObBed,
		InvSprite : SpBed,
		Flags : [flags.placeble, flags.interactive],
		Strength : false,
	},
	BedItem : {
		Name : "item_bed",
		Weight : 4,
		Item : ObBedItem,
		InvSprite : SpBedMini,
		Flags : [flags.pickup, flags.placeble],
		Replaceble : ObBed,
		ReplacebleSprite : SpBed,
		Strength : false,
	},
	Bonfire : {
		Name : "item_bonfire",
		Weight : 1,
		Item : ObBonfire,
		InvSprite : SpBonfire,
		Flags : [flags.placeble, flags.remeltable, flags.fuel],
		Fuel : 3,
		Strength : false,
	},
	Bake : {
		Name : "item_bake",
		Weight : 3,
		Item : ObBake,
		InvSprite : SpBake,
		Flags : [flags.pickup, flags.placeble, flags.interactive],
		Strength : false,
	},
	Coal : {
		Name : "item_coal",
		Weight : 0.25,
		Item : ObCoal,
		InvSprite : SpCoal,
		Flags : [flags.pickup, flags.remeltable, flags.fuel],
		Fuel : 10,
		Strength : false,
	},
	IronIngot : {
		Name : "item_iron_ingot",
		Weight : 0.7,
		Item : ObIronIngot,
		InvSprite : SpIronIngot,
		Flags : [flags.pickup],
		Strength : false,
	},
	IronOre : {
		Name : "item_iron_ore",
		Weight : 0.7,
		Item : ObIronOre,
		InvSprite : SpIronOre,
		Flags : [flags.pickup, flags.remeltable],
		MeltDef : 30,
		MeltRes : ObIronIngot,
		Strength : false,
	},
	HearthFlowerSeed : {
		Name : "item_hearth_flower_seed",
		Weight : 0.01,
		Item : ObHearthFlowerSeed,
		InvSprite : SpHearthFlowerSeed,
		Flags : [flags.pickup, flags.placeble, flags.remeltable, flags.fuel],
		Fuel : 1,
		Strength : false,
	},
	ManaFlowerSeed : {
		Name : "item_mana_flower_seed",
		Weight : 0.005,
		Item : ObManaFlowerSeed,
		InvSprite : SpManaFlowerSeed,
		Flags : [flags.pickup, flags.placeble, flags.remeltable, flags.fuel],
		Fuel : 1,
		Strength : false,
	},
	HearthFlowerFruit : {
		Name : "item_hearth_flower",
		Weight : 0.1,
		Item : ObHearthFlowerFruit,
		InvSprite : SpHearthFlowerFruit,
		Flags : [flags.pickup, flags.food, flags.remeltable, flags.fuel],
		Fuel : 1,
		Strength : false,
	},
	ManaFlowerFruit : {
		Name : "item_mana_flower",
		Weight : 0.05,
		Item : ObManaFlowerFruit,
		InvSprite : SpManaFlowerFruit,
		Flags : [flags.pickup, flags.food, flags.remeltable, flags.fuel],
		Fuel : 1,
		Strength : false,
	},
	GrassTile : {
		Name : "item_grass",
		Weight : 0.1,
		Item : ObGrassTile,
		InvSprite : SpGrassTIle,
		Flags : [flags.pickup, flags.remeltable, flags.fuel],
		Fuel : 1,
		Strength : false,
	},
	StoneTile : {
		Name : "item_stone",
		Weight : 0.3,
		Item : ObStoneTile,
		InvSprite : SpStoneTIle,
		Flags : [flags.pickup],
		Strength : false,
	},
	SandTile : {
		Name : "item_sand",
		Weight : 0.05,
		Item : ObSandTile,
		InvSprite : SpSandTIle,
		Flags : [flags.pickup],
		Strength : false,
	},
}

/// @fucn item_find_flag(item, flag)
function item_find_flag(_item, _flag){
	if (!_item){ return false; }
	
	if (!is_struct(_item)){
		if (!variable_instance_exists(_item, "Item")) { return false; }
		
		var _flags = _item.Item[$ "Flags"];
	}else{
		var _flags = _item[$ "Flags"];
	}
	
	var _len = array_length(_flags);
	
	for(var i = 0; i < _len; ++i){
		if (_flags[i] == _flag) return true;
	}
	
	return false;
}