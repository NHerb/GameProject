# @NOTE @TODO Walljump extremely forgiving when close to both walls simultaneously
# Incorporate into level design or redesign walljump to fix
extends Node


func _ready():
	var mainmenu_scene = load("res://scenes/Menus/MainMenu/MainMenu.tscn")
	var mynode = mainmenu_scene.instance()
	add_child(mynode)