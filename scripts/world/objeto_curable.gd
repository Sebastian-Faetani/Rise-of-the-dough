extends StaticBody3D

func _ready() -> void:
	pass

func objectCollected():
	queue_free()
