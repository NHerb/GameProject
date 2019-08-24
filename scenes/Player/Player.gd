extends KinematicBody2D

var velocity = Vector2(0,0)
# v = 2h / t,	g = -2h / t^2
const GRAVITY = 512 			# @TODO calculate proper gravity/velocity
const MAX_GRAVITY = 512
var JUMP_VEL = -256
const GROUNDED_GRAVITY = 5		# prevent godot from altering from walking/airborne states while grounded
const TILE_SIZE = 16
var MOVE_SPEED = TILE_SIZE * 8
var DASH_SPEED = MOVE_SPEED * 2
var current_state = "idle"
var state_machine = null
var facing = 'r'
var dashes_remaining = 1		# @TODO decide dash count
var is_dashing = false


func _ready():
	state_machine = get_node("StateMachine")
	set_physics_process(true)
	
	
func _physics_process(delta):
	if OS.is_debug_build() and (position.y < -200 or position.y > 600 or position.x < -200 or position.x > 1200):
		position.x = 350
		position.y = 0
	
	state_machine.update(delta)
	move_and_slide(velocity, Vector2(0,-1))

	
func _unhandled_input(event):
	state_machine.handleInput(event)
	
	
# A more thorough check than is_on_floor(), this returns true even when gravity is not being applied.
func onGround():
	return is_on_floor() or test_move(transform, Vector2(0,1))