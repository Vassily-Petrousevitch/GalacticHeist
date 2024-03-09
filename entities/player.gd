extends Node2D

# General constants
const rotate_speed = 0.07;

# Velocity & accel
var velocity = Vector2.ZERO
var max_velocity = Vector2(1000, 0)
var accel = 50

func _process(delta):
	self.rotation = fmod(self.rotation + findNewRotation() * rotate_speed, 2 * PI)
	
	if Input.is_action_pressed("accelerate"):
		velocity = velocity.move_toward(max_velocity.rotated(self.rotation), accel)
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

