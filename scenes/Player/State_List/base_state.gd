extends Node

var state_machine = null
var player = null

func _ready():
	state_machine = get_parent()
	player = state_machine.get_parent()

func change_state_to():
	return null

func enter():
	return

func end():
	return

func handleInput(event):
	return

func update():
	return