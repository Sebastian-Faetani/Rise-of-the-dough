extends Node3D
@onready var pause_menu = $Pause_menu
@onready var gameplay_music = $Gameplay_Music
@onready var clocktick = $TicTac
@onready var alarm_sound = $"alarm sound"


var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#gameplay_music.play()
	alarm_sound.play()
	clocktick.play()
	Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	#gameplay_music.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		PauseMenu()
func PauseMenu():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if paused:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		pause_menu.hide()
		get_tree().paused = false
	else:
		
		pause_menu.show()
		get_tree().paused = true
	paused = !paused
