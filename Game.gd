extends Node2D


var platform = preload("res://plattform.tscn")
var obstacle_enemy = preload("res://Obstacleenemy.tscn")
var attack_enemy = preload("res://AttackObstacle.tscn")
var moving_enemy = preload("res://MovingObstacle.tscn")

export(Script) var game_save_class

var last_y:int = 50
var player_startposition:Vector2

onready var scoremanager = preload("res://highscore_manager.tres")

signal pause_tree
signal game_start

func _ready():
	randomize()
	get_tree().paused = false



	$Player.connect("Game_Over", self, "_on_Game_over")
	$Transitionlayer/TransitionRekt.connect("pause_game", self, "_on_pause_game")
	connect("game_start", scoremanager, "_on_game_start")
	
	emit_signal("game_start")
	instance_platforms()
	player_startposition = $Player.position
	
	
func instance_platforms():
	for i in range(2000):
		var new_platform = platform.instance()
		new_platform.position = Vector2(0 + rand_range(-get_viewport().size.x/3, get_viewport().size.x/3), last_y+rand_range(-125,-160))# -i*250+rand_range(-50,35))
		last_y = new_platform.position.y
		$AllPlatforms.add_child(new_platform) 
		if i > 15:
			determine_platform_enemy(new_platform.position, 70)
		elif i > 150:
			determine_platform_enemy(new_platform.position, 55)
		
		
func determine_platform_enemy(platform_pos, p_factor):
	if randi() % 100 +1 > p_factor:
		var new_obstacle = EnemySelector.select_platform_habitant()
		if !new_obstacle == null:
			var enemy = new_obstacle.instance()
			enemy.position = Vector2(platform_pos.x + rand_range(-30,30), platform_pos.y)
			$AllObstacleEnemys.add_child(enemy)
	

func spawn_start_platform():
	var new_platform = platform.instance()
	new_platform.position = $Player.position + Vector2(0,20)
	last_y = new_platform.position.y
	$AllPlatforms.add_child(new_platform) 


func reset_player():
	$Player.position = player_startposition
	$Player/Camera2D.position = $Player.position
#	$Player.fallen = false
	$Player.set_physics_process(true)


#func reset_game():
#	reset_player()
#	spawn_start_platform()
#	instance_platforms()
#	$Transitionlayer/TransitionRekt.end_transition()


func _on_Game_over():
	scoremanager.stop_score = true
	$Transitionlayer/TransitionRekt.start_transition()
	_save_game()
	
func _save_game():
	var new_save = game_save_class.new()
	if not scoremanager.total_highscore == null:
		new_save.highscore = scoremanager.total_highscore
	
	ResourceSaver.save("user://save_01.tres", new_save)
#	yield($Transitionlayer/TransitionRekt/Tween, "tween_completed")
#	print("trantsition")
#	emit_signal("pause_game")
#
#		delete_all_game_objects()
#		reset_game()
	
#func _on_pause_game():
#	emit_signal("pause_tree")
#	reset_game()
#
#
#func delete_all_game_objects():
#	delete_platforms()
#	delete_enemys()
#
#
#func delete_platforms():
#	for i in $AllPlatforms.get_children():
#		i.queue_free()
#
#
#func delete_enemys():
#	pass
