extends Node2D

# Constants
const movement_speed = 600;
const rotation_speed = 5;

# Force calculations
# TODO: this
const ship_mass = 500;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# NOTE: probably will have to tell chase that the ships will have 
	# a turret on top of a ship
	
	var velocity = findNewVelocity();
	var rotate_direction = findNewRotation();
	
	# New rotation
	self.rotation += rotate_direction * rotation_speed * delta;
	
	# New position based on current velocity & rotation
	var x = velocity * movement_speed * cos(self.rotation);
	var y = velocity * movement_speed * sin(self.rotation);
	self.position += Vector2(x * delta, y * delta);

# Calculate new velocity
func findNewVelocity():
	var velocity = 0;
	
	# TODO: this should be force-based
	if Input.is_action_pressed("accelerate"):
		velocity += 1;
	if Input.is_action_pressed("brake"):
		velocity -= 1;
	
	return velocity;

func findNewRotation():
	var rotate_direction = 0;
	
	if Input.is_action_pressed("rotate_left"):
		rotate_direction -= 1;	# clockwise
	if Input.is_action_pressed("rotate_right"):
		rotate_direction += 1;	# counter clockwise
		
	return rotate_direction;

# NOTE: similar to python or javascript when accessing itself (self keyword)
# NOTE to self: F8 stops debugging 

