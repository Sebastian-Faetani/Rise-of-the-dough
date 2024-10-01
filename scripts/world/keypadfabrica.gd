extends StaticBody3D
var exit2
var player
@onready var error_sound: AudioStreamPlayer = $errorSound

func _ready():
	exit2 = get_tree().get_first_node_in_group("salida")
	player = get_tree().get_first_node_in_group("player")
func _process(_delta):
	pass
	
func error2():
	error_sound.play()
	
func bye2():
	queue_free()
	exit2.bye2()


func _on_notifed_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if player.collectkeyfabrica == false:
			player.notif.show()
			player.notif.text = "Necesitas una llave para abrir esto"
		elif player.collectkeyfabrica == true:
			player.notif.show()
			player.notif.text = "Presione E para abrir la puerta"


func _on_notifed_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.notif.hide()
