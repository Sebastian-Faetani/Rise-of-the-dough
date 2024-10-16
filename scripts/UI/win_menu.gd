extends Control

func victory_arrived() -> void:
	get_tree().paused = true
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_menu_button_pressed():
	ButtonSound.play_button()
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
