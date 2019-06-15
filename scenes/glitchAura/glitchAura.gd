extends Area2D
var sfxGlitch=preload("res://scenes/sfxGlitch/glitchSFX.tscn")
func _ready():
	yield(get_tree().create_timer(0.02),'timeout')
	get_parent().add_child(sfxGlitch.instance())
	for body in self.get_overlapping_bodies():
		print(body)
		body.glitch()
	self.queue_free()
