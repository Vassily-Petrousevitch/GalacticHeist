extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	# Generate asteroids!
	$Map.generate_asteroids()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event: InputEvent):
	# Handle pause inputs
	if(event.is_action_pressed("pause")):
		$PauseMenu.show()
		get_tree().paused = not get_tree().paused
		get_viewport().set_input_as_handled()
