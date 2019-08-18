extends Label

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	self.text = "state: " + get_parent().current_state + "\nX:  " + str(round(get_parent().position.x)) + "  Y: " + str(round(get_parent().position.y)) + "\ny_vel: " + str(get_parent().velocity.y)
