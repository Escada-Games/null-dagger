extends Sprite
var tweenDuration=0.75
var numberOfTweens=0
func _ready():grow()
func grow():
	$twnScale.interpolate_property(self,"scale",Vector2(),Vector2(5,5),tweenDuration,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$twnScale.start()
func shrink():
	$twnScale.interpolate_property(self,"scale",Vector2(5,5),Vector2(),tweenDuration,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$twnScale.start()

func _on_twnScale_tween_completed(object, key):
	numberOfTweens+=1
	if numberOfTweens>1:
		self.queue_free()