extends CanvasLayer

@onready var coin_display = $CoinDisplay

func _ready():
	GameManager.pickedCoin.connect(update_coins)


func update_coins(gained_coins):
	coin_display.text = str(GameManager.coins)
	
