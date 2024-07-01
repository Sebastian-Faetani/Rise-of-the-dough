extends Node3D
@export var isLocked = false


func _ready():
	pass

func interact():
	if isLocked == false:
		print("puerta abierta")
		queue_free()


