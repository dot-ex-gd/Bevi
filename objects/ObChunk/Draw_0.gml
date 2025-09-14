var _x, _y;
for(_x = -1; _x < 2; _x++){
	for(_y = -1; _y < 2; _y++){
		var _chunk_xoffset = (_x + CurX) * CHUNK_SIZE * TILE_SIZE;
		var _chunk_yoffset = (_y + CurY) * CHUNK_SIZE * TILE_SIZE;

		var _chunk_size = CHUNK_SIZE * TILE_SIZE;

		draw_rectangle(_chunk_xoffset, _chunk_yoffset, _chunk_xoffset + _chunk_size, _chunk_yoffset + _chunk_size, true);
	}
}