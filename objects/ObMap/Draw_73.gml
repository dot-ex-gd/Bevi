var _x = camera_get_view_x(view_camera[0]) + 288;
var _y = camera_get_view_y(view_camera[0]) + 32;

draw_sprite(sprite_index, 0, _x, _y);

if (!surface_exists(MapSurface)){
	MapSurface = surface_create(Size, Size);
}

surface_set_target(MapSurface);
draw_clear_alpha(c_black, 0);

var _x1 = (ObCharacter.x - ((Size / 2) * TILE_SIZE)) div TILE_SIZE;
var _y1 = (ObCharacter.y - ((Size / 2) * TILE_SIZE)) div TILE_SIZE;
var _x2 = (ObCharacter.x + ((Size / 2) * TILE_SIZE)) div TILE_SIZE;
var _y2 = (ObCharacter.y + ((Size / 2) * TILE_SIZE)) div TILE_SIZE;

var _col = #000000, i, j, _xn = 0, _yn = 0;
for(i = _x1; i < _x2; i++){
	for(j = _y1; j < _y2; j++){
		switch(tilemap_get(ObWorld.Tiles, i, j)){
			case tile.grass:
				_col = #90B581;
			break;
			case tile.water:
				_col = #ADD7DE;
			break;
			case tile.sand:
				_col = #EFF0BB;
			break;
			case tile.stone:
				_col = #7D7D7D;
			break;
		}
		
		draw_point_color(_xn, _yn, _col);
		
		
		_yn++;
	}
	
	
	_xn++;
	if (_yn > Size) { _yn = 0; }
	if (_xn > Size) { _xn = 0; }
}

surface_reset_target();

draw_surface(MapSurface, _x - Size / 2, _y - Size / 2);