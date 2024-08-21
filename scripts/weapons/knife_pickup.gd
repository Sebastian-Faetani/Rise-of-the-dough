extends Area3D

const KNIFE = preload("res://scenes/weapons/w_knife.tscn")
func _on_body_entered(body):
	if body.is_in_group("player"):
		if !body.carried_guns.has(KNIFE):
			body.carried_guns.append(KNIFE)
			$Sprite3D.hide()
			body.currentWeapon += 1
			body.change_gun(body.currentWeapon)
			$CollisionShape3D.disabled = true
		else:
			pass
