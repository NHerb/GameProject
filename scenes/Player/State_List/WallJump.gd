extends "./base_state.gd"


func _ready():
	pass


func enter():
	player.velocity.y = player.JUMP_VEL
	state_machine.changeState(neutralState())