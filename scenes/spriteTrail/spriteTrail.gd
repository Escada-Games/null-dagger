extends Sprite
func _ready():
	self.modulate=Color('c700ff')
	$twnAlpha.interpolate_property(self,"modulate:a",self.modulate.a,0,0.5,Tween.TRANS_QUART,Tween.EASE_OUT)
	$twnAlpha.start()
func _on_twnAlpha_tween_completed(object, key):self.queue_free()