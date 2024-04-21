extends Node

var rope_piece = preload("res://entities/rope_piece.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Position player in centre (currently is wherever startposition is)
	#$Player.position = $StartPosition.position;
	
	var rope = rope_piece.instantiate()
	rope.position = $Player.position
	add_child(rope)
	
	var joint = PinJoint2D.new()
	joint.position = $Player.position
	joint.node_a = $Player.get_path()
	joint.node_b = rope.get_path()
	add_child(joint)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
