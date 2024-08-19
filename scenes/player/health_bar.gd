extends TextureProgressBar

@export var player: Player

func _ready():
	player.healthChanged.connect(update)
	update()
	
func update():
	value = player.current_player_health * 100 / player.max_player_health
	
