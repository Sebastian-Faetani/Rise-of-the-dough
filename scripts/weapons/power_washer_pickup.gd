extends Area3D

@onready var POWERWASHER = preload("res://scenes/weapons/w_power_washer.tscn")

func _on_body_entered(body):
	if body.is_in_group("player"):
		if !body.carried_guns.has(POWERWASHER):
			body.carried_guns.append(POWERWASHER)
			$Sprite3D.hide()
			body.currentWeapon += 1
			body.change_gun(body.currentWeapon)
			$CollisionShape3D.disabled = true
		else:
			pass
