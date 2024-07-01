extends Node3D

@onready var gun_sprite = $CanvasLayer/Control/GunAnim
@onready var gun_rays = $GunRays.get_children()
@onready var hit_mopa =  $"../../../HitMopa"
@export var gun_damage = 30
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	gun_sprite.animation_finished.connect(shoot_anim_done)

func check_hit():
	for ray in gun_rays:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("enemies"):
				ray.get_collider().DeathByMop(true)
				ray.get_collider().DeathByWater(false)
				ray.get_collider().enemyTakeDamage(gun_damage)
				
			elif ray.get_collider().is_in_group("bossEnemy"):
				ray.get_collider().DeathByMop(true)
				ray.get_collider().DeathByWater(false)
				ray.get_collider().enemyTakeDamage(gun_damage)

func _process(_delta):
	if Input.is_action_just_pressed("shoot") and can_shoot == true:
		gun_sprite.play("attack")
		check_hit()
		hit_mopa.play()
		can_shoot = false

func shoot_anim_done():
	can_shoot = true
