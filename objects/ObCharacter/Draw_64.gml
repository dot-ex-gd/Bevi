var _text;
if (AttackMode){
	_text = text_get("text_yes");
}else{
	_text = text_get("text_no")
}

draw_text(1, 1 + TEXT_YDEL, AttackModeText + _text);