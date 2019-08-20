extends "base_state.gd"


func enter():
	player.velocity.y = player.GROUNDED_GRAVITY
	player.dashes_remaining = 1	# @TODO determine number of dashes


func handleInput(event):
	if event is InputEventKey or event is InputEventJoypadButton:
		if Input.is_action_just_pressed('jump'):
			state_machine.changeState('airborne')
		elif Input.is_action_pressed('left') or Input.is_action_pressed('right'):
			state_machine.changeState('walk')
		elif Input.is_action_pressed('attack'):
			state_machine.changeState('attack')
		elif Input.is_action_just_pressed('dash'):
			state_machine.changeState('dash')


func update(delta):
	fallCheck()
	applyGravity(delta, true)
	player.velocity.x = 0
	