extends CharacterBody3D
class_name Enemy

#external variables
@export var speed = 9.0
@export var attack_range := 2.5
@export var max_hp = 40
@export var attack_damage := 20
@export var cooldown_time = 1.5
@export var aggro_range := 15.0

#Declared variables
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var animated_sprite_3d = $AnimatedSprite3D
@onready var navigation_agent_3d = $NavigationAgent3D
@onready var attack_cooldown = $AttackCooldown
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var dead_mopa = $DeadMopa
@onready var dead_hidro = $DeadHidro

@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

#internal variables
var player
var distance
var see_range := 30.0
var can_move := true
var can_attack := true
var enemyDead := false
var mopDeath = false
var waterDeath = false
var hp: int = max_hp:
	set(value):
		hp = value
		if hp <= 0:
			enemyDead = true
			can_move = false
			attack_cooldown.stop()
			current_state = EnemyStates.Death
			playback.stop()
			if mopDeath == true:
				playback.travel("mopDeath")
				dead_mopa.play()
			elif waterDeath == true:
				playback.travel("waterDeath")
				dead_hidro.play()
			$CollisionShape3D.disabled = true


enum EnemyStates {
	Idle,
	Chasing,
	Attacking,
	Death
}

var initial_state = EnemyStates.Idle
var current_state = initial_state

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	var next_position = navigation_agent_3d.get_next_path_position()
	distance = global_position.distance_to(player.global_position)
	
	
	match current_state:
		EnemyStates.Idle:
			can_move = true
			if distance < aggro_range:
				current_state = EnemyStates.Chasing
		EnemyStates.Chasing:
			#if can_move == true:
			chase()
			if distance > see_range:
				current_state = EnemyStates.Idle
			elif distance <= attack_range and can_attack == true:
				current_state = EnemyStates.Attacking
		EnemyStates.Attacking:
			can_attack = false
			playback.travel("attack")
			attack_cooldown.start(cooldown_time)
			if can_attack == false:
				current_state = EnemyStates.Chasing
		EnemyStates.Death:
			pass

	if enemyDead == true:
		return
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	var direction = global_position.direction_to(next_position)
	if direction:
		velocity.x = direction.x * speed
	
		velocity.z = direction.z * speed
	
	else:
		velocity.x = move_toward(velocity.x, 0, speed
	)
		velocity.z = move_toward(velocity.z, 0, speed
	)

	move_and_slide()

func attack() -> void:
	if distance <= attack_range:
		#print("damage")
		player.current_player_health -= attack_damage

func chase():
	navigation_agent_3d.target_position = player.global_position


func enemyTakeDamage(dmg_amount):
	current_state = EnemyStates.Chasing
	print(dmg_amount)
	hp -= dmg_amount

func DeathByMop(bool):
	mopDeath = bool

func DeathByWater(bool):
	waterDeath = bool

func _on_attack_cooldown_timeout():
	can_attack = true
