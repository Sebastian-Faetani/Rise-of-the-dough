extends StaticBody3D
@onready var dispenser_up: Sprite3D = $Dispenser_up
@onready var dispenser_down: Sprite3D = $Dispenser_down


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func SeRompeDispenser():
	dispenser_up.hide()
	dispenser_down.show()
	$CollisionShape3D.disabled = true
