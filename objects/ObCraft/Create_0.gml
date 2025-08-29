image_alpha = 0;
Textes = [];
Skip = 0;
Select = 0;

Update = function(){
	crafts_init();
	var _cg = craft_get(work_bench.inventory, ObCharacter.Inventory);
	DoCraft = _cg;
	Textes = [];
	
	var _in;
	for(var i = 0; i < array_length(global.Crafts); i++){
		_in = global.Crafts[i];
		
		array_push(Textes, string_lower($"{DoCraft[i] ? "" : $"{text_get("text_x")} "}{_in[craft.name]}"));
	}
}

MaxShow = 7;