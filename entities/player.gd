extends CharacterBody2D

# Ship movement parameters
const rotate_speed = 0.06;
var max_velocity = Vector2(500, 0)
var accel = 25
var brake_accel = 0.15

# Collision parameters
const ship_bounceback = 0.25

func _physics_process(delta):
	getInput()
	var bonk = move_and_collide(velocity * delta)
	if bonk:
		velocity = velocity.bounce(bonk.get_normal()) * ship_bounceback
		if bonk.get_collider() is RigidBody2D:
			bonk.get_collider().apply_central_impulse(-bonk.get_normal() * velocity.length())


func getInput():
	setRotation()
	
	# Velocity from input
	if Input.is_action_pressed("accelerate"):
		velocity = velocity.move_toward(max_velocity.rotated(self.rotation), accel)
	if Input.is_action_pressed("brake"):
		velocity = velocity.lerp(Vector2.ZERO, brake_accel)

func setRotation():
	var rotate_direction = 0;
	
	if Input.is_action_pressed("rotate_left"):
		rotate_direction -= 1;	# clockwise
	if Input.is_action_pressed("rotate_right"):
		rotate_direction += 1;	# counter clockwise
		
	self.rotation = fmod(self.rotation + rotate_direction * rotate_speed, 2 * PI)
