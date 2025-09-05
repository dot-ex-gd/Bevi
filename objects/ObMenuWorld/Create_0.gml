SizeW = room_width div TILE_SIZE + 1;
SizeH = room_height div TILE_SIZE + 1;

Layer = layer_create(-1);
LayerTile = layer_tilemap_create(Layer, 0, 0, TiGround, SizeW, SizeH);

World = ds_grid_create(SizeW, SizeH);

create = function(){
	var _size_y = ds_grid_width(World), _size_x = ds_grid_height(World), i, j;
	
	for(i = 0; i < _size_y; i++){
		for(j = 0; j < _size_x; j++){
			World[# i, j] = random(1);
		}
	}
}

add_noise = function(_range_1, _range_2){
	var _size_y = ds_grid_width(World), _size_x = ds_grid_height(World), i, j;
	
	for(i = 0; i < _size_y; i++){
		for(j = 0; j < _size_x; j++){
			World[# i, j] += random_range(_range_1, _range_2);
			World[# i, j] = clamp(World[# i, j], 0, 1);
		}
	}
}

update = function(){
	var _size_y = ds_grid_width(World), _size_x = ds_grid_height(World), i, j;
	
	for(i = 0; i < _size_y; i++){
		for(j = 0; j < _size_x; j++){
			World[# i, j] = ds_grid_get_mean(World, i - 1, j - 1, i + 1, j + 1);
		}
	}
	
	var _carr, _tile = tile.stone;
	
	for(i = 0; i < _size_y; i++){
		for(j = 0; j < _size_x; j++){
			_carr = World[# i, j]
			
			if (_carr <= 1){
				_tile = tile.stone;
			}
			if (_carr <= 0.53){
				_tile = tile.grass;
			}
			if (_carr <= 0.498){
				_tile = tile.sand;
			}
			if (_carr <= 0.494){
				_tile = tile.water;
			}
			
			tilemap_set(LayerTile, _tile, i, j);
		}
	}
}

finalize = function(){
	var _size_y = SizeW, _size_x = SizeH, i, j;
	var _carr, _tile, _obj;
	var _ht = TILE_SIZE / 2;
	
	for(i = 0; i < _size_y; i++){
		for(j = 0; j < _size_x; j++){
			_obj = -1;
			_carr = World[# i, j];
			_tile = tilemap_get(LayerTile, i, j);
			
			switch(_tile){
				case tile.grass:
					if (_carr > 0.5 && !irandom(10)){
						_obj = ObMenuTree;
					}
				break;
			}
			
			if (_obj){
				instance_create_depth(i * TILE_SIZE + _ht, j * TILE_SIZE + _ht, -50 - j, _obj);
			}
		}
	}
}

Smooth = 0;
SmoothNeed = 35;

create();
alarm[0] = 60;
alarm[1] = 5;