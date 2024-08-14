extends OmniLight3D

func _ready():
 flash()

func flash():
 light_energy = randf()
 await get_tree().create_timer(0.5).timeout
 flash()
