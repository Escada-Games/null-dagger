extends TileMap
#Reusing Diver Down's autotiling code here, with some...adaptations
var grid_size=Vector2(1000,1000)#global.resolution/global.tileSize#Vector2(25,16)
var North = 1; var West = 2; var East = 4; var South = 8

var tilemapTexture=self.tile_set.tile_get_texture(0)
var plantMushroom=preload("res://scenes/plant-mushroom/plant-mushroom.tscn")
var doublePlatform=preload("res://scenes/double-platform/double-platform.tscn")
var mirror=preload("res://scenes/mirror/mirror.tscn")
var checkpointSolid=preload("res://scenes/checkpointSolid/checkpoint-solid.tscn")
var key=preload("res://scenes/key/key.tscn")
var glitchedKey=preload("res://scenes/glitchedKey/glitchedKey.tscn")
var lockSolid=preload("res://scenes/lock-solid/lock-solid.tscn")
var glitchDagger=preload("res://scenes/glitchDaggerItem/glitchDaggerItem.tscn")
var tallGrass=preload("res://scenes/tallGrass/tallGrass.tscn")
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
				elif tileIndex in [5]:
					var i=checkpointSolid.instance()
					i.mode=0
					i.global_position=self.map_to_world(Vector2(x,y))
					get_parent().call_deferred("add_child",i)
				elif tileIndex in [6]:
					var i=key.instance()
					i.global_position=self.map_to_world(Vector2(x,y))
					get_parent().call_deferred("add_child",i)
				elif tileIndex in [7]:
					var i=glitchedKey.instance()
					i.global_position=self.map_to_world(Vector2(x,y))
					get_parent().call_deferred("add_child",i)
				elif tileIndex in [8]:
					var i=lockSolid.instance()
					i.mode=0
					i.global_position=self.map_to_world(Vector2(x,y))
					get_parent().call_deferred("add_child",i)
				elif tileIndex in [9]:
					var i=lockSolid.instance()
					i.mode=1
					i.global_position=self.map_to_world(Vector2(x,y))
					get_parent().call_deferred("add_child",i)
				elif tileIndex in [10]:
					var i=checkpointSolid.instance()
					i.mode=1
					i.global_position=self.map_to_world(Vector2(x,y))
					get_parent().call_deferred("add_child",i)
				elif tileIndex in [13]:
					var i=glitchDagger.instance()
					i.global_position=self.map_to_world(Vector2(x,y))
					get_parent().call_deferred("add_child",i)
				elif tileIndex in [14]:
					var i=tallGrass.instance()
					i.global_position=self.map_to_world(Vector2(x,y))
					get_parent().call_deferred("add_child",i)
			
	self.queue_free()