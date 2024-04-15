extends CharacterBody2D

const bullet_impulse = 1000

func _physics_process(delta):
	var col = move_and_collide(velocity * delta)
	if col:
		if col.get_collider() is RigidBody2D:
			col.get_collider().apply_central_impulse(-col.get_normal() * bullet_impulse)
		queue_free()
