extends StaticBody3D
var exit
var player
func _ready():
		exit = get_tree().get_first_node_in_group("salida2")
		player = get_tree().get_first_node_in_group("player")

func _process(_delta):
	pass
func bye():
	queue_free()
	exit.bye()


func _on_notified_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if player.collectkey == false:
			player.notif.show()
			player.notif.text = "Necesitas una llave para abrir esto"
		elif player.collectkey == true:
			player.notif.show()
			player.notif.text = "Presione E para abrir la puerta"


func _on_notified_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.notif.hide()
		
