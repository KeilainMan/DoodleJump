extends StaticBody2D

onready var scoremanager = preload("res://highscore_manager.tres")
signal score_points


func _ready():
	connect("score_points", scoremanager, "increase_current_highscore")
	

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("score_points", 2)
	queue_free()
