extends RigidBody3D

@onready var gun_rays = $GunRays.get_children()
@export var gun_damage = 10

func _ready():
	pass # Replace with function body.

func check_hit():
	for ray in gun_rays:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("enemies"):
				ray.get_collider().DeathByMop(false)
				ray.get_collider().DeathByWater(true)
				ray.get_collider().DeathByKnife(false)
				ray.get_collider().enemyTakeDamageWithHidro(gun_damage)
				queue_free()
			elif ray.get_collider().is_in_group("bossEnemy"):
				ray.get_collider().DeathByMop(false)
				ray.get_collider().DeathByWater(true)
				ray.get_collider().DeathByKnife(false)
				ray.get_collider().enemyTakeDamage(gun_damage)
				queue_free()
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	check_hit()
	
