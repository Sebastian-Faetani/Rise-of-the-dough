extends Camera3D

@export var speed := 44.0
@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0
var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var offset

func apply_shake():
	shake_strength = randomStrength

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, shakeFade * delta)
		offset = randomOffset()

func randomOffset() -> Vector3:
	return Vector3(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength),rng.randf_range(-shake_strength, shake_strength))

func _physics_process(delta: float) -> void:
	var weight = clamp(delta * speed, 0.0, 1.0)
	
	global_transform = global_transform.interpolate_with(get_parent().global_transform, weight)
	global_position = get_parent().global_position
