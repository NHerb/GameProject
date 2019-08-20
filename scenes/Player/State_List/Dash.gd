extends "base_state.gd"

var timer = null
var timeout = false

func _ready():
	timer = get_child(0)


func enter():
	player.dashes_remaining -= 1
	if player.facing == 'r':
		player.velocity.x = player.DASH_SPEED
	else:
		player.velocity.x = -(player.DASH_SPEED)
	timer.set_wait_time(0.33)	# @TODO decide max dash time
	timer.start()
	timeout = false


func end():
	timer.stop()
	

func handleInput(event):
	if event is InputEventKey or event is InputEventJoypadButton:
		if Input.is_action_just_pressed('jump'):
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