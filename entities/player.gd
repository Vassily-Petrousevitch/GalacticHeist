extends CharacterBody2D

# Ship movement parameters
const rotate_speed = 0.06;
const max_velocity = Vector2(500, 0)
const accel = 25
const brake_accel = 0.15

# Collision parameters
const ship_bounceback = 0.25
var stunned = false

# Bullet parameters
const bullet_scene = preload("res://entities/bullet.tscn")
const bullet_timeout = 0.5		# seconds


func _physics_process(delta):
	if not stunned:
		get_input()
	var col = move_and_collide(velocity * delta)
	if col:
		velocity = velocity.bounce(col.get_normal()) * ship_bounceback
		get_stunned()
		if col.get_collider() is RigidBody2D:
			col.get_collider().apply_central_impulse(-col.get_normal() * velocity.length())


func get_stunned():
	stunned = true
	self.modulate = Color("4d4d4d")		# overlay with a gray filter
	await get_tree().create_timer(0.5).timeout # waits briefly
	stunned = false
	self.modulate = Color("fff")

func shoot_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.velocity = Vector2(10, 10)
	bullet.position = get_global_position() + Vector2(15, 15)
	get_parent().add_child(bullet)

func get_input():
	setRotation()
	
	# Velocity from input
	if Input.is_action_pressed("accelerate"):
		velocity = velocity.move_toward(max_velocity.rotated(self.rotation), accel)
	if Input.is_action_pressed("brake"):
		velocity = velocity.lerp(Vector2.ZERO, brake_accel)
		
	if Input.is_action_just_pressed("shoot"):
		shoot_bullet()

func setRotation():
	var rotate_direction = 0;
	
	if Input.is_action_pressed("rotate_left"):
		rotate_direction -= 1;	# clockwise
	if Input.is_action_pressed("rotate_right"):
		rotate_direction += 1;	# counter clockwise
		
	self.rotation = fmod(self.rotation + rotate_direction * rotate_speed, 2 * PI)
