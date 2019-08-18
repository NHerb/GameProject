extends "base_state.gd"


func handleInput(event):
	if event is InputEvent:
		if event.is_action_pressed('jump'):
			state_machine.changeState('airborne')

func update():		
	player.velocity.x = 0
	
	if Input.is_action_pressed('left'):
		player.velocity.x = -(player.MOVE_SPEED)
	elif Input.is_action_pressed('right'):
		player.velocity.x = player.MOVE_SPEED
	else:
		state_machine.changeState('idle')
	
	# Auto switch to airborne in cases where player leaves ground
	if not player.is_on_floor():
		state_machine.changeState('airborne')
		player.velocity.y = 0
		print("Fell!")