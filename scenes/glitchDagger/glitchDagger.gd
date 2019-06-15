extends KinematicBody2D
var direction=Vector2(1,0)
var vectorVelocity=Vector2()
var gravity=7.5
var state="stateMoving"
var returnTo
var returnSpeed=0
const targetReturnSpeed=650
var glitchAura=preload("res://scenes/glitchAura/glitchAura.tscn")
func _ready():
	set_physics_process(true)
	vectorVelocity=direction*450
func _physics_process(delta):
	if self.state=="stateMoving":
		direction=vectorVelocity.normalized()
		self.rotation=vectorVelocity.angle()
		vectorVelocity=move_and_slide(vectorVelocity+Vector2(0,gravity),Vector2(0,-1))
	elif self.state=="stateStill":
		if Input.is_action_just_pressed("ui_rmb"):
			self.state="stateReturning"
			vectorVelocity=direction*500
			$collisionShape2D.disabled=true
			$twnReturnSpeed.interpolate_property(self,"returnSpeed",0,targetReturnSpeed,0.4,Tween.TRANS_CIRC,Tween.EASE_OUT)
			$twnReturnSpeed.start()
	elif self.state=="stateReturning":
		self.rotation=vectorVelocity.angle()
		direction=(returnTo.global_position-self.global_position).normalized()
		vectorVelocity.x=lerp(vectorVelocity.x,direction.x*returnSpeed,0.1)
		vectorVelocity.y=lerp(vectorVelocity.y,direction.y*returnSpeed,0.1)
		vectorVelocity=move_and_slide(vectorVelocity,Vector2(0,-1))

func _on_area2D_body_entered(body):
	if body.is_in_group("Solid") and self.state=="stateMoving":
		self.state="stateStill"
		
		var i=glitchAura.instance()
		i.global_position=self.global_position
		get_parent().add_child(i)
	elif body.is_in_group("Player") and self.state=="stateReturning":
		body.daggerCount+=1
		self.queue_free()
func glitch():pass