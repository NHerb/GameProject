extends "base_state.gd"

# Touching a wall gives leniency with how far the player can be when WJ'ing off of it
const WJ_DISTANCE = 15
const WJ_TOUCH_BONUS = 10
var walltouch_timer = null
var walltouch = false

func _ready():
	walltouch_timer = get_child(0)
	walltouch_timer.set_wait_time(0.0167 * 7)
	return

func enter():
	animator.play('airborne')

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

	if player.is_on_wall():
		walltouch = true
		walltouch_timer.start()


func end():
	return

func _on_Timer_timeout():
	walltouch = false
	walltouch_timer.stop()

	
func handleInput(event):
	if event is InputEventKey or event is InputEventJoypadButton:
		if Input.is_action_just_pressed('dash'):
			state_machine.changeState('dash')
		if Input.is_action_just_pressed('attack'):
			state_machine.changeState('airattack')
		elif Input.is_action_just_pressed('jump'):
			walljump()


# Walljump after
#	Within x pixels of nearest wall
#	Moving away from nearest wall
#	Pressing Jump
func walljump():
	var distance = WJ_DISTANCE
	if walltouch:
		distance = WJ_DISTANCE + WJ_TOUCH_BONUS
		
	if Input.is_action_pressed('right') and player.test_move(player.transform, Vector2(-distance,0)):
		player.is_dashing = false
		player.velocity.y = player.JUMP_VEL
		animator.play('walljump')
		if Input.is_action_pressed('dash'):
			player.is_dashing = true
			player.velocity.x = player.DASH_SPEED
	elif Input.is_action_pressed('left') and player.test_move(player.transform, Vector2(distance,0)):
		player.is_dashing = false
		player.velocity.y = player.JUMP_VEL
		animator.play('walljump')
		if Input.is_action_pressed('dash'):
			player.is_dashing = true
			player.velocity.x = -player.DASH_SPEED

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'walljump':
		animator.play('airborne')
