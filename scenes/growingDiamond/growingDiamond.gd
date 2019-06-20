extends Sprite
func _ready():
	$twnScale.interpolate_property(self,"scale",Vector2(),Vector2(5,5),0.75,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$twnScale.start()

#func _on_twnScale_tween_completed(object, key):
#	yield(get_tree().create_timer(0.2),"timeout")
#	self.queue_free()