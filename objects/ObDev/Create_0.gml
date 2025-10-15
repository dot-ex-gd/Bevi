depth = -y div TILE_SIZE - 10;

MonologueIndex = 0;
MonologueText = "";
MonologueTextLet = 0;
MonologueSpeed = 0.7;

next = function(){
	MonologueIndex++;
	MonologueText = text_get($"text_dev_monologue_{MonologueIndex}");
	MonologueTextLet = 0;
	
	if (MonologueText == ""){
		spring(1.75);
		alarm[2] = 5;
	}
}

next();

SpringAtt = 0;