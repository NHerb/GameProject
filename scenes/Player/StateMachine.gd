# To add new states, add the new state as a child node of this one and update the state_list below


extends Node

var player = null
var state_list = {}

func _ready():
	player = get_parent()
	state_list = {
		'idle': get_node("Idle"),
		'walk': get_node("Walk"),
		'airborne': get_node("Airborne")
	}

# handle global input (pause, etc), but just send other inputs to current state
func handleInput(event):
	state_list[player.current_state].handleInput(event)

func changeState(next_state):
	state_list[player.current_state].end()
	player.current_state = next_state
	state_list[next_state].enter()

func update():
	state_list[player.current_state].update()