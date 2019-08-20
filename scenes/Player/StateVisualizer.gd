extends Label

var player = null

func _ready():
	player = get_parent()
	set_physics_process(true)

func _physics_process(delta):
	self.text = "state: " + player.current_state
	self.text += "\nX:  " + str(round(player.position.x)) + "  Y: " + str(round(player.position.y)) 
	self.text += "\nx_vel: " + str(round(player.velocity.x)) + " y_vel: " + str(round(player.velocity.y))
