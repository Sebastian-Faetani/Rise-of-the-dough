extends Area3D

@onready var MOP = preload("res://scenes/weapons/w_mop.tscn")

func _on_body_entered(body):
	if body.is_in_group("player"):
		if !body.carried_guns.has(MOP):
			body.carried_guns.append(MOP)
			$Sprite3D.hide()
			body.currentWeapon += 1
			body.change_gun(body.currentWeapon)
			$CollisionShape3D.disabled = true
		else:
			pass
