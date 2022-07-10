extends Node


var obstacle_enemy = preload("res://Obstacleenemy.tscn")
var attack_enemy = preload("res://AttackObstacle.tscn")
var moving_enemy = preload("res://MovingObstacle.tscn")


func _ready():
	pass # Replace with function body.


func select_platform_habitant():
	var factor = randi() % 100 + 1
	if factor < 1:#80:
		return obstacle_enemy
	elif factor >1 and factor < 2:#>= 80 and factor <95:
		return attack_enemy
	elif factor >= 2:#>= 95:
		return moving_enemy
	else:
		return null
