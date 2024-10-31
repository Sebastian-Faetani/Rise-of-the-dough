extends Control

func _on_continue_pressed():
	ButtonSound.play_button()
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")


func _on_cinematic_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
