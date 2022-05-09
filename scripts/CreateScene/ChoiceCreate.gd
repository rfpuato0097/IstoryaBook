extends PanelContainer

var story_data = {"type":"choice", "text":"", "images":"", "sounds":[{"sfx":"", "voice":"", "bgm":""}], "choices":[]}

var effects_node

func _ready():
	$MarginContainer/VBoxContainer/Text/Text.connect("focus_exited",self, "store_value", [$MarginContainer/VBoxContainer/Text/Text])
	$MarginContainer/VBoxContainer/Images/Image.connect("focus_exited",self, "store_value", [$MarginContainer/VBoxContainer/Images/Image])
	$MarginContainer/VBoxContainer/Sounds/BGM/BGM.connect("focus_exited",self, "store_value", [$MarginContainer/VBoxContainer/Sounds/BGM/BGM])
	$MarginContainer/VBoxContainer/Sounds/SFX/SFX.connect("focus_exited",self, "store_value", [$MarginContainer/VBoxContainer/Sounds/SFX/SFX])
	$MarginContainer/VBoxContainer/Sounds/Voiceover/Voice.connect("focus_exited",self, "store_value", [$MarginContainer/VBoxContainer/Sounds/Voiceover/Voice])

func set_id(value):
	$MarginContainer/VBoxContainer/HBoxContainer/Label.text = value
	print($MarginContainer/VBoxContainer/HBoxContainer/Label.text)

func get_story_data():
	store_choices()
	return story_data

func store_value(node):
	match node.name.to_lower():
		"bgm":
			story_data["sounds"][0]["bgm"] = node.text
		"sfx":
			story_data["sounds"][0]["sfx"] = node.text
		"voice":
			story_data["sounds"][0]["voice"] = node.text
		_:
			story_data[node.name.to_lower()] = node.text

func store_choices():
	story_data["choices"] = self.get_node("MarginContainer/VBoxContainer/Choices").read_choices()

func _on_Button_pressed():
	self.queue_free()
