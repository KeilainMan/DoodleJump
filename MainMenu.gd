extends Node2D

onready var scoremanager = preload("res://highscore_manager.tres")

var platform = preload("res://plattform.tscn")
var last_y:int = 50
var player_startposition:Vector2

var turn_game_on = true



signal pause_tree

func _ready():
	randomize()
#	_save_game()
	_load_game()
	get_tree().paused = true
	instance_platforms()
	player_startposition = $PlayerDummy.position
	$Pausemenu/Pause/Highscorecontainer/VBoxContainer/Highschorenumber.text = var2str(scoremanager.get_total_highscore())
	
	
func _load_game():
	var dir = Directory.new()
	if not dir.file_exists("user://save_01.tres"):
		return
	var savegame = load("user://save_01.tres")
	print(scoremanager.total_highscore , savegame.highscore)
	
	scoremanager.total_highscore = savegame.highscore



func instance_platforms():
	for i in range(15):
		var new_platform = platform.instance()
		new_platform.position = Vector2(0 + rand_range(-get_viewport().size.x/3, get_viewport().size.x/3), last_y+rand_range(-125,-170))# -i*250+rand_range(-50,35))
		last_y = new_platform.position.y
		$AllPlatforms.add_child(new_platform) 
	

