extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gun_rays = $GunRays.get_children()
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var hit_punch = $"../../../HitPunch"

#@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
var player
var Att1Av = true
var Att2Av = false
@export var gun_damage = 10
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")

func check_hit():
	for ray in gun_rays:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("enemies"):
				ray.get_collider().DeathByMop(true)
				ray.get_collider().DeathByWater(false)
				ray.get_collider().DeathByKnife(false)
				ray.get_collider().enemyTakeDamage(gun_damage)
				
			elif ray.get_collider().is_in_group("bossEnemy"):
				ray.get_collider().DeathByMop(true)
				ray.get_collider().DeathByWater(false)
				ray.get_collider().DeathByKnife(false)
				ray.get_collider().enemyTakeDamage(gun_damage)

func _process(_delta):
	if Input.is_action_just_pressed("shoot") and can_shoot == true and player.current_player_stamina >= 0:
		if Att1Av == true:
			playback.travel("attack1")
		if Att2Av == true:
			playback.travel("attack2")
		hit_punch.play()
		can_shoot = false
		player.current_player_stamina -= 25

func move_to_attack2():
	Att1Av = false
	Att2Av = true
func move_to_attack3():
	Att2Av = false
	Att1Av = true
	
func shoot_anim_done():
	can_shoot = true
