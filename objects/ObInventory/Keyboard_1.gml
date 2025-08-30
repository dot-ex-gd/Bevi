var _len = array_length(ObCharacter.Inventory);
var _dir = 0;

switch(keyboard_lastchar){
	case "q":
		ObCharacter.inventory_throw(Select);
	break;
	case "s":
		Select += 3;
		_dir = 3;
	break;
	case "w":
		Select -= 3;
		_dir = -3;
	break;
	case "a":
		Select--;
		_dir = -1;
	break;
	case "d":
		Select++;
		_dir = 1;
	break;
	
	case "e":
	case "E":
	break;
}

Select = clamp(Select, 0, _len - 1);

if (Select >= MaxShow){
	if (_dir > 0){
		Skip += _dir;
	}
}
if (Select <= MaxShow){
	if (_dir < 0){
		Skip += _dir;
	}
}

Skip = max(0, Skip);
Skip = clamp(Skip, 0, _len - MaxShow);