extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _input(event: InputEvent):
	# Unpause with a key input
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			get_tree().paused = false
			self.hide()
			get_viewport().set_input_as_handled()

