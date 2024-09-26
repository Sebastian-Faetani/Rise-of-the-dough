extends StaticBody3D

var player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func collectkeyAscensor():
	print("Llave Juntada")
	queue_free()


func _on_notified_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.notif.show()
		player.notif.text = "Presione E para juntar la llave"


func _on_notified_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.pickup.hide()
