extends Node2D


const DURATION = 1.0
var timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func block():
	$Block.visible = true
	timer = DURATION
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer > 0:
		timer -= delta
	else:
		for child in get_children():
			child.visible = false
