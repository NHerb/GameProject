# Currently simulating an animation via timer. @TODO replace timer with animation-based signal


extends "./base_state.gd"


var timer = null


func _ready():
	timer = get_child(0)


func enter():
	if player.facing == 'r':
		player.velocity.x = player.MOVE_SPEED	# @TODO decide dashATK movespeed
	else:
		player.velocity.x = -(player.MOVE_SPEED)
	timer.set_wait_time(0.0167 * 10)
	timer.start()


func end():
	timer.stop()


func update(delta):
	applyGravity(delta, false)


func _on_Timer_timeout():
	state_machine.changeState(neutralState())
