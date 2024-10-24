extends Control
@onready var secret_text: Label = $SecretText
@onready var secret_image: TextureRect = $SecretImage
var truckSecret = Image.load_from_file("res://assets/enviroment/Dispenser.png")

# Called when the node enters the scene tree for the first time.
func secretCamion():
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "OH NO, SON MIS ULTIMOS MINUTOS VIDA, DILE A MI ESPOSA QUE LA AMO Y LA AMARÉ MUCHO"
	secret_image.texture = ImageTexture.create_from_image(truckSecret)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().paused = false
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
