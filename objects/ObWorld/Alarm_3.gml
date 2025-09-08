///@desc instances

var _tile = 0, _str = "", _txx = 0, _tyy = 0, _obj, _inst = 0, _carr, _ctem;
var _nx = min(++InstancesX, TileW - 1);
for(InstancesX = _nx - 1; InstancesX < _nx; InstancesX++){
	for(InstancesY = 0; InstancesY < TileH - 1; InstancesY++){
		_carr = HeightMap[# InstancesX, InstancesY];
		_ctem = TemperatureMap[# InstancesX, InstancesY];
		
		_tile = tilemap_get(Tiles, InstancesX, InstancesY);
		
		switch(_tile){
			case tile.grass:
				 _obj = -1;
		
				switch(irandom(100)){
					case 7: case 8: case 9: case 10:
						_obj = ObTree;
					break;
					case 6:
						_obj = ObPeg;
					break;
					case 11:
						_obj = ObStick;
					break;
					case 12:
						_obj = ObRock;
					break;
					case 13: case 14: case 15:
						_obj = ObGrass;
					break;
					case 16: case 17:
						_obj = ObHearthFlower;
					break;
					case 18:
						_obj = ObManaFlower;
					break;
				}
		
				if (_obj){
					instance_create_depth(InstancesX * TILE_SIZE + TILE_SIZE / 2, InstancesY * TILE_SIZE + TILE_SIZE / 2, 0, _obj);
				}
			break;
			case tile.sand:
				_obj = -1;
	
				switch(irandom(100)){
					case 1: case 2:
						if ((TemperatureMap[# InstancesX, InstancesY] > 0.46)){
							_obj = ObSkorpionSpawner;
						}
					break;
					case 8: case 9: case 10:
						if ((TemperatureMap[# InstancesX, InstancesY] > 0.46)){
							_obj = ObDesertTree;
						}
					break;
					case 100:
						_obj = ObDesertSpikes;
					break;
				}
		
				if (_obj){
					instance_create_depth(InstancesX * TILE_SIZE + TILE_SIZE / 2, InstancesY * TILE_SIZE + TILE_SIZE / 2, -InstancesY, _obj);
				}
			break;
		}
	}
}

if (InstancesX < TileW - 1){
	if (!ObChunk.TimeToCull){
		ObChunk.culling();
		ObChunk.TimeToCull = 5;
	}
	ObChunk.TimeToCull--;
	alarm[3] = 1;
}else{
	GenerationStageCurrent++;
	alarm[4] = 10;
}