extends StaticBody3D
@onready var animation = $AnimatedSprite3D
@onready var boxes_falling = $"boxes falling"
@onready var cajas_up: Sprite3D = $CajasUp
@onready var cajas_down: Sprite3D = $CajasDown


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func SeRompeCaja():
	cajas_up.hide()
	cajas_down.show()
	boxes_falling.play()
	$CollisionShape3D.disabled = true
