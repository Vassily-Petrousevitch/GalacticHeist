extends Node

const map_width = 5000
const map_height = 5000

# chance to spawn a (big) asteroid every x pixels
const asteroid_density = 500
# probability of asteroid spawning
const asteroid_chance = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	# Generate asteroids!
	generate_asteroids()


func new_asteroid(scale_factor: float):
	var asteroid = preload("res://entities/asteroid.tscn")
	var asteroid_instance = asteroid.instantiate()
	asteroid_instance.scale.x *= scale_factor
	asteroid_instance.scale.y *= scale_factor
	# Set asteroid mass as a function of its scale (big asteroid = heavy)
	asteroid_instance.mass = (asteroid_instance.scale.x + asteroid_instance.scale.y) / 2 * 100
	return asteroid_instance

func generate_asteroids():
	# TODO: give asteroids some small, random initial rotational/linear speed
	
	randomize()
	# Every 500 pixels in the playable area, a big asteroid might spawn
	for x in range(-map_width, map_width, 500):
		for y in range(-map_height, map_height, 500):
			if (randf() <= asteroid_chance):
				var location = Vector2()
				var asteroid_instance = new_asteroid(1)
				asteroid_instance.position = Vector2(x, y)
				add_child(asteroid_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
