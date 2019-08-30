# To add new states, add the new state as a child node of this one and update the state_list below


extends Node

var player = null
var state_list = {}

func _ready():
	player = get_parent()
	state_list = {
		'idle': get_node("Idle"),
		'walk': get_node("Walk"),
		'airborne': get_node("Airborne"),
		'attack': get_node("Attack"),
		'dash': get_node("Dash"),
		'dashattack': get_node("DashATK"),
		'airattack': get_node("AirATK"),
		'walljump': get_node("WallJump"),
		'stagger': get_node("Stagger")
	}

# handle global input (pause, etc), but just send other inputs to current state
func handleInput(event):
	state_list[player.current_state].handleInput(event)

func changeState(new_state):
	if not state_list[new_state].isStateValid():
		return
	state_list[player.current_state].end()
	var old_state = player.current_state
	player.current_state = new_state
	state_list[new_state].enter()

func update(delta):
	state_list[player.current_state].update(delta)

func _on_AnimationPlayer_animation_finished(anim_name):
	state_list[player.current_state].anim_done(anim_name)
