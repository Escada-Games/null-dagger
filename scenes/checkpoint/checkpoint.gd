extends StaticBody2D
var cyanGhost=preload("res://scenes/ghosts/cyanGhost.tscn")
var magentaGhost=preload("res://scenes/ghosts/magentaGhost.tscn")
var player
var canCheckPlayer=false
func _ready():
	$sprite.modulate=Color("595959")
	for node in get_tree().get_nodes_in_group("Player"):
		self.add_collision_exception_with(node)
	self.add_to_group("Solid")
	set_physics_process(true)

func _physics_process(delta):
	$sprite.position.y=0
	if canCheckPlayer:
		if player.checkpoint!=self:
			$twnSaturation.interpolate_property($sprite,"modulate",$sprite.modulate,Color("595959"),0.4,Tween.TRANS_EXPO,Tween.EASE_OUT)
			$twnSaturation.start()
			$twnScale.interpolate_property($sprite,"scale",$sprite.scale,Vector2(2,2),0.4,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
			$twnScale.start()
			canCheckPlayer=false
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
	
func _on_area2D_body_entered(body):
	if body.is_in_group("Player"):
		if body.checkpoint!=self and $sprite.visible:
			$sfx.play()
			$twnSaturation.interpolate_property($sprite,"modulate",$sprite.modulate,Color("ffffff"),0.4,Tween.TRANS_EXPO,Tween.EASE_OUT)
			$twnSaturation.start()
			$twnScale.interpolate_property($sprite,"scale",$sprite.scale,Vector2(3.25,3.25),0.4,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
			$twnScale.start()
			player=body
			canCheckPlayer=true
			
		body.checkpoint=self