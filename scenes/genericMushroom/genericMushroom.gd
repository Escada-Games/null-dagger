extends StaticBody2D
var cyanGhost=preload("res://scenes/ghosts/cyanGhost.tscn")
var magentaGhost=preload("res://scenes/ghosts/magentaGhost.tscn")
func _ready():
	self.add_to_group("Solid")
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
	$area2D.monitoring=true
	self.set_collision_layer_bit(0,true)
	self.set_collision_mask_bit(0,true)
	
func deactivate():
	self.visible=false
	$area2D.monitoring=false
	self.set_collision_layer_bit(0,false)
	self.set_collision_mask_bit(0,false)

func _on_area2D_body_entered(body):
	if body.is_in_group("Player"):
		$animationPlayer.play("squish")
#		body.vectorVelocity-=(self.global_position-body.global_position).normalized()*1.5*body.jumpForce
		body.vectorVelocity.y=-1.5*body.jumpForce
