extends OmniLight3D
@onready var masamadre: Sprite3D = $"../../Props/TubeBeings/MASAMADRE"
var color = Color(1, 1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_active_light_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		masamadre.modulate = color
		light_energy = 15
		$"../../ActiveLight/CollisionShape3D".disabled = true
