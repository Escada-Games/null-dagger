extends Node2D
func _ready():set_physics_process(true)
func _physics_process(delta):update()
func _draw():
#	draw_circle(Vector2(), 100, Color("ffffff"))
	draw_rect(Rect2(Vector2()-Vector2(25,25),Vector2(50,50))Color('ffffff'),True)