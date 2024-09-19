extends StaticBody3D

@onready var animation = $AnimatedSprite3D

func _ready() -> void:
	pass # Replace with function body.
func SeRompeMasa2():
	animation.play("dead")
	$CollisionShape3D.disabled = true
