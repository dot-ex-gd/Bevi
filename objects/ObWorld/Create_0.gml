var _tile_w = room_width div TILE_SIZE + 1;
var _tile_h = room_height div TILE_SIZE + 1;

/// tiles create
TileLayer = layer_create(100);
TileLayerCollision = layer_create(100);

Tiles = layer_tilemap_create(TileLayer, 0, 0, TiGround, _tile_w, _tile_h);
TilesCollision = layer_tilemap_create(TileLayerCollision, 0, 0, TiCollision, _tile_w, _tile_h);

tilemap_clear(Tiles, tile.grass);
layer_set_visible(TileLayerCollision, false);

/// world gen.
var _arr = ds_grid_create(_tile_w, _tile_h);
var _tem = ds_grid_create(_tile_w, _tile_h);
for(var i = 0; i < _tile_w; i++){
	for(var j = 0; j < _tile_h; j++){
		_arr[# i, j] = random(1);
		_tem[# i, j] = 0;
	}
}

var _xx = 0, _yy = 0;
repeat(10){
	_xx = irandom_range(200, _tile_w - 200);
	_yy = irandom_range(200, _tile_h - 200);
	
	ds_grid_add_disk(_tem, _xx, _yy, irandom_range(30, 50), 2);
	repeat(irandom_range(20, 100)){
		ds_grid_add_disk(_tem, _xx + irandom_range(-70, 70), _yy + irandom_range(-70, 70), irandom_range(5, 11), 1);
	}
}

var _itt = 0;
var _arr_att = 64;
var _tem_att = 6;
repeat(_arr_att){
	for(var i = 1; i < _tile_w - 1; i++){
		for(var j = 1; j < _tile_h - 1; j++){
			_arr[# i, j] = ds_grid_get_mean(_arr, i - 1, j - 1, i + 1, j + 1);
		}
	}
	
	show_debug_message($"arr itt: {++_itt}");
}

_itt = 0;
repeat(_tem_att){
	for(var i = 1; i < _tile_w - 1; i++){
		for(var j = 1; j < _tile_h - 1; j++){
			_tem[# i, j] = ds_grid_get_mean(_tem, i - 1, j - 1, i + 1, j + 1);
		}
	}
	
	show_debug_message($"tem itt: {++_itt}");
}

var _tile = 0, _str = "", _txx = 0, _tyy = 0;
for(var i = 1; i < _tile_w - 1; i++){
	for(var j = 1; j < _tile_h - 1; j++){
		if (_arr[# i, j] <= 1){
			if (_tem[# i, j] <= 0.46){
				_tile = tile.stone;
			}
		}
		if (_arr[# i, j] <= 0.53){
			_tile = tile.grass;
			
			if (_tem[# i, j] > 0.46){
				_tile = tile.sand;
			}
		}
		if (_arr[# i, j] <= 0.498){
			_tile = tile.sand;
			
			if (_tem[# i, j] > 0.43){
				_tile = tile.water;
			}
		}
		if (_arr[# i, j] <= 0.494){
			_tile = tile.water;
		}
		
		tilemap_set(Tiles, _tile, i, j);
		
		switch(_tile){
			case tile.grass:
				var _obj = -1;
				
				switch(irandom(100)){
					case 10:
					case 9:
					case 8:
					case 7:
					case 2:
					case 1:
						_obj = ObTree;
						
						repeat(irandom(5)){
							_txx = irandom_range(-2, 2);
							_tyy = irandom_range(-2, 2);
							
							if (!collision_point(i * TILE_SIZE + TILE_SIZE / 2 + (TILE_SIZE * _txx), j * TILE_SIZE + TILE_SIZE / 2 + (TILE_SIZE * _tyy), ObDeco, false, false)){
								instance_create_depth(i * TILE_SIZE + TILE_SIZE / 2 + (TILE_SIZE * _txx), j * TILE_SIZE + TILE_SIZE / 2 + (TILE_SIZE * _tyy), -j, ObLeafes);
							}
						}
					break;
					case 6:
					case 5:
						_obj = ObPeg;
					break;
					case 11:
						_obj = ObStick;
					break;
					case 12:
						_obj = ObRock;
					break;
					case 13:
					case 14:
					case 15:
						_obj = ObGrass;
					break;
					case 16:
					case 17:
						_obj = ObHearthFlower;
					break;
					case 18:
						_obj = ObManaFlower;
					break;
				}
				
				if (_obj)
					instance_create_depth(i * TILE_SIZE + TILE_SIZE / 2, j * TILE_SIZE + TILE_SIZE / 2, -j, _obj);
			break;
		}
	}
}

ds_grid_destroy(_arr);
ds_grid_destroy(_tem);