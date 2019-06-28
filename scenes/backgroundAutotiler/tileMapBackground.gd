extends TileMap
var grid_size=Vector2(175,175)#global.resolution/global.tileSize#Vector2(25,16)
const North = 1; const West = 2; const East = 4; const South = 8
func _ready():
	self.z_index=-10
	print('Tilemap BG: Beginning autotile...')
	for x in range(-1,grid_size.x):
		for y in range(-1,grid_size.y):
			if get_cell(x,y)!=INVALID_CELL:
				var north_tile = 1 if get_cell(x,y-1) != INVALID_CELL else 0
				var west_tile = 1 if get_cell(x-1,y) != INVALID_CELL else 0
				var east_tile = 1 if get_cell(x+1,y) != INVALID_CELL else 0
				var south_tile = 1 if get_cell(x,y+1) != INVALID_CELL else 0
				var tile_index = 0 + North * north_tile + West * west_tile + East * east_tile + South * south_tile
				set_cell(x,y,tile_index)
	print('Tilemap BG: Done autotiling.')
func glitch():pass