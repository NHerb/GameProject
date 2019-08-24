# Currently simulating an animation via timer. @TODO replace timer with animation-based signal
extends "./base_state.gd"


var timer = null


func _ready():
	timer = get_child(0)


func enter():
	timer.set_wait_time(0.0167 * 7)
	timer.start()


func end():
	timer.stop()


func update(delta):
	applyGravity(delta, true)
	player.velocity.x = 0
	move(false)


func _on_Timer_timeout():
	state_machine.changeState(neutralState())
