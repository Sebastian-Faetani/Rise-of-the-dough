extends StaticBody3D
var salida3
var player
const level2 = preload("res://scenes/maps/Map2.tscn")
@onready var enemy_spawner = $"../../Enemies/EnemySpawner/Timer"

func _ready():
	salida3 = get_tree().get_first_node_in_group("salidaAscensor")
	player = get_tree().get_first_node_in_group("player")
func _process(_delta):
	pass
func bye3():
	print("Puerta desbloqueada")
	queue_free()
	salida3.bye3()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if player.collectkeyascensor == false:
			player.keypadmensajekeynotobtained.show()
		elif player.collectkeyascensor == true:
			player.keypadmensajekeyobtained.show()


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.keypadmensajekeynotobtained.hide()
		player.keypadmensajekeyobtained.hide()
