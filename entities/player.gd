extends Node2D

# General constants
const rotate_speed = 0.07;

# Force constants
const thrust = Vector2(5000, 0);
const thrust_damp_scalar = 0.001;
const min_brake = 1;	
const max_brake = 1000;

func _integrate_forces(state):	
	if Input.is_action_pressed("accelerate"):
		# Damps based on current velocity
		self.linear_damp = generateLinDamp();
		state.apply_force(thrust.rotated(self.rotation));
	else:
		self.linear_damp = 0;	# or something else
		state.apply_force(Vector2());
	
	if Input.is_action_pressed("brake"):
		self.linear_damp = clamp(generateLinDamp(), min_brake, max_brake);
		
	self.rotation += findNewRotation() * rotate_speed;

# returns c * thrust_damp_scalar, where c^2 = velocity.x^2 + velocity.y^2
func generateLinDamp():
	return pow(pow(self.linear_velocity.x, 2) 
				+ pow(self.linear_velocity.y, 2), 0.5) * thrust_damp_scalar;

func findNewRotation():
	var rotate_direction = 0;
	
	if Input.is_action_pressed("rotate_left"):
		rotate_direction -= 1;	# clockwise
	if Input.is_action_pressed("rotate_right"):
		rotate_direction += 1;	# counter clockwise
		
	return rotate_direction;

# NOTE: similar to python or javascript when accessing itself (self keyword)
# NOTE to self: F8 stops debugging 

