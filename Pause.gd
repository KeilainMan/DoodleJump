extends Control

onready var tween = get_node("Menuetween")


func _on_game_paused():
		get_tree().paused = true
		visible = true
		print("paused")


func _on_Startbutton_pressed():
	tween.interpolate_property(self, "modulate", modulate.a, 0, 3)
	tween.start()
	get_tree().paused = false
	visible = false
