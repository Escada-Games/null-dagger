extends TileMap
var grid_size=Vector2(175,175)#global.resolution/global.tileSize#Vector2(25,16)
const North = 1;const West = 2;const East = 4;const South = 8

const Solid=0;const Spike=1
const Mushroom=2;const Plant=3
const PlatformWood=4;const PlatformStone=5
const Mirror=6
const CheckpointSolid=7
const Key=8; const GlitchedKey=9
const LockSolid=10; const SolidLock=11;
const SolidCheckpoint=12
const GlitchDaggerItem=13
const Prop=14
const Grass=15

var tilemapTexture=load("res://resources/tilesetAutotileStones4x4.png")
var tilemapGrassTexture=load("res://resources/tilesetAutotileGrass4x4.png")

#var tilemapTexture=self.tile_set.tile_get_texture(0)
var spikeSolid=preload("res://scenes/spike-solid/spike-solid.tscn")

var plantMushroom=preload("res://scenes/plant-mushroom/plant-mushroom.tscn")
var doublePlatform=preload("res://scenes/double-platform/double-platform.tscn")
var mirror=preload("res://scenes/mirror/mirror.tscn")
var checkpointSolid=preload("res://scenes/checkpointSolid/checkpoint-solid.tscn")
var key=preload("res://scenes/key/key.tscn")
var glitchedKey=preload("res://scenes/glitchedKey/glitchedKey.tscn")
var lockSolid=preload("res://scenes/lock-solid/lock-solid.tscn")
var glitchDagger=preload("res://scenes/glitchDaggerItem/glitchDaggerItem.tscn")
var tallGrass=preload("res://scenes/tallGrass/tallGrass.tscn")

#Logic to try:
#	Iterate over all tiles, spawn all the objects, and replace these tiles with void;
#	Place remaining tiles;
#	Remove the tiles that are actually objects.

func _ready():
#	self.z_index=15
	print('Tilemap Main: Spawning objects...')
	for x in range(-1,grid_size.x):
		for y in range(-1,grid_size.y):
			if not get_cell(x,y) in [Solid,Spike,Grass]:
				var tileIndex=self.get_cell(x,y)
				if tileIndex in [Mushroom,Plant]:
					var i=plantMushroom.instance()
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					i.mode=0 if self.get_cell(x,y)==Plant else 1
					get_parent().call_deferred("add_child",i)
					set_cell(x,y,INVALID_CELL)
				elif tileIndex in [PlatformWood,PlatformStone]:
					var i=doublePlatform.instance()
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					i.mode=0 if self.get_cell(x,y)==3 else 1
					get_parent().call_deferred("add_child",i)
					set_cell(x,y,INVALID_CELL)
				elif tileIndex in [Mirror]:
					var i=mirror.instance()
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					get_parent().call_deferred("add_child",i)
					set_cell(x,y,INVALID_CELL)
				elif tileIndex in [CheckpointSolid]:
					var i=checkpointSolid.instance()
					i.mode=0
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					get_parent().call_deferred("add_child",i)
					set_cell(x,y,INVALID_CELL)
				elif tileIndex in [Key]:
					var i=key.instance()
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					get_parent().call_deferred("add_child",i)
					set_cell(x,y,INVALID_CELL)
				elif tileIndex in [GlitchedKey]:
					var i=glitchedKey.instance()
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					get_parent().call_deferred("add_child",i)
					set_cell(x,y,INVALID_CELL)
				elif tileIndex in [LockSolid]:
					var i=lockSolid.instance()
					i.mode=0
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					get_parent().call_deferred("add_child",i)
					set_cell(x,y,INVALID_CELL)
				elif tileIndex in [SolidLock]:
					var i=lockSolid.instance()
					i.mode=1
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					get_parent().call_deferred("add_child",i)
					set_cell(x,y,INVALID_CELL)
				elif tileIndex in [SolidCheckpoint]:
					var i=checkpointSolid.instance()
					i.mode=1
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					get_parent().call_deferred("add_child",i)
					set_cell(x,y,INVALID_CELL)
				elif tileIndex in [GlitchDaggerItem]:
					var i=glitchDagger.instance()
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					get_parent().call_deferred("add_child",i)
					set_cell(x,y,INVALID_CELL)
				elif tileIndex in [Prop]:
					var i=tallGrass.instance()
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					get_parent().call_deferred("add_child",i)
					set_cell(x,y,INVALID_CELL)
	print("Tileset Main: Done spawning objects.")
	print('Tilemap Main: Spawning and autotiling the tileset and spikes...')
	for x in range(-1,grid_size.x):
		for y in range(-1,grid_size.y):
			if get_cell(x,y)!=INVALID_CELL:
				var north_tile = 1 if get_cell(x,y-1) != INVALID_CELL else 0
				var west_tile = 1 if get_cell(x-1,y) != INVALID_CELL else 0
				var east_tile = 1 if get_cell(x+1,y) != INVALID_CELL else 0
				var south_tile = 1 if get_cell(x,y+1) != INVALID_CELL else 0
				var tile_index = 0 + North * north_tile + West * west_tile + East * east_tile + South * south_tile
				
				if tile_index!=15:
					var i=spikeSolid.instance()
					i.global_position=self.map_to_world(Vector2(x,y))+(self.cell_size/2)
					i.mode=1 if get_cell(x,y) in [Solid,Grass] else 0
					if get_cell(x,y)==Grass:
						i.isGrass=true
					i.spriteProperties[0]=tilemapTexture
					i.spriteProperties[1]=Vector2(1,1)
					i.spriteProperties[2]=4
					i.spriteProperties[3]=4
					i.spriteProperties[4]=tile_index
					set_cell(x,y,tile_index,false,false,true)
					get_parent().call_deferred("add_child",i)
				else:
					randomize()
					var offset=0
					if randf()>0.98:
						offset=3
					else: 
						offset=1+(randi()%2) #TODO: Fix this messy fix
					self.set_cell(x,y,tile_index+offset)
	print("Tileset Main: Done spawning the tileset and spikes.")
	print("Tileset Main: Deleting helper tiles...")
	for x in range(-1,grid_size.x):
		for y in range(-1,grid_size.y):
			if get_cell(x,y)!=INVALID_CELL:
				if is_cell_transposed(x,y):
					set_cell(x,y,-1)
	print("Tileset Main: Done.")
	print("Tileset Main: Finished all processes.")
func glitch():pass