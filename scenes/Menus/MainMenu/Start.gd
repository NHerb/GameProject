extends Button

func _ready():
	self.text = "Start"

func _on_Start_pressed():
	# Load Level 1's scene file, add to root node
	var levelone_scene = load("res://scenes/Levels/LevelOne/LevelOne.tscn")
	var levelone_instance = levelone_scene.instance()
	get_tree().get_root().add_child(levelone_instance)
	
	# @remove TEST STUFF
	var capsule_scene = load("res://scenes/test_bodies/RigidCapsule.tscn")
	var capsule_one = capsule_scene.instance()
	get_tree().get_root().add_child(capsule_one)
	var player_scene = load("res://scenes/Player/Player.tscn")
	var player = player_scene.instance()
	get_tree().get_root().add_child(player)
	# END TEST
	
	# Unload Main Menu scene
	get_parent().queue_free()
