extends Node3D
const ENEMY = preload("res://scenes/enemies/enemy.tscn")
const MB_ENEMY = preload("res://scenes/enemies/mb_enemy.tscn")
var player
var enemy
var mb_enemy
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	enemy = get_tree().get_first_node_in_group("enemies")
	mb_enemy = get_tree().get_first_node_in_group("bossEnemy")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	var enemy = ENEMY.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = global_position
	enemy.current_state = enemy.EnemyStates.Chasing
	
func _on_boss_timer_timeout() -> void:
	var mb_enemy = MB_ENEMY.instantiate()
	get_parent().add_child(mb_enemy)
	mb_enemy.global_position = global_position
	mb_enemy.current_state = mb_enemy.EnemyStates.Chasing
