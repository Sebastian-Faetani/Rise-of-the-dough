extends Control
func _ready():
	pass
func _process(_delta):
	pass

func _on_reanudar_pressed():
	ButtonSound.play_button()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	hide()


func _on_menu_pressed():
	ButtonSound.play_button()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
