extends "base_state.gd"


func enter():
	if player.is_on_floor() and Input.is_action_pressed('jump'):
		print("JUMP")
		player.velocity.y = player.JUMP_VEL


func update():
	player.velocity.x = 0
	
	# Land on ground only if player is moving downward!
	if player.is_on_floor() and player.velocity.y > 0:
		print("Landed.")
		if Input.is_action_pressed('left') or Input.is_action_pressed('right'):
			state_machine.changeState('walk')
		else:
			state_machine.changeState('idle')
	
	# Airdrift
	if Input.is_action_pressed('left'):
		player.velocity.x = -(player.MOVE_SPEED)
	if Input.is_action_pressed('right'):
		player.velocity.x = player.MOVE_SPEED


func end():
	player.velocity.y = player.GROUNDED_GRAVITY