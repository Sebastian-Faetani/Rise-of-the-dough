extends StaticBody3D

@onready var animation = $AnimatedSprite3D
@onready var hide_text: Timer = $hide_text
@onready var bullet_detector: Area3D = $BulletDetector


var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
func SeRompeMasa2():
	animation.play("dead")
	$CollisionShape3D.disabled = true
	$BulletDetector/AreaCol.disabled = true
	bullet_detector.queue_free()
	
func MensajeMasa2():
	player.lore_message.show()
	player.lore_message.text = "Esto sería más facil con un poco de agua"
	hide_text.start()

func _on_hide_text_timeout() -> void:
	player.lore_message.hide()


func _on_bullet_detector_body_entered(body: Node3D) -> void:
	if body.is_in_group("bullet"):
		SeRompeMasa2()
