class_name OptionsMenu
extends Control

func _on_exit_button_pressed():
	ButtonSound.play_button()
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
