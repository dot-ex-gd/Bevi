global.Crafts = [];

enum craft{
	wrkb,
	rec,
	item,
	name,
	struct,
	count,
}
enum work_bench{
	inventory,
	workbench,
	any,
	dark_creator
}

///@func craft_add(workbench, reciepe, item, [count])
function craft_add(_workbench, _reciepe, _item, _name, _struct, _count = 1){
	array_push(global.Crafts, [_workbench, _reciepe, _item, _name, _struct, _count]);
}


function crafts_init(){
	global.Crafts = [];
	craft_add(work_bench.inventory, [ObStick, 1, ObRock, 1], ObWorkbenchItem, text_get("item_workbench"), global.Items.WorkbenchItem);
	craft_add(work_bench.inventory, [ObStick, 3, ObRock, 4], ObStoneAxe, text_get("item_stone_axe"), global.Items.StoneAxe);
	craft_add(work_bench.inventory, [ObStick, 2, ObRock, 5], ObStonePickaxe, text_get("item_stone_pickaxe"), global.Items.StonePickaxe);
	craft_add(work_bench.inventory, [ObStick, 3, ObRock, 3], ObStoneSword, text_get("item_stone_sword"), global.Items.StoneSword);
	craft_add(work_bench.workbench, [ObStick, 3, ObLog, 6, ObPegWool, 6], ObBedItem, text_get("item_bed"), global.Items.BedItem);
	
	craft_add(work_bench.workbench, [ObRock, 16, ObLog, 2], ObBake, text_get("item_bake"), global.Items.Bake);
	craft_add(work_bench.inventory, [ObStick, 3, ObLog, 1], ObBonfireItem, text_get("item_bonfire"), global.Items.BonfireItem);
	
	craft_add(work_bench.workbench, [ObLog, 2], ObBlockWoodItem, text_get("item_block_wood"), global.Items.BlockWoodItem);
	craft_add(work_bench.workbench, [ObLog, 2, ObStick, 2], ObBlockWoodDoorItem, text_get("item_block_door"), global.Items.BlockWoodDoorItem);
	
	craft_add(work_bench.inventory, [ObItemSlime, 32], ObSummonerMergedSlime, text_get("item_summoner_merged_slime"), global.Items.SummonerMergedSlime);
	
	craft_add(work_bench.workbench, [ObIronIngot, 10], ObIronHelmet, text_get("item_iron_helmet"), global.Items.IronHelmet);
	craft_add(work_bench.workbench, [ObIronIngot, 16], ObIronChestplate, text_get("item_iron_chestplate"), global.Items.IronChestplate);
	craft_add(work_bench.workbench, [ObIronIngot, 14], ObIronLeggins, text_get("item_iron_leggins"), global.Items.IronLeggins);
	craft_add(work_bench.workbench, [ObIronIngot, 8], ObIronBoots, text_get("item_iron_boots"), global.Items.IronBoots);
	
	craft_add(work_bench.workbench, [ObGoldIngot, 12], ObGoldHelmet, text_get("item_gold_helmet"), global.Items.GoldHelmet);
	craft_add(work_bench.workbench, [ObGoldIngot, 18], ObGoldChestplate, text_get("item_gold_chestplate"), global.Items.GoldChestplate);
	craft_add(work_bench.workbench, [ObGoldIngot, 15], ObGoldLeggins, text_get("item_gold_leggins"), global.Items.GoldLeggins);
	craft_add(work_bench.workbench, [ObGoldIngot, 10], ObGoldBoots, text_get("item_gold_boots"), global.Items.GoldBoots);
	
	craft_add(work_bench.workbench, [ObEssenceOfDay, 1, ObEssenceOfNight, 1, ObEcho, 3], ObDarkCreatorItem, text_get("item_dark_creator"), global.Items.DarkCreatorItem);
	craft_add(work_bench.workbench, [ObGlass, 1], ObTestTube, text_get("item_test_tube"), global.Items.TestTube);
	
	craft_add(work_bench.dark_creator, [ObHearthFlower, 5, ObHearthFlowerSeed, 2, ObEssenceOfDay, 1], ObHealthRecoveryBracelet, text_get("item_health_recovery_bracelet"), global.Items.HealthRecoveryBracelet);
	craft_add(work_bench.dark_creator, [ObManaFlower, 12, ObManaFlowerSeed, 5, ObEssenceOfNight, 1, ObEcho, 1], ObManaRecoveryBracelet, text_get("item_mana_recovery_bracelet"), global.Items.ManaRecoveryBracelet);
	craft_add(work_bench.dark_creator, [ObHealthRecoveryBracelet, 1, ObManaRecoveryBracelet, 1, ObEcho, 4], ObRecoveryBracelet, text_get("item_recovery_bracelet"), global.Items.RecoveryBracelet);
	
	craft_add(work_bench.dark_creator, [ObTestTube, 1, ObEssenceOfNight, 1], ObTestTubeWithEssenceOfNight, text_get("item_test_tube_with_essence_of_night"), global.Items.TestTubeWithEssenceOfNight);
	craft_add(work_bench.dark_creator, [ObTestTube, 1, ObEssenceOfDay, 1], ObTestTubeWithEssenceOfDay, text_get("item_test_tube_with_essence_of_day"), global.Items.TestTubeWithEssenceOfDay);
	craft_add(work_bench.dark_creator, [ObTestTubeWithEssenceOfDay, 1, ObHearthFlower, 1], ObTestTubeWithHealth, text_get("item_test_tube_with_health"), global.Items.TestTubeWithHealth);
	craft_add(work_bench.dark_creator, [ObTestTubeWithEssenceOfNight, 1, ObManaFlower, 1], ObTestTubeWithMana, text_get("item_test_tube_with_mana"), global.Items.TestTubeWithMana);
}

function craft_get(_workbench, _container){
	var _cont_len = array_length(_container);
	
	var _ids = [];
	var _len = array_length(global.Crafts);
	
	var _can_craft = true, _need_count, _need_item, _craft_len, _already, _found, _item, i, j, k;
	
	for(i = 0; i < _len; i++){
		if (global.Crafts[i][craft.wrkb] != _workbench && _workbench != work_bench.any || 
			ObCharacter.InventoryWeight + global.Crafts[i][craft.struct][$ "Weight"] > ObCharacter.InventoryMaxWeight) {
            //array_push(_ids, false); 
            continue;
        }
		
		_item = global.Crafts[i];
		_craft_len = array_length(_item[craft.rec]);
		_can_craft = true;
		
		for(j = 0; j < _craft_len; j += 2){
			_need_item = _item[craft.rec][j];
			_need_count = _item[craft.rec][j + 1];
			
			if (_need_count <= 0) { continue; }
			
			_found = 0;
			
			for(k = 0; k < _cont_len; k++){
				_already = false;
				
				if (_already) { continue; }
				
				if (_container[k].Item == _need_item){
					_found ++;
					
					if (_found >= _need_count) { break; }
				}
			}
			
			if (_found < _need_count){
				_can_craft = false;
				break;
			}
		}
		
		if (_can_craft){
			array_push(_ids, [i, true]);
		}else{
			array_push(_ids, [i, false]);
		}
	}
	
	
	return _ids;
}