extends Control



func _ready():
	pass # Replace with function body.



func _process(_delta):
	pass


func _on_storybutton_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/controls_explained.tscn")


func _on_sandboxbutton_pressed():
	get_tree().change_scene_to_file("res://scenes/maps/sandbox.tscn")


func _on_backbutton_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
