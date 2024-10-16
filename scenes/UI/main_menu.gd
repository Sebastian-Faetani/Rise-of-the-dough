extends Control


func _ready():
	#get_viewport().max_scale= DisplayServer.screen_get_max_scale()
	#get_viewport().size = DisplayServer.screen_get_size()
	MusicMenu.play_music()



func _process(_delta):
	pass


func _on_start_button_pressed():
	ButtonSound.play_button()
	get_tree().change_scene_to_file("res://scenes/UI/play_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()


func _on_creditbutton_pressed():
	ButtonSound.play_button()
	get_tree().change_scene_to_file("res://scenes/UI/credit_menu.tscn")


func _on_options_button_pressed():
	ButtonSound.play_button()
	get_tree().change_scene_to_file("res://scenes/UI/options_menu.tscn")
