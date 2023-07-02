extends Node

# Seconds
const maxTime = 10;
var time =10;
var playerBody;

# Called when the node enters the scene tree for the first time.
func _ready():
	time = maxTime;
	playerBody = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time -= delta;
	if (time < 0):
		playerBody.visible = false
