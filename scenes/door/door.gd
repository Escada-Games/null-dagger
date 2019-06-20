extends Area2D
var underPlayer=false
var sceneChanger=preload("res://scenes/sceneChanger/sceneChanger.tscn")
export (PackedScene) var connectedStage=preload("res://scenes/stageTest.tscn")
func _ready():set_physics_process(true)
func _physics_process(delta):
	if Input.is_action_just_pressed('ui_up') and underPlayer:
		global.changeScene(connectedStage)
		
#		var i=sceneChanger.instance()
#		i.scene=connectedStage
#		get_tree().current_scene.add_child(i)
		
#		get_tree().change_scene_to(connectedArea)
func _on_door_body_entered(body):if body.is_in_group("Player"):underPlayer=true
func _on_door_body_exited(body):if body.is_in_group("Player"):underPlayer=false