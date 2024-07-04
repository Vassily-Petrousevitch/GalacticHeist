extends Node

const map_width = 5000
const map_height = 5000

# Minimum space between big asteroids (pixels)
const asteroid_density = 1000

# probability of big asteroid spawning
const asteroid_chance = 0.2

# Number of small asteroids near the big asteroid (min/max)
const small_asteroid_min = 1
const small_asteroid_max = 10

# How far the small asteroids can spawn from the big asteroid 
const small_asteroid_dist = 400


func new_asteroid(scale_factor: float):
	var asteroid = preload("res://entities/asteroid.tscn")
	var asteroid_instance = asteroid.instantiate()
	
	# Scale down child entities (rigid body scaling is weird)
	for child in asteroid_instance.get_children():
		if child is Node2D:
			child.scale *= scale_factor
			child.transform.origin *= scale_factor
	
	# Set asteroid mass as a function of its scale (big asteroid = heavy)
	asteroid_instance.mass = scale_factor * 100
	return asteroid_instance
	

func generate_asteroids():
	randomize()
	# Every 500 pixels in the playable area, a big asteroid might spawn
	for x in range(-map_width, map_width, 500):
		for y in range(-map_height, map_height, 500):
			if (randf() <= asteroid_chance):
				# Make a big asteroid at the current location
				var asteroid_instance = new_asteroid(1)
				asteroid_instance.position = Vector2(x, y)
				add_child(asteroid_instance)
				
				# Make smaller asteroids near the big one
				for i in randi_range(1, 3):
					var small_x = randi_range(x-small_asteroid_dist, x+small_asteroid_dist)
					var small_y = randi_range(y-small_asteroid_dist, y+small_asteroid_dist)
					
					var small_asteroid_instance = new_asteroid(randf_range(0.10, 0.30))
					small_asteroid_instance.position = Vector2(small_x, small_y)
					add_child(small_asteroid_instance)
					
