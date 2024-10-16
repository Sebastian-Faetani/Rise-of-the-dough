extends Control



func _ready():
	pass # Replace with function body.



func _process(_delta):
	pass


func _on_storybutton_pressed():
	ButtonSound.play_button()
	get_tree().change_scene_to_file("res://scenes/UI/controls_explained.tscn")
	MusicMenu.stop_music()


func _on_backbutton_pressed():
	ButtonSound.play_button()
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
