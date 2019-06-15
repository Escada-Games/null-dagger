extends StaticBody2D
var cyanGhost=preload("res://scenes/ghosts/cyanGhost.tscn")
var magentaGhost=preload("res://scenes/ghosts/magentaGhost.tscn")
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