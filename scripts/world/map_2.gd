extends Node3D


@onready var timer: Timer = $Enemies/EnemySpawner/Timer
@onready var boss_timer: Timer = $Enemies/EnemySpawner/BossTimer
var player
@onready var gameplay_music = $GameplayMusic
@onready var enemy_begginer: Area3D = $EnemyBegginer

func _ready() -> void:
	gameplay_music.play()
	player = get_tree().get_first_node_in_group("player")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$EnemyBegginer/CollisionShape3D.disabled = true
		timer.start()
		boss_timer.start()
		player.lore_message.show()
		player.lore_message.text= "Que ha sido eso, creo que se ha activado algo"
		
func _on_win_condition_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.hasWon = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.lore_message.hide()
		enemy_begginer.queue_free()
		
