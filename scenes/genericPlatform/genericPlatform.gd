extends StaticBody2D
var cyanGhost=preload("res://scenes/ghosts/cyanGhost.tscn")
var magentaGhost=preload("res://scenes/ghosts/magentaGhost.tscn")
var glitchedVersion=load("res://scenes/genericSpike/genericSpike.tscn")
var glitchedVersionSpriteProperties=[Texture.new(),
									0, #Vframes
									0, #Hframes
									0, #Frame
									Vector2()] #Scale
var updateGlitchedVersionSprite=false

func _ready():pass
func glitch():
	print('Glitching')
	var i=cyanGhost.instance()
	i.global_position=self.global_position
	i.texture=$sprite.texture
	i.vframes=$sprite.vframes
	i.hframes=$sprite.hframes
	i.frame=$sprite.frame
	get_parent().add_child(i)
	
	i=magentaGhost.instance()
	i.global_position=self.global_position
	i.texture=$sprite.texture
	i.vframes=$sprite.vframes
	i.hframes=$sprite.hframes
	i.frame=$sprite.frame
	get_parent().add_child(i)
	
	$twnAlpha.interpolate_property(self,"modulate:a",0.2,1,rand_range(0.5,1.5),Tween.TRANS_CUBIC,Tween.EASE_IN)
	$twnAlpha.start()
	
	i=glitchedVersion.instance()
	i.global_position=self.global_position
	if updateGlitchedVersionSprite:
		i.get_node("sprite").texture=self.glitchedVersionSpriteProperties[0]
		i.get_node("sprite").vframes=self.glitchedVersionSpriteProperties[1]
		i.get_node("sprite").hframes=self.glitchedVersionSpriteProperties[2]
		i.get_node("sprite").frame=self.glitchedVersionSpriteProperties[3]
		i.get_node("sprite").scale=self.glitchedVersionSpriteProperties[4]
		i.updateGlitchedVersionSprite=true
	get_parent().add_child(i)
	self.queue_free()