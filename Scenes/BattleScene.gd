extends Node2D

const DELAY_BEATS = 4.0
const ARROW = preload("res://Scenes/Arrow.tscn")
const SCARECROW = preload("res://Scenes/ScarecrowMonster.tscn")
const SLIME = preload("res://Scenes/Monsters/Slime.tscn")
var bpm
var beat_seconds
var next_beat
var spawn_times = []
var arrow_threshold = 0.9
const BEAT_DIVISION = 1.0
var song_info = {}
var beat_num = 0
var crit_ratio = 2.0
var song = null
var monster
	
func set_bpm(new_bpm: float):
	var seconds_per_beat = 60.0 / new_bpm
	bpm = new_bpm
	beat_seconds = seconds_per_beat / BEAT_DIVISION
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func init(monster_type: String):
	load_song(monster_type)
	next_beat = 0.0
	if monster_type == "scarecrow":
		monster = SCARECROW.instance()
	elif monster_type == "slime":
		monster = SLIME.instance()
	monster.position = Vector2(100, 120)
	add_child(monster)
	
func start():
	song.play()
	
func _spawn_arrow():
	var arrow = ARROW.instance()
	arrow.position.x = $PlayerArrowBox.position.x
	arrow.position.y = $PlayerArrowBox.position.y - arrow.DISTANCE
	arrow.set_bpm(bpm)
	var rand = randi() % 4
	if rand == 0:
		arrow.set_key("UP")
	elif rand == 1:
		arrow.set_key("DOWN")
	elif rand == 2:
		arrow.set_key("LEFT")
	elif rand == 3:
		arrow.set_key("RIGHT")
	add_child(arrow)

func _spawn_block():
	var arrow = ARROW.instance()
	arrow.position.x = $MonsterArrowBox.position.x
	arrow.position.y = $PlayerArrowBox.position.y - arrow.DISTANCE
	arrow.set_bpm(bpm)
	var rand = randi() % 2
	if rand == 0:
		arrow.set_key("A")
	elif rand == 1:
		arrow.set_key("B")
	add_child(arrow)

func kill_monster():
	get_node("/root/GameState").add_xp(monster.xp)
	
func score(crit):
	$Player.playing = true
	$Player.frame = 0
	var damage = get_node("/root/GameState").player_attack
	if crit:
		damage *= crit_ratio
	monster.hit(damage)

func block():
	$BattleMessage.block()
	
func monster_attack(block=false):
	monster.attack()
	if not block:
		get_node("/root/GameState").player_health -= monster.attack
	
func load_song(song_name: String):
	var file = File.new()
	var path = "res://Assets/Configs/music.json"
	
	if file.file_exists(path):
		file.open(path, File.READ)
		song_info = JSON.parse(file.get_as_text()).result[song_name]
		file.close()
	
	set_bpm(song_info["bpm"])
	song = get_node(song_name)
	print(song_info)
	
func end_battle():
	get_parent().end_battle()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if monster.visible:
		if song.get_playback_position() >= next_beat:
			next_beat += beat_seconds
			beat_num += 1
			if beat_num + DELAY_BEATS in song_info["attack"]:
				_spawn_arrow()
			if beat_num + DELAY_BEATS in song_info["defend"]:
				_spawn_block()
		# If the song as looped, reset next_beat time
		elif song.get_playback_position() + beat_seconds < next_beat:
			next_beat = beat_seconds
			beat_num = 1
			if beat_num + DELAY_BEATS in song_info["attack"]:
				_spawn_arrow()
			if beat_num + DELAY_BEATS in song_info["defend"]:
				_spawn_arrow()
		
		var active_arrow = "NONE"
	else:
		end_battle()
