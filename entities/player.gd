extends Node2D

# General constants
const rotate_speed = 0.07;

# Velocity & accel
var velocity = Vector2.ZERO
var max_velocity = Vector2(1000, 1000)
var accel_h = 10
var accel_v = 10

func _process(delta):
	self.rotation = fmod(self.rotation + findNewRotation() * rotate_speed, 2 * PI)
	
	if Input.is_action_pressed("accelerate"):
		var new_speed = Vector2(accel_h * cos(self.rotation), accel_v * sin(self.rotation))
		
		if (abs(new_speed.x + velocity.x) < max_velocity.x):
			velocity.x += new_speed.x
			
		if (abs(new_speed.y + velocity.y) < max_velocity.y):
			velocity.y += new_speed.y
		
	print(velocity)
	position += velocity * delta

func findNewRotation():
	var rotate_direction = 0;
	
	if Input.is_action_pressed("rotate_left"):
		rotate_direction -= 1;	# clockwise
	if Input.is_action_pressed("rotate_right"):
		rotate_direction += 1;	# counter clockwise
		
	return rotate_direction;

# NOTE: similar to python or javascript when accessing itself (self keyword)
# NOTE to self: F8 stops debugging 

