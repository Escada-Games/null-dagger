extends ColorRect
func _ready():
	self.visible=false
	set_physics_process(true)
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		get_tree().paused= not get_tree().paused
		if get_tree().paused:
			self.visible=true
		else:
			self.visible=false