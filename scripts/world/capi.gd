extends StaticBody3D

@onready var capi_vivo: Sprite3D = $CapiVivo
@onready var capi_muerto: Sprite3D = $CapiMuerto


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func SeRompeCapi():
	capi_vivo.hide()
	capi_muerto.show()
	$CollisionShape3D.disabled = true
