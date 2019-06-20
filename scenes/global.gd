extends Node2D
var sceneChanger=preload("res://scenes/sceneChanger/sceneChanger.tscn")
var growingDiamond=preload("res://scenes/growingDiamond/growingDiamond.tscn")
var shrinkingDiamond=preload("res://scenes/shrinkingDiamond/shrinkingDiamond.tscn")
var hasDagger=false
func _ready():OS.window_size*=2
func changeScene(scene):
	var i=sceneChanger.instance()
	i.scene=scene
	get_tree().get_root().add_child(i)