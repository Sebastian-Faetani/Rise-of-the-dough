extends Node3D

@onready var timer: Timer = $Enemies/EnemySpawner/Timer
@onready var gameplay_music = $GameplayMusic

func _ready() -> void:
	gameplay_music.play()


func _on_area_3d_body_entered(body: Node3D) -> void:
	$Area3D/CollisionShape3D.disabled = true
	timer.start()
