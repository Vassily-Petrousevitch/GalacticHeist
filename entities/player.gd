extends CharacterBody2D

# General constants
const rotate_speed = 0.05;

# Velocity & accel
var max_velocity = Vector2(500, 0)
var accel = 20
var brake_accel = 0.1

func getInput():
	setRotation()
	
	# Velocity from input
	if Input.is_action_pressed("accelerate"):
		velocity = velocity.move_toward(max_velocity.rotated(self.rotation), accel)
	if Input.is_action_pressed("brake"):
		velocity = velocity.lerp(Vector2.ZERO, brake_accel)
	
		
func _physics_process(delta):
	getInput()
	var collision = move_and_collide(velocity * delta)

func setRotation():
	var rotate_direction = 0;
	
	if Input.is_action_pressed("rotate_left"):
		rotate_direction -= 1;	# clockwise
	if Input.is_action_pressed("rotate_right"):
		rotate_direction += 1;	# counter clockwise
		
	self.rotation = fmod(self.rotation + rotate_direction * rotate_speed, 2 * PI)
