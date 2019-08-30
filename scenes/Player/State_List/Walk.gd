extends "base_state.gd"


func enter():
	player.velocity.y = player.GROUNDED_GRAVITY
	player.dashes_remaining = 1	 # @TODO decide max dashes
	player.is_dashing = false
	animator.play('walk')
	

func handleInput(event):
	if event is InputEventKey or event is InputEventJoypadButton:
		if Input.is_action_just_pressed('jump'):
			jump()
			state_machine.changeState('airborne')
		elif Input.is_action_pressed('attack'):
			state_machine.changeState('attack')
		elif Input.is_action_just_pressed('dash'):
			state_machine.changeState('dash')


func update(delta):		
	fallCheck()
	applyGravity(delta, true)
	player.velocity.x = 0
	move(true)
	if not Input.is_action_pressed('left') and not Input.is_action_pressed('right'):
		state_machine.changeState('idle')
	