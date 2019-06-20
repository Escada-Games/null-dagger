extends Node2D
var sceneChanger=preload("res://scenes/sceneChanger/sceneChanger.tscn")
var growingDiamond=preload("res://scenes/growingDiamond/growingDiamond.tscn")
var shrinkingDiamond=preload("res://scenes/shrinkingDiamond/shrinkingDiamond.tscn")
func changeScene(scene):
	var i=sceneChanger.instance()
	i.scene=scene
	get_tree().get_root().add_child(i)
#	for x in range(0,11):
#		for y in range(0,11):
#			var i=growingDiamond.instance()
#			i.global_position=Vector2(x,y)*OS.window_size/11
#			get_tree().get_root().call_deferred("add_child",i)
#	yield(get_tree().create_timer(1.0),"timeout")
#	get_tree().change_scene_to(scene)
#	for x in range(0,11,1):
#		for y in range(0,11):
#			var i=shrinkingDiamond.instance()
#			i.global_position=Vector2(x,y)*OS.window_size/11
#			global.call_deferred("add_child",i)