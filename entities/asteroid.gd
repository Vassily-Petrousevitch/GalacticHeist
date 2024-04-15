extends RigidBody2D

const asteroid_player_impulse = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		body.velocity = self.linear_velocity * asteroid_player_impulse
		if body.has_method("get_stunned_idiot"):
			body.get_stunned_idiot()
			
