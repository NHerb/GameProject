extends KinematicBody2D

var velocity = Vector2(0,0)
# v = 2h / t,	g = -2h / t^2
var JUMP_VEL = -256 			# @TODO calculate proper gravity/velocity
const GRAVITY = 512
const MAX_GRAVITY = 1000
const GROUNDED_GRAVITY = 5		# prevent godot from altering from walking/airborne states while grounded
const TILE_SIZE = 16
const TARGET_FPS = 60
var MOVE_SPEED = TILE_SIZE * 8
var current_state = "idle"
var state_machine = null

func _ready():
	state_machine = get_node("StateMachine")
	set_physics_process(true)
	
func _physics_process(delta):
	if OS.is_debug_build() and position.y > 600:
		position.y = 200
		
	if is_on_floor():
		pass
	else:
		velocity.y += GRAVITY * delta
	if velocity.y > MAX_GRAVITY:
		velocity.y = MAX_GRAVITY
	
	move_and_slide(velocity, Vector2(0,-1))
	state_machine.update()

	
func _unhandled_input(event):
	state_machine.handleInput(event)