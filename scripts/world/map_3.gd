extends Node3D

@onready var mother_door: MeshInstance3D = $NavigationRegion3D/Lvl3/MotherDoor
@onready var mother_door_2: MeshInstance3D = $NavigationRegion3D/Lvl3/MotherDoor2




func motherDoorOpen():
	var doorTween = get_tree().create_tween().set_parallel()
	doorTween.tween_property(mother_door, "rotation:y", 155, 10).set_delay(2)
	doorTween.set_parallel()
	doorTween.tween_property(mother_door_2, "rotation:y", -155, 10).set_delay(2)
	
