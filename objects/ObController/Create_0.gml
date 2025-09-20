Debug = false;
View = true;

save = function(){
	world_save(ObWorld.WorldName);
	particle_create(ObCharacter.x, ObCharacter.y, SpSave, [0, -1]);
}

ini_open("keybinds.ini");
KeybindMoveLeft = ini_read_string(text_get("keybind_move_left"), "val", "a|left");
KeybindMoveRight = ini_read_string(text_get("keybind_move_right"), "val", "d|right");
KeybindMoveUp = ini_read_string(text_get("keybind_move_up"), "val", "w|up");
KeybindMoveDown = ini_read_string(text_get("keybind_move_down"), "val", "s|down");
KeybindInteract = ini_read_string(text_get("keybind_interact"), "val", "e");
KeybindInventory = ini_read_string(text_get("keybind_inventory"), "val", "i");
KeybindCrafts = ini_read_string(text_get("keybind_crafts"), "val", "^i|tab");
KeybindCraft = ini_read_string(text_get("keybind_craft"), "val", "c");
KeybindSave = ini_read_string(text_get("keybind_save"), "val", "x");
KeybindDiscardFromInventory = ini_read_string(text_get("keybind_discard_from_inventory"), "val", "q");
KeybindEquip = ini_read_string(text_get("keybind_equip"), "val", "^e");
KeybindAttackMode = ini_read_string(text_get("keybind_attack_mode"), "val", "z");
ini_close();

if (instance_number(ObController) > 1){
	instance_destroy();
}