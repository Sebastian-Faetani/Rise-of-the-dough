extends Node3D
var level2 = preload("res://scenes/maps/Map2.tscn")


@onready var pause_menu = $Pause_menu
@onready var gameplay_music = $Gameplay_Music
@onready var clocktick = $Maps/Level1/TicTac
@onready var alarm_sound = $"Maps/Level1/alarm sound"
@onready var level_1: Node3D = $Maps/Level1
@onready var level_2_transition: VideoStreamPlayer = $level2Transition
@onready var skip_lvl_2: Button = $SkipLvl2

@onready var load_trigger: Area3D = $Maps/Level1/LoadTrigger


var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#gameplay_music.play()
	alarm_sound.play()
	clocktick.play()
	gameplay_music.play()
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


func _on_load_trigger_body_entered(body) -> void:
	level_2_transition.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	skip_lvl_2.show()
	level_2_transition.play()
	var  Level2 = level2.instantiate()
	$Maps.add_child(Level2)
	gameplay_music.stop()
	level_1.queue_free()


func _on_skip_lvl_2_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	skip_lvl_2.hide()
	level_2_transition.stop()
	level_2_transition.hide()


func _on_level_2_transition_finished() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	skip_lvl_2.hide()
	level_2_transition.stop()
	level_2_transition.hide()
