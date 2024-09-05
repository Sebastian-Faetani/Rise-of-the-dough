extends Node3D
const ENEMY = preload("res://scenes/enemies/enemy.tscn")
var player
var enemy
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	enemy = get_tree().get_first_node_in_group("enemies")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	var enemy = ENEMY.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = global_position
	enemy.current_state = enemy.EnemyStates.Chasing
	
