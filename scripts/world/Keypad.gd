extends StaticBody3D
var exit

func _ready():
		exit = get_tree().get_first_node_in_group("exit")

func _process(_delta):
	pass
func bye():
	queue_free()
	exit.bye()
