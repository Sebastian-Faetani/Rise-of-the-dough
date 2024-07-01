class_name OptionsMenu
extends Control
@onready var button_sound = $Button_Sound

func _on_exit_button_pressed():
	button_sound.play()
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
