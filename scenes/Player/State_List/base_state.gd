extends Node


var state_machine = null
var player = null
var facing = 'l'


func _ready():
	state_machine = get_parent()
	player = state_machine.get_parent()


func enter():
	return


func end():
	return


func update(delta):
	return


func handleInput(event):
	return


func neutralState():
	if player.is_on_floor() or player.test_move(player.transform, Vector2(0,1)):
		player.velocity.y = player.GROUNDED_GRAVITY
		if Input.is_action_pressed('left') or Input.is_action_pressed('right'):
			return 'walk'
		else:
			return 'idle'
	else:
		return 'airborne'


func move(can_change_facing):
	if Input.is_action_pressed('left'):
		if can_change_facing:
			player.facing = 'l'
		if player.velocity.x > -(player.MOVE_SPEED):
			player.velocity.x = -(player.MOVE_SPEED)
	elif Input.is_action_pressed('right'):
		if can_change_facing:
			player.facing = 'r'
		if player.velocity.x < player.MOVE_SPEED:
			player.velocity.x = player.MOVE_SPEED


func applyGravity(delta, is_gravity_active):
	if not is_gravity_active:
		print("blanking gravity")
		player.velocity.y = 0
	elif player.is_on_floor():
		return
	else:
		player.velocity.y += player.GRAVITY * delta
		
	if player.velocity.y > player.MAX_GRAVITY:
		player.velocity.y = player.MAX_GRAVITY


func fallCheck():
	if not player.is_on_floor():
		state_machine.changeState('airborne')


# Override this function to check extenuating state transition conditions - ex: >0 remaining dashes to enter a dash
func isStateValid():
	return true