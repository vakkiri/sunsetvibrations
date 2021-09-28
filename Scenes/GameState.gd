extends Node


var player_max_health = 100
var player_health = 100
var player_attack = 1
var player_xp = 0.0
var player_level = 1

var xp_to_next_level = 100.0

var score = 0

func level_up():
	player_level += 1
	player_max_health += 10
	player_health = player_max_health
	player_attack += 1
	
func add_xp(amount):
	player_xp += amount
	if player_xp >= xp_to_next_level:
		player_xp -= xp_to_next_level
		xp_to_next_level += 75.0
		level_up()

func hit_player(damage):
	player_health -= damage
	if player_health <= 0:
		player_health = 0
		get_tree().change_scene("res://Scenes/DeathText.tscn")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
