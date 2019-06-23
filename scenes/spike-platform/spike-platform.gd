extends Node2D
export (int) var mode=0
var spriteProperties=[	Texture.new(),	#Texture
						Vector2(1,1),		#Scale
						0,				#Vframes
						0,				#Hframes
						0				#Frame
]

func _ready():
	for node in get_children():
		node.get_node('sprite').scale=self.spriteProperties[1]
		node.get_node('sprite').vframes=self.spriteProperties[2]
		node.get_node('sprite').hframes=self.spriteProperties[3]
		node.get_node('sprite').frame=self.spriteProperties[4]
	if self.mode==0:
		$zero.activate()
		$one.deactivate()
	elif self.mode==1:
		$zero.deactivate()
		$one.activate()

func glitch():
	if self.mode==0:
		$zero.deactivate()
		$one.activate()
		mode=1
	elif self.mode==1:
		$zero.activate()
		$one.deactivate()
		mode=0


##############################
#extends Node2D
#export (int) var mode=0
#var frame=0
#var spriteProperties=[Texture.new(),	#Texture
#						Vector2(1,1),		#Scale
#						4,				#Vframes
#						4,				#Hframes
#						0				#Frame
#]
#
#func _ready():
##	$zero.get_node('sprite').frame=self.spriteProperties[4]
##	$one.get_node('sprite').frame=self.spriteProperties[4]
#
##	for node in get_children():
###		node.get_node('sprite').scale=self.spriteProperties[1]
###		node.get_node('sprite').vframes=self.spriteProperties[2]
###		node.get_node('sprite').hframes=self.spriteProperties[3]
##		node.get_node('sprite').frame=self.spriteProperties[4]
##	$zero.get_node('sprite').scale=self.spriteProperties[1]
##	$zero.get_node('sprite').vframes=self.spriteProperties[2]-1
##	$zero.get_node('sprite').hframes=self.spriteProperties[3]-1
##	$zero.get_node('sprite').frame=self.spriteProperties[4]%15
##	$one.get_node('sprite').scale=self.spriteProperties[1]
##	$one.get_node('sprite').vframes=self.spriteProperties[2]
##	$one.get_node('sprite').hframes=self.spriteProperties[3]
##	$one.get_node('sprite').frame=self.spriteProperties[4]
#
#	if self.mode==0:
#		$zero.activate()
#		$one.deactivate()
#	elif self.mode==1:
#		$zero.deactivate()
#		$one.activate()
#
#func glitch():
#	if self.mode==0:
#		$zero.deactivate()
#		$one.activate()
#		mode=1
#	elif self.mode==1:
#		$zero.activate()
#		$one.deactivate()
#		mode=0