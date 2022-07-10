extends Control

onready var tween = get_node("Menuetween")

onready var start_button = get_node("CenterContainer/VBoxContainer/Startbutton")
onready var exit_button = get_node("CenterContainer/VBoxContainer/Exitbutton")
onready var highscore_container = get_node("Highscorecontainer")


func _on_game_paused():
		get_tree().paused = true
		visible = true
		print("paused")


func _on_Startbutton_pressed():
	tween.interpolate_property(start_button, "modulate", start_button.modulate, Color(1,1,1,0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(exit_button, "modulate", exit_button.modulate, Color(1,1,1,0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(highscore_container, "modulate", highscore_container.modulate, Color(1,1,1,0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	get_tree().change_scene("res://Game.tscn")


func _on_Exitbutton_pressed():
	get_tree().quit()
