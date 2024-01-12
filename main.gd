extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	# Position player in centre (currently is wherever startposition is)
	$Player.position = $StartPosition.position;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
