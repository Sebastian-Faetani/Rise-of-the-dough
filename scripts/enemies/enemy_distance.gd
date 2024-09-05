extends CharacterBody3D
class_name EnemyDistance

# External variables
@export var speed = 9.0
@export var attack_range := 2.6
@export var max_hp = 500
@export var attack_damage := 20
@export var cooldown_time = 1.5
@export var aggro_range := 15.0
@export var range_shoot := 20.0
@export var bullet_speed := 10.0 # Nueva variable para la velocidad de la bala
var Bullet = preload("res://scenes/enemies/bullet_enemy.tscn")
# Declared variables
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var animated_sprite_3d = $AnimatedSprite3D
@onready var navigation_agent_3d = $NavigationAgent3D
@onready var attack_cooldown = $AttackCooldown
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var dead_mopa = $DeadMopa
@onready var dead_hidro = $DeadHidro
@onready var dead_knife = $DeadKnife

@onready var gun_rays = $GunRays.get_children()
@onready var bullet_position = $bullet_position




@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

# Internal variables
var distancetoshoot
var player
var distance
var see_range := 30.0
var can_move := true
var can_attack := true
var enemyDead := false
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
			playback.stop()
			if mopDeath == true:
				playback.travel("mopDeath")
				dead_mopa.play()
			elif waterDeath == true:
				playback.travel("waterDeath")
				dead_hidro.play()
			elif knifeDeath == true:
				playback.travel("knifeDeath")
				dead_hidro.play()
			$CollisionShape3D.disabled = true

enum EnemyStates {
	Idle,
	Death,
	Throwing
}

var initial_state = EnemyStates.Idle
var current_state = initial_state

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	var next_position = navigation_agent_3d.get_next_path_position()
	distance = global_position.distance_to(player.global_position)
	distancetoshoot = global_position.distance_to(player.global_position)
	
	match current_state:
		EnemyStates.Idle:
			can_move = true
			if distance < aggro_range:
				current_state = EnemyStates.Idle
		
			chase()
			if distance > see_range:
				current_state = EnemyStates.Idle
			elif distance <= range_shoot and can_attack:
				current_state = EnemyStates.Throwing
		EnemyStates.Throwing:
			if can_attack:
				can_attack = false
				playback.travel("attack")
				attack_cooldown.start(cooldown_time)
				current_state = EnemyStates.Idle
				#shoot()
		EnemyStates.Death:
			pass

	if enemyDead:
		return

	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var direction = global_position.direction_to(next_position)
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	if distancetoshoot <= range_shoot and can_attack:
		pass
		
	move_and_slide()

func attack() -> void:
	if distance <= attack_range:
		player.current_player_health -= attack_damage

func chase():
	navigation_agent_3d.target_position = player.global_position

func enemyTakeDamageWithMopa(dmg_amount):
	playback.travel("hit-mopa")
	current_state = EnemyStates.Idle
	print(dmg_amount)
	hp -= dmg_amount

func enemyTakeDamageWithHidro(dmg_amount):
	playback.travel("hit-hidro")
	current_state = EnemyStates.Idle
	print(dmg_amount)
	hp -= dmg_amount

func enemyTakeDamageWithKnife(dmg_amount):
	playback.travel("hitKnife")
	current_state = EnemyStates.Idle
	print(dmg_amount)
	hp -= dmg_amount

func enemyTakeDamage(dmg_amount):
	current_state = EnemyStates.Idle
	print(dmg_amount)
	hp -= dmg_amount

func DeathByMop(bool):
	mopDeath = bool

func DeathByWater(bool):
	waterDeath = bool

func DeathByKnife(bool):
	knifeDeath = true
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
