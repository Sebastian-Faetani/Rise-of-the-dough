extends Node3D
@onready var Pause_Menu = $PauseMenu
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		PauseMenu()
func PauseMenu():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if paused:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		Pause_Menu.hide()
		get_tree().paused = false
	else:
		
		Pause_Menu.show()
		get_tree().paused = true
	paused = !paused
