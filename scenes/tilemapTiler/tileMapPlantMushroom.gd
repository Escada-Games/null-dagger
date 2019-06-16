extends TileMap
#Reusing Diver Down's autotiling code here, with some...adaptations
var grid_size=Vector2(250,160)#global.resolution/global.tileSize#Vector2(25,16)
var North = 1; var West = 2; var East = 4; var South = 8

var tilemapTexture=self.tile_set.tile_get_texture(0)
var plantMushroom=preload("res://scenes/plant-mushroom/plant-mushroom.tscn")
var doublePlatform=preload("res://scenes/double-platform/double-platform.tscn")
var mirror=preload("res://scenes/mirror/mirror.tscn")

func _ready():
	print('Tilemap: Beginning autotile...')
	for x in range(-1,grid_size.x):
		for y in range(-1,grid_size.y):
			if self.get_cell(x,y)!=INVALID_CELL:
				var tileIndex=self.get_cell(x,y)
				if tileIndex in [0,1]:
					var i=plantMushroom.instance()
					i.global_position=self.map_to_world(Vector2(x,y))
					i.mode=0 if self.get_cell(x,y)==1 else 1
					get_parent().call_deferred("add_child",i)
				elif tileIndex in [2,3]:
					var i=doublePlatform.instance()
					i.global_position=self.map_to_world(Vector2(x,y))
					i.mode=0 if self.get_cell(x,y)==3 else 1
					get_parent().call_deferred("add_child",i)
				elif tileIndex in [4]:
					var i=mirror.instance()
					i.global_position=self.map_to_world(Vector2(x,y))
					get_parent().call_deferred("add_child",i)
				
			
	self.queue_free()