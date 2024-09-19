extends StaticBody3D
@onready var animation = $AnimatedSprite3D
@onready var boxes_falling = $"boxes falling"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func SeRompeCaja():
	animation.play("Dead")
	boxes_falling.play()
	$CollisionShape3D.disabled = true
