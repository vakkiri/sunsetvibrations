extends Node2D


const DURATION = 1.0
var life = 1.0
var speed = 16.0
var accel = 8.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_message(type):
	if type == "hit":
		$AnimatedSprite.animation = "hit"
	elif type == "miss":
		$AnimatedSprite.animation = "miss"
	elif type == "crit":
		$AnimatedSprite.animation = "crit"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed += accel * delta
	position.y -= speed * delta
	life -= delta
	if life <= 0:
		queue_free()
