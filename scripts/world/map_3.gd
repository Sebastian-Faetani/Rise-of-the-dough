extends Node3D

@onready var mother_door: MeshInstance3D = $NavigationRegion3D/Lvl3/MotherDoor
@onready var mother_door_2: MeshInstance3D = $NavigationRegion3D/Lvl3/MotherDoor2




func motherDoorOpen():
	var doorTween = get_tree().create_tween().set_parallel()
	doorTween.tween_property(mother_door, "rotation:y", 2, 1).set_delay(2)
	doorTween.set_parallel()
	doorTween.tween_property(mother_door_2, "rotation:y", -2, 1).set_delay(2)

func _on_ending_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		MusicMenu.stop_music()
		get_tree().change_scene_to_file("res://scenes/UI/ending.tscn")
		$Ending/CollisionShape3D.disabled = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
