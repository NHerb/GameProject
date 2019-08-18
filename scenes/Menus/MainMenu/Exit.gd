extends Button

func _ready():
	self.text = "Exit"

func _on_Exit_pressed():
	get_tree().quit()
