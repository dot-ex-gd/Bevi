if (!Generation){
	draw_set_color(#d9b998);
	draw_rectangle(0, 0, 640, 320, false);
	draw_set_color(c_white);

	var _text = "";
	switch(GenerationStageCurrent){
		case 0:
			_text = $"{GenerationStage[GenerationStageCurrent]}: {HeightMapIteration}/{HeightMapNeed}";
		break;
		case 1:
			_text = $"{GenerationStage[GenerationStageCurrent]}: {TemperatureMapIteration}/{TemperatureMapNeed}";
		break;
		case 4:
			_text = $"{GenerationStage[GenerationStageCurrent]}: {InstancesX}/{TileW - 1}";
		break;
		default:
			_text = GenerationStage[GenerationStageCurrent];
		break;
	}

	draw_set_halign(fa_center);
	draw_text(160, 90, _text);
	draw_set_halign(fa_left);
}