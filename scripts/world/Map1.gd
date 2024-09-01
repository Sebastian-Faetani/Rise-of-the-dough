extends Node3D
@onready var pause_menu = $Pause_menu
@onready var gameplay_music = $Gameplay_Music
@onready var clocktick = $Maps/Level1/TicTac
@onready var alarm_sound = $"Maps/Level1/alarm sound"
@onready var level_1: Node3D = $Maps/Level1
@onready var level_2: Node3D = $Maps/Level2
@onready var load_trigger: Area3D = $Maps/Level1/LoadTrigger


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


func _on_load_trigger_body_entered(body: Node3D) -> void:
	level_2.show()
	
	level_1.queue_free()
