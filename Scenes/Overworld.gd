extends Node2D

const BATTLE_SCENE = preload("res://Scenes/BattleScene.tscn")
const BATTLE_TRANSITION = preload("res://Scenes/BattleStart.tscn")
var in_battle = false
var scarecrow_dead = false
var battle_scene = null
var battle_transition = null
var monster_type

# Called when the node enters the scene tree for the first time.
func _ready():
	$JumpingCamera.enable()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_battle:
		if battle_transition != null and battle_transition.finished:
			remove_child(battle_transition)
			battle_transition.queue_free()
			battle_transition = null
			battle_scene.start()

func prepare_battle():
	battle_scene = BATTLE_SCENE.instance()
	battle_scene.init(monster_type)
	add_child(battle_scene)
	$JumpingCamera.disable()

func start_battle(monster_type):
	self.monster_type = monster_type
	$AudioStreamPlayer.stop()
	battle_transition = BATTLE_TRANSITION.instance()
	add_child(battle_transition)
	in_battle = true
			
func end_battle():
	remove_child(battle_scene)
	battle_scene.queue_free()
	battle_scene = null
	$AudioStreamPlayer.play()
	$Scarecrow.visible = false
	$JumpingCamera.enable()
	in_battle = false
	
func _on_ScarecrowTrigger_body_entered(body):
	if not in_battle:
		if body.name == "Player" and not scarecrow_dead:
			scarecrow_dead = true
			start_battle("scarecrow")

