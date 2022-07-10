extends StaticBody2D


onready var scoremanager = preload("res://highscore_manager.tres")
onready var bullet = preload("res://bullet.tscn")

signal score_points

func _ready():
	connect("score_points", scoremanager, "increase_current_highscore")


func shoot_a_bullet():
	play_shooting_animation()
	yield(get_tree().create_timer(0.5), "timeout")
	instance_bullet()


func play_shooting_animation():
	$AnimationPlayer.play("shooting")


func instance_bullet():
	var new_bullet = bullet.instance()
	var player_pos = get_tree().get_root().get_node("Game").get_node("Player").get_player_position()
	var direction = (player_pos - position)/(player_pos - position).length()
	new_bullet.targetvector = direction
	add_child(new_bullet)
	

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("score_points", 4)
	queue_free()



func _on_VisibilityNotifier2D_screen_entered():
	$ShootingTimer.start()
	shoot_a_bullet()

	


func _on_ShootingTimer_timeout():
	shoot_a_bullet()
