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
const bullet_speed = 2000
const bullet_timeout = 0.2		# seconds
var bullet_on_cooldown = false

# Rope parameters
var rope_piece = preload("res://entities/rope_piece.tscn")
var roped_object = null
var rope_node = null
var joints = []

func _physics_process(delta):
	if not stunned:
		get_input()
	var col = move_and_collide(velocity * delta)
	if col:
		velocity = velocity.bounce(col.get_normal()) * ship_bounceback
		get_stunned_idiot()
	

func get_stunned_idiot():
	stunned = true
	self.modulate = Color("4d4d4d")		# overlay with a gray filter
	await get_tree().create_timer(0.5).timeout # waits briefly
	stunned = false
	self.modulate = Color("fff")

func shoot_bullet():
	var mouse_pos = get_global_mouse_position()
	
	var bullet = bullet_scene.instantiate()
	bullet.velocity = global_position.direction_to(mouse_pos) * bullet_speed
	bullet.position = get_global_position()
	get_parent().add_child(bullet)
	
	bullet_on_cooldown = true
	await get_tree().create_timer(bullet_timeout).timeout
	bullet_on_cooldown = false

func get_input():
	setRotation()
	
	# Velocity from input
	if Input.is_action_pressed("accelerate"):
		velocity = velocity.move_toward(max_velocity.rotated(self.rotation), accel)
	if Input.is_action_pressed("brake"):
		velocity = velocity.lerp(Vector2.ZERO, brake_accel)
		
	if Input.is_action_pressed("shoot") && !bullet_on_cooldown:
		shoot_bullet()
		
	if Input.is_action_just_pressed("rope"):
		if (!roped_object):
			rope_object()
		else:
			destroy_rope()
		
func rope_object():
	# Raycast to detect nearby "rope-able" objects
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(self.position, get_global_mouse_position(), 0xFFFFFFFF, [self])
	var result = space_state.intersect_ray(query)
	
	# Check whether an object was selected + is pickable
	if result && result.collider.input_pickable:
		var object = result.collider
		
		# Make a rope piece on top of the player
		var rope = rope_piece.instantiate()
		rope.position = self.position
		# adjust rotation of rope to point to selected object
		rope.rotation = (self.position - object.position).angle() + PI
		rope.scale.x = (self.position - object.position).length() / 100
		get_parent().add_child(rope)
		rope_node = rope
		
		# Attach rope to player using PinJoint
		var joint = PinJoint2D.new()
		joint.position = self.position
		joint.node_a = self.get_path()
		joint.node_b = rope.get_path()
		get_parent().add_child(joint)
		joints.append(joint)
		
		# Attach rope to target object using PinJoint
		var joint2 = PinJoint2D.new()
		joint2.position = object.position
		joint2.node_a = object.get_path()
		joint2.node_b = rope.get_path()
		get_parent().add_child(joint2)
		joints.append(joint2)
		
		# Wiggle prevention (works!!!)
		object.linear_damp = 100000
		object.angular_damp = 100000
		
		roped_object = object
		

func destroy_rope():
	for joint in joints:
		joint.queue_free()
	pass
	rope_node.queue_free()
	
	# Take off wiggle prevention so the physics works
	roped_object.linear_damp = 0
	roped_object.angular_damp = 0
	
	joints = []
	roped_object = null
	rope_node = null

func setRotation():
	var rotate_direction = 0;
	
	if Input.is_action_pressed("rotate_left"):
		rotate_direction -= 1;	# clockwise
	if Input.is_action_pressed("rotate_right"):
		rotate_direction += 1;	# counter clockwise
		
	self.rotation = fmod(self.rotation + rotate_direction * rotate_speed, 2 * PI)
