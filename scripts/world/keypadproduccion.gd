extends StaticBody3D
var exit3

func _ready():
		exit3 = get_tree().get_first_node_in_group("salidaAscensor")

func _process(_delta):
	pass
func bye3():
	queue_free()
	exit3.bye3()
