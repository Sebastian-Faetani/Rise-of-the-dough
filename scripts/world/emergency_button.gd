extends StaticBody3D
@onready var enemy_spawner: Node3D = $"../../Enemies/EnemySpawner"
@onready var button_no_pressed: Sprite3D = $ButtonNoPressed
@onready var button_pressed: Sprite3D = $ButtonPressed
var pressed = false
var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func EmergencyShutDown():
	if pressed == false:
		pressed = true
		button_no_pressed.hide()
		button_pressed.show()
		enemy_spawner.queue_free()
		


func _on_notified_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if pressed == false:
			player.notif.show()
			player.notif.text = "Presione E para apretar"


func _on_notified_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.notif.hide()
