extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextBlock5.set_text("Your score: " + str(get_node("/root/GameState").score))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		get_tree().change_scene("res://Scenes/StartScreen.tscn")
