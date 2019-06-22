extends Area2D
var state="stateIdle"
var follow
var targetPosition=Vector2()
var t=0
func _ready():
	set_physics_process(true)
func _physics_process(delta):
	t+=1
	$shaderSprite.material.set_shader_param("aberrationAmountX",0.005+0.025*abs(sin(2*PI*rand_range(0.125,0.99)*t)*sin(2*PI*rand_range(33.33,66.66)*t)))
	$shaderSprite.material.set_shader_param("aberrationAmountY",0.001+0.020*abs(sin(2*PI*rand_range(0.125,0.99)*t)*sin(2*PI*rand_range(10.00,25.00)*t)))
	if state=="stateIdle":
		pass
	elif state=="stateFollow":
		$sprite.position.y=lerp($sprite.position.y,0,0.1)
		$collisionShape2D.position.y=lerp($collisionShape2D.position.y,0,0.1)
		if (self.global_position-follow.global_position).length()>33:
			targetPosition=follow.global_position
		self.global_position.x=lerp(self.global_position.x,targetPosition.x,0.05)
		self.global_position.y=lerp(self.global_position.y,targetPosition.y,0.05)
	elif state=="stateVanishing":
		$shaderSprite.scale.x=lerp($shaderSprite.scale.x,0,delta)
		$shaderSprite.scale.y=lerp($shaderSprite.scale.y,0,delta)
		if $shaderSprite.scale.x<0.05 and $shaderSprite.scale.y<0.05:
			self.queue_free()
			

func _on_key_body_entered(body):
	if body.is_in_group("Player"):
		body.getDagger()
		body.anim="getDagger"
		$sprite.self_modulate.a=0
		$collisionShape2D.disabled=true
		state="stateVanishing"
		global.hasDagger=true
#		self.queue_free()