extends Node3D


@onready var timer: Timer = $Enemies/EnemySpawner/Timer
@onready var boss_timer: Timer = $Enemies/EnemySpawner/BossTimer
var player
@onready var gameplay_music = $GameplayMusic

func _ready() -> void:
	gameplay_music.play()
	player = get_tree().get_first_node_in_group("player")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$Area3D/CollisionShape3D.disabled = true
		timer.start()
		boss_timer.start()
	elif body.is_in_group("player"):
		player.spawnermensaje.show()

func _on_win_condition_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.hasWon = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.spawnermensaje.hide()


func _on_spawnermensaje_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.spawnermensaje.show()


func _on_spawnermensaje_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.spawnermensaje.hide()
		
