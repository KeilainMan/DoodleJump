extends ColorRect


export var camera:NodePath


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GrayOverlay_visibility_changed():
	rect_position = get_node(camera).position
	rect_min_size = 2*get_viewport().size
