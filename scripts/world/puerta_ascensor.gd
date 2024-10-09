extends StaticBody3D

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var sprite_3d_2: Sprite3D = $Sprite3D2
@onready var collision_shape_3d: CollisionShape3D = $Sprite3D/StaticBody3D/CollisionShape3D
@onready var collision_shape_3d2: CollisionShape3D = $Sprite3D2/StaticBody3D/CollisionShape3D

var elevDoor_tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func bye3():
	sprite_3d.hide()
	sprite_3d_2.hide()
	collision_shape_3d.disabled = true
	collision_shape_3d2.disabled = true

func closeDoor():
	sprite_3d.show()
	sprite_3d_2.show()
	collision_shape_3d.disabled = false
	collision_shape_3d2.disabled = false
