extends RigidBody2D


onready var scoremanager = preload("res://highscore_manager.tres")

var speed = 100
var startposition:Vector2

signal score_points

func _ready():
	set_physics_process(false)
	startposition = position
	connect("score_points", scoremanager, "increase_current_highscore")


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("score_points", 5)
	queue_free()



func _on_VisibilityNotifier2D_screen_entered():
	
	set_physics_process(true)
	set_linear_velocity(Vector2.RIGHT * speed )
	$AnimationPlayer.play("moving")

	
func _physics_process(delta):
	print(position.x, linear_velocity)
	if position.x == startposition.x + 30:
		set_linear_velocity(Vector2.RIGHT * speed )#* delta)
#		linear_velocity = Vector2.RIGHT * speed * delta
		$Sprite.flip_h = true
	elif position.x == startposition.x - 30:
		set_linear_velocity(Vector2.LEFT * speed )#* delta)
#		linear_velocity = Vector2.LEFT * speed * delta
		$Sprite.flip_h = false
