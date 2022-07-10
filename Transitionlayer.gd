extends CanvasLayer


onready var rects = preload("res://TransitionRect.tscn")


func _ready():
	pass
#	instance_color_rects()
	
	
#func instance_color_rects():
#	var viewport_size = get_viewport().size
#	var x_size = calc_tile_number(viewport_size.x, 40)
#	var y_size = calc_tile_number(viewport_size.y, 100)
#	var new_rect = rects.instance()
#	new_rect.rect_min_size = Vector2(x_size, y_size)
#	new
	
	
	
func calc_tile_number(lenght, tilenumber):
	return lenght/tilenumber
	
