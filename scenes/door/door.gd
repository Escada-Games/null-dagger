extends Area2D
#var player
var underPlayer=false
export (PackedScene) var connectedStage=load("res://scenes/stageTest.tscn")
func _ready():set_physics_process(true)
func _physics_process(delta):
	if Input.is_action_just_pressed('ui_up') and underPlayer:
		global.changeScene(connectedStage)
func _on_door_body_entered(body):
	if body.is_in_group("Player"):
		body.onDoor=true
		underPlayer=true
func _on_door_body_exited(body):
	if body.is_in_group("Player"):
		body.onDoor=false
		underPlayer=false