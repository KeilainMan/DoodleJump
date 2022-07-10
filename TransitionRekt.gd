extends ColorRect


export var camera:NodePath
onready var tween = $Tween


signal pause_game


func _ready():
	modulate = Color(1,1,1,0)
	rect_min_size = 2*get_viewport().size

func start_transition():
	move_rect_to_place()
	tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1, tween.TRANS_LINEAR, tween.EASE_IN_OUT)
	tween.start()
	modulate = Color(1,1,1,1)
	yield(tween, "tween_completed")
	tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,0), 1 , tween.TRANS_LINEAR, tween.EASE_IN_OUT)
	tween.start()
	get_tree().change_scene("res://MainMenu.tscn")
	
#	emit_signal("pause_game")
	

#func end_transition():
#	tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,0), 1 , tween.TRANS_LINEAR, tween.EASE_IN_OUT)
#	tween.start()
#	get_tree().change_scene("res://MainMenu.tscn")
	
func move_rect_to_place():
	if self:
		rect_position = get_node(camera).position
#		
