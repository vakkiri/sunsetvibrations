extends Node2D


export var health = 5
var max_health
export var attack = 5
export var xp = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = "idle"
	max_health = health

func kill():
	if visible:
		get_parent().kill_monster()
		visible = false
	
func hit(damage):
	health -= damage
	if health <= 0:
		health = 0
		kill()
	
func attack():
	$AnimatedSprite.animation = "attack"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.animation = "idle"
