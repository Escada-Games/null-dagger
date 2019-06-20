extends KinematicBody2D
var direction=Vector2(1,0)
var vectorVelocity=Vector2()
var gravity=3.5
var state="stateMoving"
var returnTo
var returnSpeed=0
const daggerSpeed=650
const daggerStartingReturnSpeed=400 #I know this is a mess sorry
const targetReturnSpeed=1250
var unglitchPosition=Vector2()
var bodiesToUnglitch=[]
var sfxGlitch=preload("res://scenes/sfxGlitch/glitchSFX.tscn")
var sfxUnglitch=preload("res://scenes/sfxUnglitch/unglitchSFX.tscn")
var spriteTrail=preload("res://scenes/spriteTrail/spriteTrail.tscn")
var t=0
func _ready():
	self.add_to_group("glitchDagger")
	self.add_to_group("Unglitchable")
	set_physics_process(true)
	vectorVelocity=direction*daggerSpeed
func _physics_process(delta):
	if self.state=="stateMoving":
		direction=vectorVelocity.normalized()
		self.rotation=vectorVelocity.angle()
		vectorVelocity=move_and_slide(vectorVelocity+Vector2(0,gravity),Vector2(0,-1))
	elif self.state=="stateStill":
		t+=delta
		$shaderSprite.material.set_shader_param("aberrationAmountX",0.005+0.025*abs(sin(2*PI*rand_range(0.125,0.99)*t)*sin(2*PI*rand_range(33.33,66.66)*t)))
		$shaderSprite.material.set_shader_param("aberrationAmountY",0.001+0.020*abs(sin(2*PI*rand_range(0.125,0.99)*t)*sin(2*PI*rand_range(10.00,25.00)*t)))
		if Input.is_action_just_pressed("ui_rmb"):
			unglitchAura()
			self.state="stateReturning"
			vectorVelocity=direction*daggerStartingReturnSpeed
			vectorVelocity=vectorVelocity.rotated(rand_range(PI/8,+PI/4)*abs(rand_range(-1,1)))
			$collisionShape2D.disabled=true
			$twnReturnSpeed.interpolate_property(self,"returnSpeed",0,targetReturnSpeed,0.4,Tween.TRANS_CIRC,Tween.EASE_OUT)
			$twnReturnSpeed.start()
	elif self.state=="stateReturning":
		$shaderSprite.material.set_shader_param("aberrationAmountX",0.95*$shaderSprite.material.get_shader_param("aberrationAmountX"))
		$shaderSprite.material.set_shader_param("aberrationAmountY",0.95*$shaderSprite.material.get_shader_param("aberrationAmountY"))
		
		self.rotation=vectorVelocity.angle()
		direction=(returnTo.global_position-self.global_position).normalized()
		vectorVelocity.x=lerp(vectorVelocity.x,direction.x*returnSpeed,0.25)
		vectorVelocity.y=lerp(vectorVelocity.y,direction.y*returnSpeed,0.2)
		vectorVelocity=move_and_slide(vectorVelocity,Vector2(0,-1))

func _on_area2D_body_entered(body):
	if body.is_in_group("Solid") and self.state=="stateMoving":
		self.state="stateStill"
		call_deferred("glitchAura")
		
	if body.is_in_group("Player") and self.state=="stateReturning":
#		body.daggerCount+=1
		body.getDagger()
		self.queue_free()

func glitch():pass

func glitchAura():
	get_parent().add_child(sfxGlitch.instance())
	for body in $glitchAura.get_overlapping_bodies():
#		if not body.is_in_group("Unglitchable"):
		bodiesToUnglitch.append(body)
		body.glitch()
func unglitchAura():
	get_parent().add_child(sfxUnglitch.instance())
	for body in bodiesToUnglitch:
		body.glitch()
	bodiesToUnglitch=[]

func _on_tmrSpriteTrail_timeout():
	if self.state in ["stateMoving","stateReturning"]:
		var i=spriteTrail.instance()
		i.texture=$sprite.texture
		i.vframes=$sprite.vframes
		i.hframes=$sprite.hframes
		i.frame=$sprite.frame
		i.scale=$sprite.scale
		i.global_position=$sprite.global_position+Vector2(rand_range(-2.5,2.5),rand_range(-2.5,2.5))
		i.global_rotation=$sprite.global_rotation*rand_range(0.95,1.05)
		get_parent().add_child(i)
