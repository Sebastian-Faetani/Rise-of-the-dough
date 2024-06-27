extends CharacterBody3D
class_name Player

signal healthChanged
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# body functions
@onready var head = $Head
@onready var standing_collision = $Standing_collision
@onready var crouching_collision = $crouching_collision
@onready var head_bump_check = $head_bump_check


#player variables
@export var mouse_sens = 0.5
@export var current_speed = 5.0
@export var walk_speed = 5.0
@export var run_speed = 10.0
@export var crouch_speed = 3.0
var lerp_speed = 10.0
var direction = Vector3.ZERO
var crouch_depth = -0.5

#slide variables
var slide_timer = 0.0
var slider_timer_max = 1.0
var slide_vector = Vector2.ZERO
var slide_speed = 13.0

#States 
var walking = false
var running = false
var crouching = false
var sliding = false

#Life and death
var dead = false
@export var max_player_health = 100
@onready var current_player_health: int = max_player_health:
	set(value):
		current_player_health = value
		healthChanged.emit()
		if current_player_health <= 0:
				dead = true
				$UI/DeathScreen.show()
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$UI/DeathScreen/Panel/Button.button_up.connect(restart)

func _input(event: InputEvent):
	if dead:
		return
	
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-50), deg_to_rad(89))

func _process(_delta):
	if dead:
		return
	healthChanged.emit()
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func _physics_process(delta):
	if dead:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_foward", "move_backwards")
	
	if Input.is_action_pressed("crouch") || sliding:
		current_speed = crouch_speed
		head.position.y = lerp(head.position.y, 0.5 + crouch_depth, delta * lerp_speed)
		
		standing_collision.disabled = true
		crouching_collision.disabled = false
		
		#slide begin logic
		if running && input_dir != Vector2.ZERO:
			sliding = true
			slide_timer = slider_timer_max
			slide_vector = input_dir
		
		walking = false
		running = false
		crouching = true
	
	elif !head_bump_check.is_colliding():
		standing_collision.disabled = false
		crouching_collision.disabled = true
		
		head.position.y = lerp(head.position.y, 0.5, delta * lerp_speed)
		
		if Input.is_action_pressed("run"):
			current_speed = run_speed
			walking = false
			running = true
			crouching = false
		else:
			current_speed = walk_speed
			walking = true
			running = false
			crouching = false
	
	#Slide logic
	if sliding:
		slide_timer -= delta
		if slide_timer <= 0:
			sliding = false
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if sliding:
		direction = (transform.basis * Vector3(slide_vector.x, 0, slide_vector.y)).normalized()
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
		
		if sliding:
			velocity.x = direction.x * slide_timer * slide_speed
			velocity.z = direction.z * slide_timer * slide_speed
		
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
	


func restart():
	get_tree().reload_current_scene()
