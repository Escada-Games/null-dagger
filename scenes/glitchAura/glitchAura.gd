extends Area2D
func _ready():
	yield(get_tree().create_timer(0.05),'timeout')
	for body in self.get_overlapping_bodies():
		print(body)
		body.glitch()
	self.queue_free()
