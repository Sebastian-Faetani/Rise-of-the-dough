extends StaticBody3D
var exit2
var player
func _ready():
	exit2 = get_tree().get_first_node_in_group("salida")
	player = get_tree().get_first_node_in_group("player")
func _process(_delta):
	pass
func bye2():
	queue_free()
	exit2.bye2()


func _on_notifed_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if player.collectkeyfabrica == false:
			player.keypadmensajekeynotobtained.show()
		elif player.collectkeyfabrica == true:
			player.keypadmensajekeyobtained.show()


func _on_notifed_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.keypadmensajekeynotobtained.hide()
		player.keypadmensajekeyobtained.hide()
