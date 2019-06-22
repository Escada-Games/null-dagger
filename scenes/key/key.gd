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
		$sprite.position.y=lerp($sprite.position.y,0,0.1)
		$collisionShape2D.position.y=lerp($collisionShape2D.position.y,0,0.1)
		if (self.global_position-follow.global_position).length()>33:
			targetPosition=follow.global_position
		self.global_position.x=lerp(self.global_position.x,targetPosition.x,0.05)
		self.global_position.y=lerp(self.global_position.y,targetPosition.y,0.05)

func _on_key_body_entered(body):
	if body.is_in_group("Player") and self.state!="stateFollow":
		self.state="stateFollow"
		$collisionShape2D.disabled=true
		$sfx.play()
		follow=body
		targetPosition=follow.global_position

func _on_range_body_entered(body):
	if self.state=="stateFollow" and body.is_in_group("Lock"):
		body.open()
		self.queue_free()
