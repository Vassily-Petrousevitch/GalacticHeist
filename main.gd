extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	# Generate asteroids!
	$Map.generate_asteroids()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
