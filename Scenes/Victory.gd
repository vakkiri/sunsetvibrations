extends CanvasLayer

var duration = 2.0
var time = 0.0
var starts = []
var pause_time = 0.5
var paused = false
var finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		starts.push_back(child.rect_position.x)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ratio = (time/duration) * 4.0
	if ratio > PI/2 and pause_time > 0.0:
		pause_time -= delta
		if not paused:
			get_parent().end_battle()
			paused = true
	else:
		time += delta
		for i in range(len(get_children())):
			get_child(i).rect_position.x = starts[i] - starts[i] * sin(ratio)
		if time >= duration:
			queue_free()
		
