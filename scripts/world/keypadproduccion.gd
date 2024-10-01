extends StaticBody3D
var salida3
var player
const level2 = preload("res://scenes/maps/Map2.tscn")
@onready var enemy_spawner = $"../../Enemies/EnemySpawner/Timer"
@onready var error_sound: AudioStreamPlayer = $errorSound

func _ready():
	salida3 = get_tree().get_first_node_in_group("salidaAscensor")
	player = get_tree().get_first_node_in_group("player")
func _process(_delta):
	pass

func error3():
	error_sound.play()

func bye3():
	print("Puerta desbloqueada")
	queue_free()
	salida3.bye3()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if player.collectkeyascensor == false:
			player.notif.show()
			player.notif.text = "Necesitas una llave para abrir esto"
		elif player.collectkeyascensor == true:
			player.notif.show()
			player.notif.text = "Presione E para abrir la puerta"


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.notif.hide()
