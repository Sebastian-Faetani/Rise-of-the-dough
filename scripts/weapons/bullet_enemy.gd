extends RigidBody3D

@export var damage: int = 10
@export var speed: float = 3.0
@onready var enemy_ray = $EnemyRay.get_children()
var direction: Vector3 = Vector3()

func _ready():
	linear_velocity = direction * speed
	
func set_direction (direction : Vector3) -> void:
	linear_velocity = direction * speed

func check_hit():
	for ray in enemy_ray:
		if ray.is_colliding():
			queue_free()

func _process(_delta):
	check_hit()
