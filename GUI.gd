extends Control

onready var scoremanager = preload("res://highscore_manager.tres")
onready var highscore_label = get_node("FullRekt/VBoxContainer/TopLabel/HighscoreRekt/Score")



func _ready():
	scoremanager.connect("highscore_changed", self, "_on_score_updated")


func _on_score_updated(highscore):
	highscore_label.text = var2str(highscore)
