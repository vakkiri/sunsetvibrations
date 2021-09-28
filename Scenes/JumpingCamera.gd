extends Node2D


var active = true
var target_position

func enable():
	active = true
	
func disable():
	active = false
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.current = true
	target_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		position = target_position
		$Camera2D.position = Vector2(80, 56)
	else:
		position = Vector2(0, 0)
		$Camera2D.position = Vector2(80, 72)


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		while body.position.y < target_position.y:
			target_position.y -= 128
		while body.position.y > target_position.y + 128:
			target_position.y += 128
		while body.position.x < target_position.x:
			target_position.x -= 160
		while body.position.x > target_position.x + 160:
			target_position.x += 160
	elif body.is_in_group("monster"):
		body.active = false


func _on_Area2D_body_entered(body):
	if body.is_in_group("monster"):
		body.active = true
