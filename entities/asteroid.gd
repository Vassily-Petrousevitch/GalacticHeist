extends RigidBody2D

# Constants

# ok this one isn't a constant, but don't change its value in code!!!
var asteroid_player_impulse = self.mass / 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_body_entered(body):
	if body.name == "Player":
		body.velocity = self.linear_velocity * asteroid_player_impulse
		if body.has_method("get_stunned_idiot"):
			body.get_stunned_idiot()
			

