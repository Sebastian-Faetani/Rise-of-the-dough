extends CenterContainer

@export var DOT_RADIUS : float = 2.0
@export var DOT_COLOR : Color = Color.WHITE

func _ready():
	queue_redraw()

func _process(delta):
	pass

func _draw():
	draw_circle(Vector2(0,0), 3.0, Color.BLACK)
	draw_circle(Vector2(0,0), DOT_RADIUS, DOT_COLOR)
