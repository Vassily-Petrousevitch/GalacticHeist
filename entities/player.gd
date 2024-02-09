extends Node2D

# General constants
const rotation_speed = 5;

# Force constants
const thruster_scalar = 200;
const brake_scalar = 300;	# Almost like reverse thrusters

# Global variables
var curr_velocity;

# Called when the node enters the scene tree for the first time.
func _ready():
	curr_velocity = Vector2.ZERO;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var rotate_direction = findNewRotation();
	# New rotation
	self.rotation += rotate_direction * rotation_speed * delta;
	
	
	var velocity = findNewVelocity(curr_velocity);	# 2D Vector
	curr_velocity = velocity;
	
	# New position based on velocity 
	var x = velocity[0];
	var y = velocity[1];
	self.position += Vector2(x * delta, y * delta);

# Calculate new velocity using force vectors
func findNewVelocity(curr_velocity):
	var velocity = curr_velocity;
	
	# Calculate all forces acting upon ship, put result in a 2d vector
	var force = findSumForce(curr_velocity);
	
	# Add/subtract to current velocity using forces + ship mass
	velocity += force / self.mass;
	
	return velocity;


func findSumForce(curr_velocity):
	var force = Vector2.ZERO;
	
	# Ship thrusters (TODO: decrease effect if ship is fast enough)
	if Input.is_action_pressed("accelerate"):
		force += Vector2(thruster_scalar * cos(self.rotation), 
						thruster_scalar * sin(self.rotation)); 
	
	# Ship brakes
	if Input.is_action_pressed("brake"):
		pass
	
	# TODO: Other stuff (e.g. bumping into asteroids)
	
	return force;

func findNewRotation():
	var rotate_direction = 0;
	
	if Input.is_action_pressed("rotate_left"):
		rotate_direction -= 1;	# clockwise
	if Input.is_action_pressed("rotate_right"):
		rotate_direction += 1;	# counter clockwise
		
	return rotate_direction;

# NOTE: similar to python or javascript when accessing itself (self keyword)
# NOTE to self: F8 stops debugging 

