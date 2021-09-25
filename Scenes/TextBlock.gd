extends Node2D

const CHAR = preload("res://Scenes/AnimatedSpriteCharacter.tscn")
export var text = "Default ! Text"
export var char_width = 4
export var char_height = 9
export var line_width = 128
export var upper_padding = 1
export var lower_padding = 0
export var space_size = 3
export var vertical_padding = 2

var chars = []
var font_info = {}

export var font = "default_font"

func set_font(font_name):
	font = font_name
	var file = File.new()
	var path = "res://Assets/Fonts/" + font_name + ".json"

	if file.file_exists(path):
		file.open(path, File.READ)
		font_info = JSON.parse(file.get_as_text()).result	
		file.close()
	else:
		font_info = {}
	
	# TODO: move this all into font_info
	if font_name == "shop_titles":
		char_width = 8
		char_height = 8
		space_size = 3
		upper_padding = 3
		lower_padding = 3
	elif font_name == "default_font":
		char_width = 4
		char_height = 9
		space_size = 3
		upper_padding = 1
		lower_padding = 0
	elif font_name == "ui_large":
		char_width = 8
		char_height = 18
		space_size = 1
		upper_padding = 2
		lower_padding = 2
		
func _update_text():
	for c in chars:
		remove_child(c)
		c.queue_free()
	chars.clear()
	
	var x = 0
	var y = 0
	for t in text:
		var c = CHAR.instance()
		c.animation = font
		c.set_char(t)
		c.position.x = x
		c.position.y = y
		chars.append(c)
		add_child(c)
		if t in font_info:
			x += font_info[t]
		else:
			x += char_width
		
		if t >= 'A' and t <= 'Z':
			x += upper_padding
		elif t != ' ':
			x += lower_padding
		else:
			x += space_size
			
		if x >= line_width:
			y += char_height + vertical_padding
			x = 0
			
		
	
	
func set_text(new_text):
	text = new_text
	_update_text()
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	set_font(font)
	_update_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
