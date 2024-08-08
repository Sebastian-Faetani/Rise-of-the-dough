extends Control

@onready var button_sound = $Button_Sound
@onready var music_menu = $Music_Menu


func _ready():
	get_viewport().size = DisplayServer.screen_get_size()
	music_menu.play()



func _process(_delta):
	pass


func _on_start_button_pressed():
	button_sound.play()
	get_tree().change_scene_to_file("res://scenes/UI/play_menu.tscn")

func _on_quit_button_pressed():
	button_sound.play()
	get_tree().quit()


func _on_creditbutton_pressed():
	button_sound.play()
	get_tree().change_scene_to_file("res://scenes/UI/credit_menu.tscn")


func _on_options_button_pressed():
	button_sound.play()
	get_tree().change_scene_to_file("res://scenes/UI/options_menu.tscn")
