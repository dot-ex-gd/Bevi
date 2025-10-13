if (!Generation){
    draw_set_font(global.FontDark);
    
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
    
    var _cam = view_camera[0];
    var _cam_x = camera_get_view_x(_cam);
    var _cam_y = camera_get_view_y(_cam);
    var _cam_w = camera_get_view_width(_cam);
    var _cam_h = camera_get_view_height(_cam);
    
    var _dev_x = _cam_x + _cam_w / 2;
    var _dev_y = _cam_y + _cam_h / 2;
    draw_sprite_ext(SpDev, 0, _dev_x, _dev_y + 32, 1, 1, sin(current_time / 200) * 3, c_white, 1);
    
    draw_set_font(global.FontLight);
    
    draw_text(_dev_x, _dev_y + 38, AdviceText + ":");
    draw_text(_dev_x, _dev_y + 48, Advice);
    
	draw_set_halign(fa_left);
}