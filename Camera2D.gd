extends Camera2D


export(NodePath) var player_path
onready var tween = $CameraTween

var player



func _ready():
	position = Vector2(0, -400)
	player = get_node(player_path)
	set_process(true)
	player.connect("bounced", self, "_on_player_bounced")
	
	
#func _process(delta):
#	if player.position.y < position.y:
#		position =Vector2(0,player.position.y)
#		print(position)

func _on_player_bounced(player_position):
	tween.interpolate_property(self, "position", position, Vector2(position.x, player_position.y), 1)
	tween.start()
	
	
	
