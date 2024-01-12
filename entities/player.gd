extends Node2D

# Constants
const speed = 300;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Point towards mouse
	self.look_at(get_global_mouse_position());
	
	# Basic velocity calc
	var velocity = 0;
	
	if Input.is_action_pressed("accelerate"):
		velocity += 1;
	if Input.is_action_pressed("brake"):
		velocity -= 1;
	
	var x = velocity * speed * cos(self.rotation);
	var y = velocity * speed * sin(self.rotation);
	
	self.position += Vector2(x * delta, y * delta);


# NOTE: similar to python or javascript when accessing itself (self keyword)
# NOTE to self: F8 stops debugging 

