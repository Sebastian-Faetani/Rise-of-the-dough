extends RigidBody3D
var player
@export var damage: int = 30
@export var speed: float = 5.0
@onready var enemy_ray = $EnemyRay.get_children()

var direction: Vector3 = Vector3()

func _ready():
	linear_velocity = direction * speed
	player = get_tree().get_first_node_in_group("player")
	
func set_direction (direction : Vector3) -> void:
	linear_velocity = direction * speed

func check_hit():
	for ray in enemy_ray:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("player"):
				danio()
				queue_free()
		elif ray.is_colliding():
			queue_free()
				

func _process(_delta):
	check_hit()
	
func danio():
	player.current_player_health -= damage


func _on_timer_timeout() -> void:
	queue_free()
