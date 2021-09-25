extends Node2D


const MAX_WIDTH = 32.0

func target_width():
	var xp = get_node("/root/GameState").player_xp / get_node("/root/GameState").xp_to_next_level
	return MAX_WIDTH * xp

# Called when the node enters the scene tree for the first time.
func _ready():
	$XPBar.points[1].x = target_width()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update the XP bar
	if $XPBar.points[1].x < target_width():
		$XPBar.points[1].x += 32 * delta
	else:
		$XPBar.points[1].x = int(target_width())
		
	# Update hp
	$Health.set_text(str(get_node("/root/GameState").player_health))
	
	# Update attack
	$Attack.set_text(str(get_node("/root/GameState").player_attack))
