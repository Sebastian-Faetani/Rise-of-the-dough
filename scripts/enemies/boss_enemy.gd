extends CharacterBody3D
class_name Boss_Enemy

#external variables
@export var speed = 5
@export var attack_range := 6.0
@export var max_hp = 250
@export var attack_damage := 35.0
@export var range_shoot := 60.0
@export var cooldown_time = 2
@export var aggro_range := 30.0
var Bullet = preload("res://scenes/enemies/bullet_enemyBoss.tscn")
var bullet_speed = 10
#Declared variables
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var animated_sprite_3d = $AnimatedSprite3D
@onready var navigation_agent_3d = $NavigationAgent3D
@onready var attack_cooldown = $AttackCooldown
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var dead_mopa = $DeadMopa
@onready var dead_hidro = $DeadHidro
@onready var dead_knife = $DeadKnife
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var bullet_position: Marker3D = $bullet_position
@onready var level3 = preload("res://scenes/maps/Map3.tscn")
@onready var boss_roar: AudioStreamPlayer = $BossRoar
@onready var boss_slice: AudioStreamPlayer = $BossSlice
@onready var boss_death: AudioStreamPlayer = $BossDeath
@onready var boss_fall: AudioStreamPlayer = $BossFall

var enemyCanShoot = true
var player
var distance
var see_range := 100.0
var can_move := true
var can_attack := true
@export var enemyDead := false
var mopDeath = false
var waterDeath = false
var knifeDeath = false
var hp: int = max_hp:
	set(value):
		hp = value
		if hp <= 0:
			enemyDead = true
			can_move = false
			attack_cooldown.stop()
			current_state = EnemyStates.Death
			level3.motherDoorOpen()
			playback.stop()
			if mopDeath == true:
				boss_death.play()
				playback.travel("mopDeath")
				dead_mopa.play()
			elif waterDeath == true:
				boss_death.play()
				playback.travel("waterDeath")
				dead_hidro.play()
			elif knifeDeath == true:
				boss_death.play()
				playback.travel("knifeDeath")
				dead_knife.play()
			$CollisionShape3D.disabled = true


enum EnemyStates {
	Idle,
	Chasing,
	Attacking,
	Throwing,
	Death
}

var initial_state = EnemyStates.Idle
var current_state = initial_state

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	level3  = get_tree().get_first_node_in_group("Map3")

func _process(delta: float) -> void:
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)

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
			elif is_between(distance, attack_range, range_shoot) and can_attack == true:
				current_state = EnemyStates.Throwing
		EnemyStates.Attacking:
			can_attack = false
			playback.travel("attack")
			attack_cooldown.start(cooldown_time)
			if can_attack == false:
				current_state = EnemyStates.Chasing
		EnemyStates.Throwing:
			can_attack = false
			playback.travel("attack_distance")
			attack_cooldown.start(cooldown_time)
			
			if can_attack == false:
				current_state = EnemyStates.Idle
		
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


func enemyTakeDamageWithMopa(dmg_amount):
	playback.travel("hit-mopa")
	current_state = EnemyStates.Chasing
	print(dmg_amount)
	hp -= dmg_amount
func enemyTakeDamageWithHidro(gun_damage):
	playback.travel("hit-hidro")
	current_state = EnemyStates.Chasing
	print(gun_damage)
	hp -= gun_damage
func enemyTakeDamage(dmg_amount):
	current_state = EnemyStates.Chasing
	print(dmg_amount)
	hp -= dmg_amount
	
func enemyTakeDamageWithKnife(gun_damage):
	playback.travel("hitKnife")
	current_state = EnemyStates.Chasing
	print(gun_damage)
	hp -= gun_damage
func is_between(value, min_value, max_value):
	return value > min_value and value <= max_value

func BossFallSound():
	boss_fall.play()

func DeathByMop(bool):
	mopDeath = bool

func DeathByWater(bool):
	waterDeath = bool

func DeathByKnife(bool):
	knifeDeath = bool
	
func fast():
	speed = 10.0
	
func slowdown():
	speed = 0.0

func speedup():
	speed = 5.0

func bossRoar():
	boss_roar.play()

func bossSlice():
	boss_slice.play()

func _on_attack_cooldown_timeout():
	can_attack = true

func shoot() -> void:
		if Bullet:
			var bullet = Bullet.instantiate()
			var W = get_tree().get_root()
			W.add_child(bullet)
			bullet.global_position = global_position
			var direction = (player.global_position - global_position).normalized()
			if bullet.has_method("set_direction"):
				bullet.set_direction(direction * bullet_speed)
		else:
			print("Bullet scene does not have set_direction method. Ensure it's implemented in the Bullet scene script.")
