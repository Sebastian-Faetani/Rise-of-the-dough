extends Control
@onready var secret_text: Label = $SecretText
@onready var secret_image: TextureRect = $BoxContainer/SecretImage
@onready var celu: Sprite2D = $Celu
@onready var notebook: Sprite2D = $Notebook
@onready var hidro_nota: Sprite2D = $HidroNota
@onready var maicena: Sprite2D = $Maicena
@onready var se_busca: Sprite2D = $SeBusca
@onready var tube_label: Sprite2D = $TubeLabel
@onready var tube_prota: Sprite2D = $TubeProta

var secretLeido = false
@onready var timer: Timer = $Timer

var player
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func secretCamion():
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	celu.show()
	secret_text.text = "María perdón por irme sin avisar, me llamaron para que haga un envió de emergencia, y con el bebe en camino necesitamos toda la plata que consigamos, en unas horas vuelvo, te amo"
	
func SecretHidro():
	visible = true
	hidro_nota.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "La hidro no está funcionando bien, dispara a chorros. Necesitamos una nueva. - El conserje"

func SecretOffice():
	visible = true
	notebook.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "Estimado:
Le informo que los experimentos están avanzando satisfactoriamente conforme a lo previsto. Sin embargo, hemos observado algunos comportamientos anómalos en MM que podrían requerir una revisión adicional.
Atentamente,
Carlos Juan
Gerente
"

func SecretKitchen():
	visible = true
	maicena.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "Oh dios, no pensé que este día llegaría tan rápido, MM actuó antes de lo pensado, pensé que era un chiste cuando me dijo que se iba a escapar, no se ni siquiera por que estoy escribiendo esto, seguramente es porque sé que no voy a lograr escapar, así que para irme sin arrepentimientos, en el subsuelo están.... "

func SecretAscensor():
	visible = true
	se_busca.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "persona desaparecida
	Martin Sanderson 
	Cualquier información que tengan. 
	Contactar al número 426-6X6"

func SecretProta():
	visible = true
	tube_prota.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "Nombre: Fred P. Pancracio 
	Estado: En recolección
	Resultado: N/A"

func SecretTubeMissing():
	visible = true
	tube_label.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "Nombre: Martin Sanderson 
	Estado: Completado
	Resultado: Satisfactorio"

func SecretTubeCamionero():
	visible = true
	tube_label.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "Nombre:  German Maldin
	Estado: En progreso
	Resultado: Transformación parcial"

func SecretTubeMasaEgg():
	visible = true
	tube_label.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "Nombre:  ???
	Estado: Completado
	Resultado: Catastrofico
	Nota Extra: No intentar clonar a MM otra vez"

func SecretTube2():
	visible = true
	tube_label.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "Nombre:  Rodolfo Saum
	Estado: Completado
	Resultado: Satisfactorio"
	
func SecretTube3():
	visible = true
	tube_label.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	secret_text.text = "Nombre:  Marcos Lyra
	Estado: Completado
	Resultado: Satisfactorio"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	if secretLeido == false:
		get_tree().paused = false
		visible = false
		celu.hide()
		notebook.hide()
		hidro_nota.hide()
		maicena.hide()
		se_busca.hide()
		tube_label.hide()
		tube_prota.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		visible = false
		notebook.hide()
		get_tree().paused = false
		player.text_background.show()
		timer.start()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		player.lore_message.show()
		player.lore_message.text = "¿De que experimentos estarán hablando? ¿En una panificadora?"
		secretLeido = false


func _on_timer_timeout() -> void:
	player.text_background.hide()
	player.lore_message.hide()
	
