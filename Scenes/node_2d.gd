extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().size *= 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Camera2D.position.x = lerp($Camera2D.position.x, $Player.position.x, 0.25)
	$Camera2D/SubViewportContainer/SubViewport/Node3D/Camera3D.position.x = $Camera2D.position.x / 50.0
