extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/GameState").score = 0
	get_node("/root/GameState").player_xp = 0
	get_node("/root/GameState").player_health = get_node("/root/GameState").player_max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		get_tree().change_scene("res://Scenes/Overworld.tscn")
