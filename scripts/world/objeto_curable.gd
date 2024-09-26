extends StaticBody3D
var player
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func objectCollected():
	queue_free()


func _on_notified_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.notif.show()
		player.notif.text = "Presione E para juntar el muffin"


func _on_notified_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.notif.hide()
