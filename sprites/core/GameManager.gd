extends Node

var coins = 0;
var currentSpawn : Spawn;
var player: Player;

signal pickedCoin(int);


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func pick_coin(coinsPicked: int):
	coins += coinsPicked
	emit_signal("pickedCoin", coinsPicked)
	print(coins)
	
func respawn():
	if currentSpawn != null:
		player.position = currentSpawn.position
		coins = 0
		get_tree().reload_current_scene()
	
