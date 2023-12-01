extends Node2D
class_name Spawn


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.currentSpawn = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
