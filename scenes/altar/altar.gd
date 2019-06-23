extends StaticBody2D
var cyanGhost=preload("res://scenes/ghosts/cyanGhost.tscn")
var magentaGhost=preload("res://scenes/ghosts/magentaGhost.tscn")
func _ready():
	self.add_to_group("Solid")
	self.set_physics_process(true)
func _physics_process(delta):
	for body in $area2D.get_overlapping_bodies():
		if body.is_in_group("glitchDaggerItem"):
			$sprite.frame=1# if randf()<0.8 else 0
			return
	$sprite.frame=0
#	set_physics_process(false)
		
func glitch():
#	get_parent().glitch()
	$sprite.frame=1 if $sprite.frame==0 else 0
	
	var i=cyanGhost.instance()
	i.position=self.position
	i.texture=$sprite.texture
	i.scale=$sprite.scale
	i.vframes=$sprite.vframes
	i.hframes=$sprite.hframes
	i.frame=$sprite.frame
	get_parent().add_child(i)
	
	i=magentaGhost.instance()
	i.position=self.position
	i.texture=$sprite.texture
	i.scale=$sprite.scale
	i.vframes=$sprite.vframes
	i.hframes=$sprite.hframes
	i.frame=$sprite.frame
	get_parent().add_child(i)
	
	$twnAlpha.interpolate_property(self,"modulate:a",0.2,1,rand_range(0.5,1.5),Tween.TRANS_CUBIC,Tween.EASE_IN)
	$twnAlpha.start()