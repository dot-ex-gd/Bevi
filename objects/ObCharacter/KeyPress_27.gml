///@desc exit
if (InventoryOpen){
	inventory_open();
}
if (CraftOpen){
	craft_open();
}
if (InteractiveInArm){
	interactive_abort();
}