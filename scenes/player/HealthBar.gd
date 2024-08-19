extends TextureProgressBar

@export var player: Player

func _ready():
	player.staminaChanged.connect(update)
	update()
	
func update():
	value = player.current_player_stamina * 100 / player.max_player_stamina
	
