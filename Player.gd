extends RigidBody2D


onready var scoremanager = preload("res://highscore_manager.tres")

var jump_speed = 800
var speed = 400
var left_key = Input.is_action_pressed("ui_left")
var right_key = Input.is_action_pressed("ui_right")
onready var camera = $Camera2D


var fallen = false
var on_screen = true

export var left_press_button:NodePath
export var right_press_button:NodePath

enum{
	JUMPING
	FALLING
}

var state = FALLING

signal Game_Over


func _ready():
	set_physics_process(true)
	connect("Game_Over", scoremanager, "_on_game_over")


func _physics_process(delta):
	if linear_velocity.y > 0:
		state = FALLING
	if Input.is_action_pressed("ui_left"):
		set_linear_velocity(Vector2(-speed, get_linear_velocity().y))
		$Sprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		set_linear_velocity(Vector2(speed, get_linear_velocity().y))
		$Sprite.flip_h = false
	elif !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
		set_linear_velocity(Vector2(0,get_linear_velocity().y))
	match state:
		FALLING:
			$AnimationPlayer.play("Falling")
		JUMPING:
			$AnimationPlayer.play("Jumping")




func _on_collision(body):
	if body.is_in_group("platform") and get_linear_velocity().y > 0:
		set_linear_velocity(Vector2(0, -jump_speed))
		state = JUMPING
	elif body.is_in_group("Enemy"):
		set_linear_velocity(Vector2(rand_range(-2,2)*100,-500))
		set_all_collision_layer_false()
		set_physics_process(false)
		$AnimationPlayer.play("Getting Hit")



func _on_VisibilityNotifier2D_screen_exited():
	on_screen = false
	if get_global_transform_with_canvas().origin.y > 1200:
		emit_signal("Game_Over")
	elif position.x > camera.position.x and linear_velocity.x > 0:
		position = Vector2(-get_viewport().size.x/2, position.y)
	elif position.x < camera.position.x and linear_velocity.x < 0:
		position = Vector2(get_viewport().size.x/2, position.y)
	else  :#!fallen and linear_velocity.y > 0:# and position.y > camera.position.y:
		emit_signal("Game_Over")

func set_all_collision_layer_false():
	$Areacollider.set_collision_mask_bit(0, false)
	$Areacollider.set_collision_layer_bit(0, false)
	$Bodycollider.set_collision_mask_bit(0, false)
	$Bodycollider.set_collision_layer_bit(0, false)

func _on_VisibilityNotifier2D_screen_entered():
	on_screen = true
	if get_global_transform_with_canvas().origin.y > 1250:
		emit_signal("Game_Over")


func get_player_position():
	return position


func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):
		set_linear_velocity(Vector2(rand_range(-2,2)*100,-500))
		set_all_collision_layer_false()
		set_physics_process(false)
		$AnimationPlayer.play("Getting Hit")
