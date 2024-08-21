extends Node3D

@onready var gun_sprite = $AnimationPlayer
@onready var gun_rays = $GunRays.get_children()
@onready var shoot_hidro =  $"../../../ShootHidro"
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@export var gun_damage = 10
var can_shoot = true

var Bullet = preload("res://scenes/weapons/bullet.tscn")
@export var bullet_speed: int = 40
@onready var bullet_position: Marker3D = $bullet_position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#func check_hit():
	#for ray in gun_rays:
		#if ray.is_colliding():
			#if ray.get_collider().is_in_group("enemies"):
				#ray.get_collider().DeathByMop(false)
				#ray.get_collider().DeathByWater(true)
				#ray.get_collider().enemyTakeDamage(gun_damage)
			#elif ray.get_collider().is_in_group("bossEnemy"):
				#ray.get_collider().DeathByMop(false)
				#ray.get_collider().DeathByWater(true)
				#ray.get_collider().enemyTakeDamage(gun_damage)

func _process(_delta):
	if Input.is_action_just_pressed("shoot") and can_shoot == true:
		var bullet_direction = - bullet_position.global_transform.basis.z.normalized()
		playback.travel("attack")
		shoot_hidro.play()
		shoot(bullet_direction)
		can_shoot = false

func shoot_anim_done():
	can_shoot = true

func shoot(Dir: Vector3):
	var W = get_tree().get_root()
	var R = Bullet.instantiate()
	W.add_child(R)
	R.set_global_transform(bullet_position.get_global_transform())
	R.set_linear_velocity(Dir*bullet_speed)
