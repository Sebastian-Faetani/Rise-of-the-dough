extends Control
@onready var Map = $".."
@onready var San = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _process(delta):
	pass

func _on_reanudar_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Map.PauseMenu()
	San.PauseMenu()
	



func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
