image_alpha = 0;
Textes = [];
Skip = 0;
Select = 0;

Update = function(){
	Textes = [];
	
	var _in;
	for(var i = 0; i < array_length(ObCharacter.Inventory); i++){
		_in = ObCharacter.Inventory[i];
		
		array_push(Textes, string_lower($"{text_get(_in.Name)}: {_in.Weight}{text_get("text_kg")}"));
	}
}

MaxShow = 7;

TextWeight = string_lower(text_get("text_weight"));
TextKG = string_lower(text_get("text_kg"));