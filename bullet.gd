extends Area2D


var targetvector:Vector2 = Vector2.ZERO
var speed = 150

func _ready():
	set_process(true)
	print(targetvector)


func _process(delta):
	position += speed*delta*targetvector


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
