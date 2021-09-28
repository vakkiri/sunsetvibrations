extends TextureRect


var blink_time = 1.0
var blink_timer = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	blink_timer -= delta
	if blink_timer <= 0:
		blink_timer += blink_time
		visible = !visible
