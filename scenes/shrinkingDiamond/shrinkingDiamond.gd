extends Sprite
func _ready():
	$twnScale.interpolate_property(self,"scale",Vector2(5,5),Vector2(),0.75,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$twnScale.start()

func _on_twnScale_tween_completed():self.queue_free()