extends Node3D
@onready var pause_menu_sandbox = $Pause_menu_sandbox
var paused_sand = false
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
	if paused_sand:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		pause_menu_sandbox.hide()
		get_tree().paused= false
	else:
		
		pause_menu_sandbox.show()
		get_tree().paused = true
	paused_sand = !paused_sand

