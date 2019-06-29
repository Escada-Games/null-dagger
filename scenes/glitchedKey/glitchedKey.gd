extends Area2D
var state="stateIdle"
var follow
var targetPosition=Vector2()
func _ready():
	set_physics_process(true)
func _physics_process(delta):
	if state=="stateIdle":
		pass
	elif state=="stateFollow":
		if (self.global_position-follow.global_position).length()>33:
			targetPosition=follow.global_position
		self.global_position.x=lerp(self.global_position.x,targetPosition.x,0.05)
		self.global_position.y=lerp(self.global_position.y,targetPosition.y,0.05)

func _on_key_body_entered(body):
	if body.is_in_group("glitchDagger"):
		$collisionShape2D.disabled=true
		$sfx.play()
		self.state="stateFollow"
		follow=body.returnTo

func _on_range_body_entered(body):
	if self.state=="stateFollow" and body.is_in_group("Lock"):
		if body.isLocked:
			body.open()
			$sfx.play()
			$animationPlayer.play("unlock")