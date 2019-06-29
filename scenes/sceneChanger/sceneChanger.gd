extends CanvasLayer
var scene
var tweenDuration=0.75
var changingSceneAlready=false
#var growingDiamond=preload("res://scenes/growingDiamond/growingDiamond.tscn")
#var shrinkingDiamond=preload("res://scenes/shrinkingDiamond/shrinkingDiamond.tscn")
var diamond=preload("res://scenes/diamond/diamond.tscn")
func _ready():
	for x in range(0,11,1):
		for y in range(0,11):
			var i=diamond.instance()
			i.global_position=Vector2(x,y)*OS.window_size/10
			i.tweenDuration=self.tweenDuration
			self.call_deferred("add_child",i)
#	yield(get_tree().create_timer(1.5*tweenDuration),"timeout")
#	var errorOnSceneChange=get_tree().change_scene_to(scene)
#	print("Global: Scene change error, " + str(errorOnSceneChange))
#	for child in self.get_children():
#		child.shrink()
#	yield(get_tree().create_timer(1.5*tweenDuration),"timeout")
#	self.queue_free()

func fadeOutDone():
	if not changingSceneAlready:
		print("Scene changer: Changing the scene now...")
		changingSceneAlready=true
		var errorOnSceneChange=get_tree().change_scene_to(scene)
		print("Scene changer: Scene change error, " + str(errorOnSceneChange))
		yield(get_tree().create_timer(tweenDuration),"timeout")
		for child in self.get_children():
			child.shrink()
func fadeInDone():
	print("Scene changer: Scene change done, deleting self now.")
	self.queue_free()