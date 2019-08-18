extends "base_state.gd"


func handleInput(event):
	if event is InputEvent:
		if event.is_action_pressed('jump'):
			state_machine.changeState('airborne')
		elif Input.is_action_pressed('left') or Input.is_action_pressed('right'):
			state_machine.changeState('walk')


func update():
	player.velocity.x = 0
	
	# Auto switch to airborne in cases where player leaves ground
	if not player.is_on_floor():
		state_machine.changeState('airborne')
		print("Fell!")