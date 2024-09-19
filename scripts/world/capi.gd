extends StaticBody3D

@onready var animation = $AnimatedSprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func SeRompeCapi():
	animation.play("dead")
	$CollisionShape3D.disabled = true
