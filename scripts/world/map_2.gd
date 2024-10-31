extends Node3D
var level3 = preload("res://scenes/maps/Map3.tscn")
var mapHandler = preload("res://scenes/maps/Map1.tscn")

@onready var timer: Timer = $MapHandler2/lvl2/Enemies/EnemySpawner/Timer
@onready var boss_timer: Timer = $MapHandler2/lvl2/Enemies/EnemySpawner/BossTimer
var player
var ascensorDoor
@onready var gameplay_music = $MapHandler2/lvl2/GameplayMusic
@onready var enemy_begginer: Area3D = $MapHandler2/lvl2/EnemyBegginer
@onready var lvl_2: Node3D = $MapHandler2/lvl2
@onready var lift: MeshInstance3D = $MapHandler2/lvl2/NavigationRegion3D/NavigationRegion3D/Lvl2/Lift
@onready var puerta_ascensor: StaticBody3D = $MapHandler2/lvl2/NavigationRegion3D/NavigationRegion3D/Doors/puertaAscensor


func _ready() -> void:
	gameplay_music.play()
	player = get_tree().get_first_node_in_group("player")
	ascensorDoor = get_tree().get_first_node_in_group("salidaAscensor")

func lower_elevator() -> void:
	var elev_tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	elev_tween.tween_property(lift, "position:y", -20, 7).set_delay(1)
	elev_tween.set_parallel()
	elev_tween.tween_property(puerta_ascensor, "position:y", -20, 7.5).set_delay(1)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$MapHandler2/lvl2/EnemyBegginer/CollisionShape3D.disabled = true
		timer.start()
		boss_timer.start()
		player.text_background.show()
		player.lore_message.show()
		player.lore_message.text= "Que ha sido eso, creo que se ha activado algo"
		

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.lore_message.hide()
		player.text_background.hide()
		enemy_begginer.queue_free()
		


func _on_lvl_3_loader_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		var  Level3 = level3.instantiate()
		$MapHandler2.add_child(Level3)
		lvl_2.queue_free()


func _on_bajar_ascensor_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		ascensorDoor.closeDoor()
		lower_elevator()
