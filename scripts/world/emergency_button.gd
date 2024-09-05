extends StaticBody3D
@onready var enemy_spawner: Node3D = $"../../Enemies/EnemySpawner"

func EmergencyShutDown():
	enemy_spawner.queue_free()
	queue_free()
