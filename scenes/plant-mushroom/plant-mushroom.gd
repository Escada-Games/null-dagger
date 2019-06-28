extends Node2D
export (int) var mode=0
#var spriteProperties=[	Texture.new(),	#Texture
#						Vector2(),		#Scale
#						0,				#Vframes
#						0,				#Hframes
#						0				#Frame
#]

func _ready():
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