extends KinematicBody2D

var vectorVelocity=Vector2()
const horizontalSpeed=375

const jumpForce=275
var numberOfJumps=0
const maxNumberOfJumps=1

var numberOfGlitches=0
const maxNumberOfGlitches=1

var gravity=0
var realGravity=0
var gravityHolding=12
var gravityNormal=15

export (int) var blinkRadius=100
var daggerCount=1

var glitchAura=preload("res://scenes/glitchAura/glitchAura.tscn")
var glitchDagger=preload("res://scenes/glitchDagger/glitchDagger.tscn")

func _ready():
	OS.window_size*=2
	self.add_to_group("Player")
	set_physics_process(true)

func _physics_process(delta):
	gravity=gravityHolding if Input.is_action_pressed("ui_jump") else gravityNormal
	realGravity=lerp(realGravity,gravity,0.25)
	
	if self.is_on_floor():
		numberOfJumps=0
		numberOfGlitches=0
	
	var inputDirection=Vector2()
	inputDirection.x=1 if Input.is_action_pressed("ui_right") else -1 if Input.is_action_pressed("ui_left") else 0
	inputDirection.y=1 if Input.is_action_pressed("ui_down") else -1 if Input.is_action_pressed("ui_up") else 0
	
	$glitchAimArea.position=blinkRadius*(get_global_mouse_position()-self.global_position).normalized()
	
	if Input.is_action_just_pressed("ui_jump") and numberOfJumps<maxNumberOfJumps:
		vectorVelocity.y=-jumpForce
		numberOfJumps+=1
	
	if Input.is_action_just_pressed("ui_lmb") and daggerCount>0:
		var i=glitchDagger.instance()
		i.global_position=self.global_position
		i.direction=$glitchAimArea.position.normalized()
		i.returnTo=self
		i.add_collision_exception_with(self)
		get_parent().add_child(i)
		daggerCount-=1
	
	vectorVelocity.x=lerp(vectorVelocity.x,horizontalSpeed*inputDirection.x,0.1)
	vectorVelocity.y+=realGravity
	
	vectorVelocity=move_and_slide(vectorVelocity,Vector2(0,-1))
	
func glitch():pass