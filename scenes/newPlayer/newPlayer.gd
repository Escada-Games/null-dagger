extends KinematicBody2D

var vectorVelocity=Vector2()
const horizontalSpeed=175

const jumpForce=285
var numberOfJumps=0
const maxNumberOfJumps=1

var jumpBuffer=0
var maximumJumpBuffer=10

var jumpPressBuffer=0
var maximumJumpPressBuffer=5

var gravity=0
var realGravity=0
var gravityHolding=13
var gravityNormal=17

export (int) var blinkRadius=25
var daggerCount=1
var hasDagger=false

var glitchAura=preload("res://scenes/glitchAura/glitchAura.tscn")
var glitchDagger=preload("res://scenes/glitchDagger/glitchDagger.tscn")

var spawnCheckpoint=preload("res://scenes/checkpoint/checkpoint.tscn")
var checkpoint

func _ready():
	OS.window_size*=2
	$glitchAim.visible=false
	self.add_to_group("Unglitchable")
	self.add_to_group("Player")
	var i=spawnCheckpoint.instance()
	i.global_position=self.global_position
	i.visible=false
	checkpoint=i
	get_parent().add_child(i)
	set_physics_process(true)
	getDagger()

func _physics_process(delta):
	jumpBuffer+=1
	jumpPressBuffer+=1
	
	gravity=gravityHolding if Input.is_action_pressed("ui_jump") else gravityNormal
	realGravity=lerp(realGravity,gravity,0.25)
	
	if self.is_on_floor():
		jumpBuffer=0
		numberOfJumps=0
	
	var inputDirection=Vector2()
	inputDirection.x=1 if Input.is_action_pressed("ui_right") else -1 if Input.is_action_pressed("ui_left") else 0
	inputDirection.y=1 if Input.is_action_pressed("ui_down") else -1 if Input.is_action_pressed("ui_up") else 0
	
	$glitchAim.position=blinkRadius*(get_global_mouse_position()-self.global_position).normalized()
	
	if Input.is_action_just_pressed("ui_jump"):
		jumpPressBuffer=0
		
	if jumpPressBuffer<maximumJumpPressBuffer and numberOfJumps<maxNumberOfJumps and jumpBuffer<maximumJumpBuffer:
		vectorVelocity.y=-jumpForce
		numberOfJumps+=1
	
	if Input.is_action_just_pressed("ui_lmb") and daggerCount>0 and hasDagger:
		var i=glitchDagger.instance()
		i.global_position=$glitchAim.global_position
		i.direction=$glitchAim.position.normalized()
		i.returnTo=self
		i.add_collision_exception_with(self)
		get_parent().add_child(i)
		daggerCount-=1
	
	if Input.is_action_just_pressed("ui_die"): self.die()

	
	vectorVelocity.x=lerp(vectorVelocity.x,horizontalSpeed*inputDirection.x,0.1)
	vectorVelocity.y+=realGravity
	
	vectorVelocity=move_and_slide(vectorVelocity,Vector2(0,-1))
	
func glitch():pass
func die():
	self.vectorVelocity=Vector2()
	self.global_position=checkpoint.global_position+Vector2(0,-16)
func getDagger():
	self.hasDagger=true
	$glitchAim.visible=true