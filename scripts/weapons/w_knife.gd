extends Node3D
@onready var gun_sprite = $AnimationPlayer
@onready var gun_rays =$GunRays.get_children()
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var hit_knife = $"../../../HitKnife"

@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
var player
var lona
var Att1Av = true
var Att2Av = false
var Att3Av = false

@export var gun_damage = 20
@export var power_damage = 40
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")

func check_hit():
	for ray in gun_rays:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("enemies"):
				ray.get_collider().DeathByMop(false)
				ray.get_collider().DeathByWater(false)
				ray.get_collider().DeathByKnife(true)
				ray.get_collider().enemyTakeDamageWithKnife(gun_damage)
				
			elif ray.get_collider().is_in_group("bossEnemy"):
				ray.get_collider().DeathByMop(false)
				ray.get_collider().DeathByWater(false)
				ray.get_collider().DeathByKnife(true)
				ray.get_collider().enemyTakeDamageWithKnife(gun_damage)
			elif ray.get_collider().is_in_group("destructiblelona"):
				ray.get_collider().seRompeLona()
			elif ray.get_collider().is_in_group("destructiblemasa1"):
				ray.get_collider().MensajeMasa1()
			elif ray.get_collider().is_in_group("destructiblemasa2"):
				ray.get_collider().MensajeMasa2()
			elif ray.get_collider().is_in_group("destructiblemasa3"):
				ray.get_collider().MensajeMasa3()

func power_hit():
	for ray in gun_rays:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("enemies"):
				ray.get_collider().DeathByMop(false)
				ray.get_collider().DeathByWater(false)
				ray.get_collider().DeathByKnife(true)
				ray.get_collider().enemyTakeDamageWithKnife(power_damage)
				
			elif ray.get_collider().is_in_group("bossEnemy"):
				ray.get_collider().DeathByMop(false)
				ray.get_collider().DeathByWater(false)
				ray.get_collider().DeathByKnife(true)
				ray.get_collider().enemyTakeDamageWithKnife(power_damage)
			

func _process(_delta):
	if Input.is_action_just_pressed("shoot") and can_shoot == true and player.current_player_stamina >= 0:
		if Att1Av == true:
			playback.travel("attack1")
		if Att2Av == true:
			playback.travel("attack2")
		if Att3Av == true:
			playback.travel("attack3")
		hit_knife.play()
		can_shoot = false
		player.current_player_stamina -= 25

func move_to_attack2():
	Att1Av = false
	Att2Av = true

func move_to_attack3():
	Att2Av = false
	Att3Av = true

func move_to_attack1():
	Att3Av = false
	Att1Av = true

func shoot_anim_done():
	can_shoot = true
