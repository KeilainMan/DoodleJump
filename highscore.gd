extends Resource
class_name highscore_manager

export var current_highscore:int = 0
export var total_highscore:int

var stop_score = false

signal highscore_changed


func _ready():
	pass # Replace with function body.


func get_current_highscore():
	return current_highscore
	
func get_total_highscore():
	return total_highscore
	
func _on_game_over():
	stop_score = true
	
func _on_game_start():
	reset_current_score()
	stop_score = false
	
	
func reset_current_score():
	current_highscore = 0
	
	
	
func increase_current_highscore(value):
	if !stop_score:
		current_highscore += value * 1.5
		emit_signal("highscore_changed", current_highscore)
		check_total_highscore_update(current_highscore)


func check_total_highscore_update(cur_highscore):
	if cur_highscore > total_highscore:
		total_highscore = cur_highscore
	
	
