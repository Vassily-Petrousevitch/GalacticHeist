extends Node2D

# General constants
const rotate_speed = 0.07;

# Force constants
const thrust = Vector2(2500, 0);
const brake_scalar = 300;	# Almost like reverse thrusters

func _integrate_forces(state):
	# Rotation
	var rotation_direction = findNewRotation();
	self.rotation += rotation_direction * rotate_speed;
	
	# TODO: implement max speed (for thrusters)
	if Input.is_action_pressed("accelerate"):
		state.apply_force(thrust.rotated(self.rotation));
	else:
		state.apply_force(Vector2());
	
	# TODO: add braking using lin damp

func findNewRotation():
	var rotate_direction = 0;
	
	if Input.is_action_pressed("rotate_left"):
		rotate_direction -= 1;	# clockwise
	if Input.is_action_pressed("rotate_right"):
		rotate_direction += 1;	# counter clockwise
		
	return rotate_direction;

# NOTE: similar to python or javascript when accessing itself (self keyword)
# NOTE to self: F8 stops debugging 

