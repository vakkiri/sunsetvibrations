extends Node2D


var key = "DOWN"
var start_y
var time
var life
var ratio
var attack_blocked = false

const DISTANCE = 32.0
const DELAY_BEATS = 4.0
var pre_delay = 0.075
var post_delay = 0.1

var hit_range = 0.075
var crit_range = 0.04
var spam_range = 0.25
 
const FRAMES = {
	"DOWN": 0,
	"UP": 1,
	"RIGHT": 2,
	"LEFT": 3,
	"A": 4,
	"B": 5,
}

func set_bpm(bpm: float):
	var seconds_per_beat = 60.0 / bpm
	life = DELAY_BEATS * seconds_per_beat
	
func set_key(new_key: String):
	key = new_key
	$AnimatedSprite.frame = FRAMES[new_key]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	time = 0.0
	start_y = position.y

func cancel():
	attack_blocked = true
	kill()
	
func kill():
	if key in ["A", "B"]:
		get_parent().monster_attack(attack_blocked)
	elif not attack_blocked:
		get_parent().miss()
	queue_free()

func distance() -> float:
	return abs(life - time)
	
func crit() -> bool:
	return distance() < crit_range
	
func active() -> bool:
	return distance() < hit_range

func _process(delta):
	if (
		(Input.is_action_just_pressed("ui_up") and key == "UP") or
		(Input.is_action_just_pressed("ui_down") and key == "DOWN") or
		(Input.is_action_just_pressed("ui_left") and key == "LEFT") or
		(Input.is_action_just_pressed("ui_right") and key == "RIGHT")
	):
		if active():
			attack_blocked = true
			if crit():
				get_parent().score(true)
			else:
				get_parent().score(false)
			kill()
		elif distance() < spam_range:
			get_parent().miss()
			kill()
	if (
		(Input.is_action_just_pressed("a") and key == "A") or
		(Input.is_action_just_pressed("b") and key == "B")
	):
		if active():
			attack_blocked = true
			get_parent().block()
			kill()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time += delta
	ratio = time / life
	position.y = start_y + (DISTANCE * ratio * ratio)
	if time >= life and visible:
		visible = false
	elif time >= life + post_delay:
		kill()
