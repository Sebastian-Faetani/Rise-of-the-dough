extends StaticBody3D
@onready var animation: = $animations
@onready var se_rompio = $SeRompio


func seRompe():
	animation.play("Dead")
	se_rompio.play()
	$CollisionShape3D.disabled = true
