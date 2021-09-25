extends  KinematicBody2D


export var type = "no_type"
export var vision_radius = 64.0
export var speed = 24.0

var active = false
var dead = false
var remove_timer = 1.0

func player_position():
	return get_parent().get_node("Player").position
	
func distance_to_player():
	return abs(player_position().distance_to(position))

func near_player():
	return distance_to_player() <= vision_radius
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not dead:
		var movement = Vector2(0, 0)
		if near_player() and active and not get_parent().in_battle:
			if position.x < player_position().x:
				movement.x = speed
			elif position.x > player_position().x:
				movement.x = -speed
			if position.y < player_position().y:
				movement.y = speed
			elif position.y > player_position().y:
				movement.y = -speed
		move_and_slide(movement)
	else:
		remove_timer -= delta
		if remove_timer <= 0:
			queue_free()

func _on_Area2D_body_entered(body):
	if body.name == "Player" and type != "no_type":
		get_parent().start_battle(type)
		dead = true
