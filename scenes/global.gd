extends Node2D
var sceneChanger=preload("res://scenes/sceneChanger/sceneChanger.tscn")
#var growingDiamond=preload("res://scenes/growingDiamond/growingDiamond.tscn")
#var shrinkingDiamond=preload("res://scenes/shrinkingDiamond/shrinkingDiamond.tscn")
var hasDagger=false
var musicCalm=preload("res://scenes/musicCalm.tscn")
var musicGlitchy=preload("res://scenes/musicGlitchy.tscn")
func _ready():
	hasDagger= true if OS.is_debug_build() else false
	var i=musicCalm.instance()
	self.add_child(i)
	OS.window_size*=2
func changeScene(scene):
	var i=sceneChanger.instance()
	i.scene=scene
	var j=scene.instance()
	if j.name=="2":
		$musicCalm.fadeOut()
	elif j.name=="3":
		var k=musicGlitchy.instance()
		self.add_child(k)
	elif j.name=="8":
		$musicGlitchy.fadeOut()
	j.free()
	get_tree().get_root().add_child(i)
	