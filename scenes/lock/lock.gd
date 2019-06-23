extends StaticBody2D
var cyanGhost=preload("res://scenes/ghosts/cyanGhost.tscn")
var magentaGhost=preload("res://scenes/ghosts/magentaGhost.tscn")
var isLocked=true
func _ready():
	self.add_to_group("Solid")
	self.add_to_group("Lock")
func glitch():
	get_parent().glitch()
	
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

func activate():
	self.visible=true
	self.set_collision_layer_bit(0,true)
	self.set_collision_mask_bit(0,true)
	
func deactivate():
	self.visible=false
	self.set_collision_layer_bit(0,false)
	self.set_collision_mask_bit(0,false)

func open():
	self.isLocked=false
	get_parent().unlock()