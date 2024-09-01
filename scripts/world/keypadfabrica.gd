extends StaticBody3D
var exit2

func _ready():
		exit2 = get_tree().get_first_node_in_group("salida")

func _process(_delta):
	pass
func bye2():
	queue_free()
	exit2.bye2()
