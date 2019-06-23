extends ColorRect
func _ready():
	self.visible=false
	set_physics_process(true)
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		get_tree().paused= not get_tree().paused
		if get_tree().paused:
			self.visible=true
			$twnLabelPos.interpolate_property($marginCtn/label,"rect_position",get_parent().get_parent().global_position,OS.window_size/2,0.4,Tween.TRANS_BACK,Tween.EASE_OUT)
			$twnLabelPos.start()
		else:
			self.visible=false
			