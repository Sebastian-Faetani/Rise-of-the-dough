extends CharacterBody3D
class_name Player

signal healthChanged
signal staminaChanged
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# body functions
@onready var head = $Head
@onready var standing_collision = $Standing_collision
@onready var crouching_collision = $crouching_collision
@onready var head_bump_check = $head_bump_check
@onready var interact = $Head/SmoothCamera/interact
@onready var damage_animation_player = $DamageTexture/DamageAnimationPlayer
@onready var game_over_menu = $GameOverMenu
@onready var win_menu = $win_menu
@onready var open_door = $OpenDoor
@onready var foots = $FootSteps
@onready var stamina_bar: TextureProgressBar = $StaminaBar
@onready var stamina_time: Timer = $StaminaTime

#stamina
@export var max_player_stamina: int = 100
@onready var current_player_stamina: int = max_player_stamina
@onready var staminaTimer: float = 1.5
@onready var can_regen = false
var is_stamina_regen = false

#weapons
@onready var CLAP = preload("res://scenes/weapons/w_clap.tscn")
@onready var MOP = preload("res://scenes/weapons/w_mop.tscn")
@onready var POWERWASHER = preload("res://scenes/weapons/w_power_washer.tscn")

@onready var carried_guns = [CLAP]
var currentWeapon = 0


#player variables
@export var mouse_sens = 0.5
@export var current_speed = 5.0
@export var walk_speed = 8.0
@export var run_speed = 14.0
@export var crouch_speed = 5.0
var lerp_speed = 10.0
var direction = Vector3.ZERO
var crouch_depth = -0.5
var collectkey = false
var hasWon = false
var collectkeyfabrica = false
var collectkeyascensor = false
var attackBullet := 30.0

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
		if value < current_player_health:
			damage_animation_player.stop(false)
			damage_animation_player.play("take_damage")
		current_player_health = value
		healthChanged.emit()
		if current_player_health <= 0:
				dead = true
				game_over_menu.game_over()


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

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
	staminaChanged.emit()
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if hasWon == true:
		win_menu.victory_arrived()
	
	if Input.is_action_just_pressed("next_weapon"):
		currentWeapon += 1
		if currentWeapon > len(carried_guns) - 1:
			currentWeapon = 0
		change_gun(currentWeapon)
	elif Input.is_action_just_pressed("prev_weapon"):
		currentWeapon -= 1
		if currentWeapon < 0:
			currentWeapon = len(carried_guns) - 1
		change_gun(currentWeapon)
	
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
		
		if Input.is_action_pressed("run") and current_player_stamina >= 0:
			current_speed = run_speed
			can_regen = false
			current_player_stamina -= 1
			walking = false
			running = true
			crouching = false
		else:
			can_regen = true
			if current_player_stamina < max_player_stamina and can_regen == true:
				if is_stamina_regen == false:
					is_stamina_regen = true
					stamina_time.start(staminaTimer)
			if current_player_stamina == max_player_stamina:
				can_regen = false
			current_speed = walk_speed
			walking = true
			running = false
			crouching = false
	
	#Slide logic
	if sliding:
		slide_timer -= delta
		if slide_timer <= 0:
			sliding = false
	
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
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
		
	#picking up stuff
	
	if Input.is_action_just_pressed("interact"):
		var collider = interact.get_collider()
		if collider != null:
			if collider.is_in_group("interactuable"):
				open_door.play()
				collider.interact()
				
				
		if collider != null:
			if collider.is_in_group("interaction"):
				collectkey = true
				collider.collectkey()
	if Input.is_action_just_pressed("interact") and collectkey == true:
		var collider = interact.get_collider()
		if collider != null:
			if collider.is_in_group("exit"):
				collectkey = false
				open_door.play()
				collider.bye()
	if Input.is_action_just_pressed("interact"):
		var collider = interact.get_collider()
		if collider != null:
			if collider.is_in_group("object"):
				collider.objectCollected()
				curar()
				
	if Input.is_action_just_pressed("interact"):
		var collider = interact.get_collider()
		if collider != null:
			if collider.is_in_group("interaction2"):
				collectkeyfabrica = true
				collider.collectkeyFabrica()
	if Input.is_action_just_pressed("interact") and collectkeyfabrica == true:
		var collider = interact.get_collider()
		if collider != null:
			if collider.is_in_group("exit2"):
				collectkeyfabrica = false
				collider.bye2()
	if Input.is_action_just_pressed("interact"):
		var collider = interact.get_collider()
		if collider != null:
			if collider.is_in_group("interaction3"):
				collectkeyascensor = true
				collider.collectkeyAscensor()
	if Input.is_action_just_pressed("interact") and collectkeyascensor == true:
		var collider = interact.get_collider()
		if collider != null:
			if collider.is_in_group("salida3"):
				collider.bye3()
				collectkeyfabrica = false
	if velocity.x != 0 and is_on_floor():
		if !foots.playing:
			foots.play()
	elif foots.playing:
		foots.stop()

	move_and_slide()

func restart():
	get_tree().reload_current_scene()

func change_gun(gun):
	$Head/Weapon_handler.get_child(0).queue_free()
	var new_gun = carried_guns[gun].instantiate()
	$Head/Weapon_handler.add_child(new_gun)

func puerta_desbloqueada():
	pass


func _on_stamina_time_timeout() -> void:
	is_stamina_regen = false
	current_player_stamina = min(current_player_stamina + 25, max_player_stamina)

func curar():
	current_player_health += 25

func danio():
	current_player_health -= attackBullet
