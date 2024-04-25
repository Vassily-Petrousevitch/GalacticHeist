extends RigidBody2D

var custom_scale = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	# save the scaling the rope is initialized with
	custom_scale = self.scale
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	# This solves the problem of the rope getting resized immediately
	scale = custom_scale
