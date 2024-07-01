extends Node3D

@export var weapon_1 : Node3D
@export var weapon_2 : Node3D

func _ready() -> void:
	equip(weapon_1)


func equip(active_weapon: Node3D) -> void:
	for child in get_children():
		if child == active_weapon:
			child.visible = true
			child.set_process(true)
		else:
			child.visible = false
			child.set_process(false)
