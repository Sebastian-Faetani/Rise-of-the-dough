extends Control
func _ready():
	pass
func _process(delta):
	pass

func _on_reanudar_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	hide()


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
