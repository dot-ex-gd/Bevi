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

enum food_stats{
	hp,
	mn,
	xp,
}

global.Items = {
	Rock : {
		Name : "item_rock",
		Weight : 0.1,
		Item : ObRock,
		InvSprite : SpRock,
		Flags : [flags.pickup],
	},
	Stick : {
		Name : "item_stick",
		Weight : 0.12,
		Item : ObStick,
		InvSprite : SpStick,
		Flags : [flags.pickup, flags.remeltable, flags.fuel],
		Fuel : 1,
	},
	Workbench : {
		Name : "item_workbench",
		Weight : 10,
		Item : ObWorkbench,
		InvSprite : SpWorkbench,
		Flags : [flags.pickup, flags.placeble, flags.workbench],
	},
	StoneAxe : {
		Name : "item_stone_axe",
		Weight : 1,
		Item : ObStoneAxe,
		InvSprite : SpStoneAxe,
		Flags : [flags.axe, flags.pickup, flags.weapon],
		Damage : 4,
	},
	StoneSword : {
		Name : "item_stone_sword",
		Weight : 1,
		Item : ObStoneSword,
		InvSprite : SpStoneSword,
		Flags : [flags.sword, flags.pickup, flags.weapon],
		Damage : 5,
	},
	StonePickaxe : {
		Name : "item_stone_pickaxe",
		Weight : 1,
		Item : ObStonePickaxe,
		InvSprite : SpStonePickaxe,
		Flags : [flags.pickaxe, flags.pickup, flags.weapon],
		Damage : 3,
	},
	PegWool : {
		Name : "item_peg_wool",
		Weight : 0.01,
		Item : ObPegWool,
		InvSprite : SpPegWool,
		Flags : [flags.pickup, flags.remeltable, flags.fuel],
		Fuel : 4,
	},
	Log : {
		Name : "item_log",
		Weight : 1.2,
		Item : ObLog,
		InvSprite : SpLog,
		Flags : [flags.pickup, flags.remeltable, flags.fuel],
		Fuel : 5,
	},
	DesertLog : {
		Name : "item_desert_log",
		Weight : 1.2,
		Item : ObLog,
		InvSprite : SpLog,
		Flags : [flags.pickup, flags.remeltable, flags.fuel],
		Fuel : 5,
	},
	Bed : {
		Name : "item_bed",
		Weight : 4,
		Item : ObBed,
		InvSprite : SpBed,
		Flags : [flags.placeble, flags.interactive],
	},
	BedItem : {
		Name : "item_bed",
		Weight : 4,
		Item : ObBedItem,
		InvSprite : SpBedMini,
		Flags : [flags.pickup, flags.placeble],
		Replaceble : ObBed,
		ReplacebleSprite : SpBed,
	},
	Bonfire : {
		Name : "item_bonfire",
		Weight : 1,
		Item : ObBonfire,
		InvSprite : SpBonfire,
		Flags : [flags.interactive],
	},
	BonfireItem : {
		Name : "item_bonfire",
		Weight : 1,
		Item : ObBonfire,
		InvSprite : SpBonfire,
		Flags : [flags.pickup, flags.placeble, flags.remeltable, flags.fuel],
		Replaceble : ObBonfire,
		ReplacebleSprite : SpBonfire,
		Fuel : 3,
	},
	Bake : {
		Name : "item_bake",
		Weight : 3,
		Item : ObBake,
		InvSprite : SpBake,
		Flags : [flags.pickup, flags.placeble, flags.interactive],
		Replaceble : ObBake,
		ReplacebleSprite : SpBake,
	},
	Coal : {
		Name : "item_coal",
		Weight : 0.25,
		Item : ObCoal,
		InvSprite : SpCoal,
		Flags : [flags.pickup, flags.remeltable, flags.fuel],
		Fuel : 10,
	},
	IronIngot : {
		Name : "item_iron_ingot",
		Weight : 0.7,
		Item : ObIronIngot,
		InvSprite : SpIronIngot,
		Flags : [flags.pickup],
	},
	IronOre : {
		Name : "item_iron_ore",
		Weight : 0.7,
		Item : ObIronOre,
		InvSprite : SpIronOre,
		Flags : [flags.pickup, flags.remeltable],
		MeltDef : 30,
		MeltRes : ObIronIngot,
	},
	GoldIngot : {
		Name : "item_gold_ingot",
		Weight : 1.2,
		Item : ObGoldIngot,
		InvSprite : SpGoldIngot,
		Flags : [flags.pickup],
	},
	GoldOre : {
		Name : "item_gold_ore",
		Weight : 3,
		Item : ObGoldOre,
		InvSprite : SpGoldOre,
		Flags : [flags.pickup, flags.remeltable],
		MeltDef : 60,
		MeltRes : ObGoldIngot,
	},
	HearthFlowerSeed : {
		Name : "item_hearth_flower_seed",
		Weight : 0.01,
		Item : ObHearthFlowerSeed,
		InvSprite : SpHearthFlowerSeed,
		Flags : [flags.pickup, flags.placeble, flags.remeltable, flags.fuel],
		Replaceble : ObHearthFlower,
		ReplacebleSprite : SpHearthFlower,
		Fuel : 1,
	},
	ManaFlowerSeed : {
		Name : "item_mana_flower_seed",
		Weight : 0.005,
		Item : ObManaFlowerSeed,
		InvSprite : SpManaFlowerSeed,
		Flags : [flags.pickup, flags.placeble, flags.remeltable, flags.fuel],
		Replaceble : ObManaFlower,
		ReplacebleSprite : SpManaFlower,
		Fuel : 1,
	},
	HearthFlowerFruit : {
		Name : "item_hearth_flower",
		Weight : 0.1,
		Item : ObHearthFlowerFruit,
		InvSprite : SpHearthFlowerFruit,
		Flags : [flags.pickup, flags.food, flags.remeltable, flags.fuel],
		Food : [food_stats.hp, 10],
		Fuel : 1,
	},
	ManaFlowerFruit : {
		Name : "item_mana_flower",
		Weight : 0.05,
		Item : ObManaFlowerFruit,
		InvSprite : SpManaFlowerFruit,
		Flags : [flags.pickup, flags.food, flags.remeltable, flags.fuel],
		Food : [food_stats.mn, 10],
		Fuel : 1,
	},
	EvilEye : {
		Name : "item_evil_eye",
		Weight : 0.05,
		Item : ObEvilEyeItem,
		InvSprite : SpEvilEyeItem,
		Flags : [flags.pickup, flags.food],
		Food : [food_stats.mn, 5, food_stats.hp, 5],
		Fuel : 1,
	},
	GrassTile : {
		Name : "item_grass",
		Weight : 0.1,
		Item : ObGrassTile,
		InvSprite : SpGrassTIle,
		Flags : [flags.pickup, flags.remeltable, flags.fuel],
		Fuel : 1,
	},
	StoneTile : {
		Name : "item_stone",
		Weight : 0.3,
		Item : ObStoneTile,
		InvSprite : SpStoneTIle,
		Flags : [flags.pickup],
	},
	SandTile : {
		Name : "item_sand",
		Weight : 0.05,
		Item : ObSandTile,
		InvSprite : SpSandTIle,
		Flags : [flags.pickup],
	},
	IronHelmet : {
		Name : "item_iron_helmet",
		Weight : 1,
		Item : ObIronHelmet,
		InvSprite : SpIronHelmet,
		Flags : [flags.pickup, flags.armor, flags.head],
		Protection : 1,
	},
	IronChestplate : {
		Name : "item_iron_chestplate",
		Weight : 2,
		Item : ObIronChestplate,
		InvSprite : SpIronChestplate,
		Flags : [flags.pickup, flags.armor, flags.body],
		Protection : 2,
	},
	IronLeggins : {
		Name : "item_iron_leggins",
		Weight : 1,
		Item : ObIronLeggins,
		InvSprite : SpIronLeggins,
		Flags : [flags.pickup, flags.armor, flags.leggins],
		Protection : 1,
	},
	IronBoots : {
		Name : "item_iron_boots",
		Weight : 0.5,
		Item : ObIronBoots,
		InvSprite : SpIronBoots,
		Flags : [flags.pickup, flags.armor, flags.boots],
		Protection : 1,
	},
	GoldHelmet : {
		Name : "item_gold_helmet",
		Weight : 2,
		Item : ObGoldHelmet,
		InvSprite : SpGoldHelmet,
		Flags : [flags.pickup, flags.armor, flags.head],
		Protection : 1,
	},
	GoldChestplate : {
		Name : "item_gold_chestplate",
		Weight : 3,
		Item : ObGoldChestplate,
		InvSprite : SpGoldChestplate,
		Flags : [flags.pickup, flags.armor, flags.body],
		Protection : 3,
	},
	GoldLeggins : {
		Name : "item_gold_leggins",
		Weight : 2,
		Item : ObGoldLeggins,
		InvSprite : SpGoldLeggins,
		Flags : [flags.pickup, flags.armor, flags.leggins],
		Protection : 2,
	},
	GoldBoots : {
		Name : "item_gold_boots",
		Weight : 1.5,
		Item : ObGoldBoots,
		InvSprite : SpGoldBoots,
		Flags : [flags.pickup, flags.armor, flags.boots],
		Protection : 1,
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
	
	for(var i = 0; i < _len; i++){
		if (_flags[i] == _flag) return true;
	}
	
	return false;
}