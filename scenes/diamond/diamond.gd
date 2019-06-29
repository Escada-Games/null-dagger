extends Sprite
var tweenDuration=0.75
var numberOfTweens=0
signal fadeOutDone
signal fadeInDone
func _ready():
	connect("fadeOutDone",get_parent(),"fadeOutDone")
	connect("fadeInDone",get_parent(),"fadeInDone")
	grow()
func grow():
	$twnScale.interpolate_property(self,"scale",Vector2(),Vector2(15,15),tweenDuration,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$twnScale.start()
func shrink():
	$twnScale.interpolate_property(self,"scale",Vector2(15,15),Vector2(),tweenDuration,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$twnScale.start()

func _on_twnScale_tween_completed(object, key):
	if numberOfTweens==0:
		emit_signal("fadeOutDone")
		numberOfTweens+=1
	elif numberOfTweens>1:
		emit_signal("fadeInDone")
		self.queue_free()