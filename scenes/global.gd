extends Node2D
var sceneChanger=preload("res://scenes/sceneChanger/sceneChanger.tscn")
var growingDiamond=preload("res://scenes/growingDiamond/growingDiamond.tscn")
var shrinkingDiamond=preload("res://scenes/shrinkingDiamond/shrinkingDiamond.tscn")
var hasDagger=false
var musicCalm=preload("res://scenes/musicCalm.tscn")
func _ready():
	var i=musicCalm.instance()
	self.add_child(i)
	OS.window_size*=2
func changeScene(scene):
	var i=sceneChanger.instance()
	i.scene=scene
	print(self.get_children()[0].name)
	var j=scene.instance()
	if j.name=="2":
		$musicCalm.fadeOut()
	j.free()
	get_tree().get_root().add_child(i)