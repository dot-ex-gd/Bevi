image_alpha = 0;
Skip = 0;
Select = 0;
DoCraft = [];

Update = function(){
	crafts_init();
	DoCraft = [];
	DoCraft = craft_get(work_bench.inventory, ObCharacter.Inventory);
}

Update();
MaxShow = 4;

TextCraft = text_get("text_craft");
TextKG = text_get("text_kg");

BackAlpha = 0;