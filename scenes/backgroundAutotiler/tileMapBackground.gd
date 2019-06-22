#tool
extends TileMap
#Reusing Diver Down's autotiling code here, with some...adaptations
var grid_size=Vector2(1000,1000)#global.resolution/global.tileSize#Vector2(25,16)
var North = 1; var West = 2; var East = 4; var South = 8

var tilemapTexture=self.tile_set.tile_get_texture(0)
var spikeSolid=preload("res://scenes/spike-solid/spike-solid.tscn")


func _ready():
	self.z_index=-10
	print('Tilemap: Beginning autotile...')
	for x in range(-1,grid_size.x):
		for y in range(-1,grid_size.y):
			if get_cell(x,y)!=INVALID_CELL:
				var north_tile = 1 if get_cell(x,y-1) != INVALID_CELL else 0
				var west_tile = 1 if get_cell(x-1,y) != INVALID_CELL else 0
				var east_tile = 1 if get_cell(x+1,y) != INVALID_CELL else 0
				var south_tile = 1 if get_cell(x,y+1) != INVALID_CELL else 0
				var tile_index = 0 + North * north_tile + West * west_tile + East * east_tile + South * south_tile
				set_cell(x,y,tile_index)
#				if tile_index!=15:
#					set_cell(x,y,tile_index,false,false,true)
#					var i=spikeSolid.instance()
#					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
#					i.mode=1
#					i.spriteProperties[0]=tilemapTexture
#					i.spriteProperties[1]=Vector2(1,1)
#					i.spriteProperties[2]=4
#					i.spriteProperties[3]=4
#					i.spriteProperties[4]=tile_index
##						if tile_index!=15:
##							i.spriteProperties[4]=tile_index
##						else:
##							if randf()>0.98:
##								i.spriteProperties[4]=tile_index+3
##							else:
##							 i.spriteProperties[4]=tile_index+(randi()%3)
#					get_parent().add_child(i)
#					get_parent().call_deferred("add_child",i)
#				else:
#					var offset=0
#					if randf()>0.98:
#						offset=3
#					else:
#						offset=(randi()%3)
#					self.set_cell(x,y,tile_index+offset)
#	for x in range(-1,grid_size.x):
#		for y in range(-1,grid_size.y):
#			if get_cell(x,y)!=INVALID_CELL:
#				if is_cell_transposed(x,y):set_cell(x,y,-1)
					
	print('Tilemap for Spikes: Autotiling done!')
	print('Tilemap for Spikes: Deleting myself so that only the individual tiles can remain.')
#		self.queue_free()
func glitch():pass
#extends TileMap
##Reusing Diver Down's autotiling code here
#var grid_size=Vector2(250,160)#global.resolution/global.tileSize#Vector2(25,16)
#var North = 1; var West = 2; var East = 4; var South = 8
#
#var tilemapTexture=self.tile_set.tile_get_texture(0)
#var genericTile=preload("res://scenes/genericBlock/genericBlock.tscn")
#
#func _ready():
#	set_process(true)
#	print('Tilemap: Beginning autotile...')
#	for x in range(-1,grid_size.x):
#		for y in range(-1,grid_size.y):
#			if get_cell(x,y)!=INVALID_CELL:
#				var north_tile = 1 if get_cell(x,y-1) != INVALID_CELL else 0
#				var west_tile = 1 if get_cell(x-1,y) != INVALID_CELL else 0
#				var east_tile = 1 if get_cell(x+1,y) != INVALID_CELL else 0
#				var south_tile = 1 if get_cell(x,y+1) != INVALID_CELL else 0
#				var tile_index = 0 + North * north_tile + West * west_tile + East * east_tile + South * south_tile
##				if tile_index==15:
##					if(randf()<0.1): tile_index+=randi()%12
##				set_cell(x, y, tile_index)
#
#				var i=genericTile.instance()
#				i.global_position=self.map_to_world(Vector2(x,y))
#				i.get_node('sprite').texture=tilemapTexture
#				i.get_node('sprite').scale=Vector2(1,1)
#				i.get_node('sprite').vframes=4
#				i.get_node('sprite').hframes=4
#				i.get_node('sprite').frame=tile_index
#				get_parent().call_deferred("add_child",i)
#
#	print('Tilemap: Autotiling done!')
#	print('Tilemap: Deleting myself so that only the individual tiles can remain.')
#	self.queue_free()
#
#func _process(delta):print(typeof(self))