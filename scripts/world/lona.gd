extends StaticBody3D
@onready var animation: = $animations


func seRompe():
	animation.play("Dead")
	$CollisionShape3D.disabled = true
