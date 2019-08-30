extends "base_state.gd"

var timer = null
var timeout = false
var on_ground_at_start = false

func _ready():
	timer = get_child(0)


func enter():
	player.dashes_remaining -= 1
	on_ground_at_start = player.onGround()
	if player.facing == 'r':
		player.velocity.x = player.DASH_SPEED
	else:
		player.velocity.x = -(player.DASH_SPEED)
	timer.set_wait_time(0.33)	# @TODO decide max dash time
	timer.start()
	timeout = false
	player.is_dashing = true
	animator.play('dash')


func end():
	timer.stop()
	if on_ground_at_start:
		player.dashes_remaining = 1
	on_ground_at_start = false
	

func handleInput(event):
	if event is InputEventKey or event is InputEventJoypadButton:
		if Input.is_action_just_pressed('jump') and on_ground_at_start:
			jump()
			state_machine.changeState('airborne')
		elif Input.is_action_just_pressed('attack'):
			state_machine.changeState('dashattack')
		
		
func update(delta):
	applyGravity(delta, false)
	if timeout == true:
		state_machine.changeState(neutralState())


func _on_Timer_timeout():
	timeout = true

func isStateValid():
	return player.dashes_remaining > 0