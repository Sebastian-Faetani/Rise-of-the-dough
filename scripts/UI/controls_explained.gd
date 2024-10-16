extends Control

func _on_continuar_pressed():
	ButtonSound.play_button()
	get_tree().change_scene_to_file("res://scenes/UI/story_scene.tscn")
