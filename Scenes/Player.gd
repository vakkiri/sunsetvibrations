extends KinematicBody2D


var walk_speed = 32.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite.playing = true
	
	if not get_parent().in_battle:	
		if Input.is_action_pressed("ui_down"):
			move_and_slide(Vector2(0, walk_speed))
			$AnimatedSprite.animation = "walk_down"
			$AnimatedSprite.flip_h = false
		elif Input.is_action_pressed("ui_right"):
			$AnimatedSprite.animation = "walk_right"
			$AnimatedSprite.flip_h = false
			move_and_slide(Vector2(walk_speed, 0))
		elif Input.is_action_pressed("ui_up"):
			$AnimatedSprite.animation = "walk_up"
			$AnimatedSprite.flip_h = false
			move_and_slide(Vector2(0, -walk_speed))
		elif Input.is_action_pressed("ui_left"):
			$AnimatedSprite.animation = "walk_right"
			$AnimatedSprite.flip_h = true
			move_and_slide(Vector2(-walk_speed, 0))
		else:
			$AnimatedSprite.playing = false
			$AnimatedSprite.frame = 0
	else:
		$AnimatedSprite.playing = false
	

