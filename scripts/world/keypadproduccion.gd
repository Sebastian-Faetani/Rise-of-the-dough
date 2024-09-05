extends StaticBody3D
var salida3
const level2 = preload("res://scenes/maps/Map2.tscn")
@onready var enemy_spawner = $"../../Enemies/EnemySpawner/Timer"

func _ready():
	salida3 = get_tree().get_first_node_in_group("salidaAscensor")
func _process(_delta):
	pass
func bye3():
	print("Puerta desbloqueada")
	queue_free()
	salida3.bye3()
	enemy_spawner.timer.stop()
	
