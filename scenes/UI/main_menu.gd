extends Control


func _ready():
	pass # Replace with function body.



func _process(_delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/play_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_creditbutton_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/credit_menu.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/options_menu.tscn")
