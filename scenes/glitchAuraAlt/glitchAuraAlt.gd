extends Area2D
var sfxGlitch=preload("res://scenes/sfxGlitch/glitchSFX.tscn")
func _ready():
	get_parent().add_child(sfxGlitch.instance())
	set_physics_process(true)
func _physics_process(delta):
	for body in self.get_overlapping_bodies():body.glitch()
	self.set_physics_process(false)
