extends Control

func _on_continue_pressed():
	ButtonSound.play_button()
	get_tree().change_scene_to_file("res://scenes/maps/Map1.tscn")


func _on_cinematic_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/maps/Map1.tscn")
