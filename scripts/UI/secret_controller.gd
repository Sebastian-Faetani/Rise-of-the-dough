extends Control
@onready var secret_text: Label = $SecretText
@onready var secret_image: TextureRect = $SecretImage
var truckSecret = Image.load_from_file("res://assets/placeholders/CeluPlace.png")
var hidrosecret = Image.load_from_file("res://assets/placeholders/post it place.png")
var officesecret = Image.load_from_file("res://assets/placeholders/pcPlace.png")
var secretLeido = false
@onready var timer: Timer = $Timer

var player
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func secretCamion():
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "María perdón por irme sin avisar, me llamaron para que haga un envió de emergencia, y con el bebe en camino necesitamos toda la plata que consigamos, en unas horas vuelvo, te amo"
	secret_image.texture = ImageTexture.create_from_image(truckSecret)
func SecretHidro():
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "La hidro no está funcionando bien, dispara a chorros. Necesitamos una nueva. - El conserje"
	secret_image.texture = ImageTexture.create_from_image(hidrosecret)

func SecretOffice():
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "Estimado:
Le informo que los experimentos están avanzando satisfactoriamente conforme a lo previsto. Sin embargo, hemos observado algunos comportamientos anómalos en MM que podrían requerir una revisión adicional.
Atentamente,
Carlos Juan
Gerente
"
	secret_image.texture = ImageTexture.create_from_image(officesecret)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	if secretLeido == false:
		get_tree().paused = false
		visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		visible = false
		get_tree().paused = false
		player.text_background.show()
		timer.start()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		player.lore_message.show()
		player.lore_message.text = "¿De que experimentos estarán hablando? ¿En una panificadora?"
		secretLeido = false


func _on_timer_timeout() -> void:
	player.lore_message.hide()
	player.text_background.hide()
