extends "base_state.gd"


var walltouch_timer = null
var walljump_timer = null
var nearest_wall = null
var walljump_valid = false

func _ready():
	walltouch_timer = get_child(0)
	walljump_timer = get_child(1)
	walltouch_timer.set_wait_time(0.0167 * 7)
	walljump_timer.set_wait_time(0.0167 * 20)
	

func enter():
	# Jump under the following conditions:
	#	* Player presses jump
	#	* Player collided with floor last frame OR
	#	* Player is exactly 1px above ground
	if (player.is_on_floor() or player.test_move(player.transform, Vector2(0,1))) and Input.is_action_pressed('jump'):
		player.velocity.y = player.JUMP_VEL


func update(delta):
	applyGravity(delta, true)
	
	if not Input.is_action_pressed('left') and not Input.is_action_pressed('right'):
		player.velocity.x = 0
		
	# Land on ground only if player is moving downward!
	if player.is_on_floor() and player.velocity.y > 0:
		if Input.is_action_pressed('left') or Input.is_action_pressed('right'):
			state_machine.changeState('walk')
		else:
			state_machine.changeState('idle')
	
	# Airdrift
	move(true)

	###### experimental wall jump ######
	if player.is_on_wall():
		walltouch_timer.stop()
		walltouch_timer.start()
		walljump_valid = true
		if player.test_move(player.transform, Vector2(-1,0)):
			nearest_wall = 'l'
		elif player.test_move(player.transform, Vector2(1,0)):
			nearest_wall = 'r'
		else:
			nearest_wall = null


func end():
	return

func _on_Timer_timeout():
	nearest_wall = null
	walljump_valid = false
	
func _on_Timer2_timeout():
	pass # Replace with function body.
	
func handleInput(event):
	if event is InputEventKey or event is InputEventJoypadButton:
#		if Input.is_action_just_pressed('dash'):
#			state_machine.changeState('dash')
		if Input.is_action_pressed('attack'):
			state_machine.changeState('airattack')
		elif Input.is_action_pressed('jump') and walljump_valid:
			walljump()


# Walljump after
#	Touching the wall within the last ? frames
#	Moving away from nearest wall
#	Pressing Jump
func walljump():
	if nearest_wall == 'l' and Input.is_action_pressed('right') or nearest_wall == 'r' and Input.is_action_pressed('left'):
		player.velocity.y = player.JUMP_VEL
		if nearest_wall == 'l' and Input.is_action_pressed('dash'):
			player.velocity.x = player.DASH_SPEED
		elif nearest_wall == 'r' and Input.is_action_pressed('dash'):
			player.velocity.x = -player.DASH_SPEED