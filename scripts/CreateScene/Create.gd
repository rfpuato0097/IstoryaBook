extends Control

var story = {}
var story_title = ""

var text_template = preload("res://scenes/components/create/TextCreate.tscn")
var choice_template = preload("res://scenes/components/create/ChoiceCreate.tscn")
var input_template = preload("res://scenes/components/create/InputCreate.tscn")
var roll_template = preload("res://scenes/components/create/RollCreate.tscn")

onready var nodes_container = get_node("VboxContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/StoryBoxes")
onready var popup = get_node("PopupPanel")

var on_focus = self

func _ready():
	$VboxContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ButtonArray/Text.connect("pressed", self, "add_node", [$VboxContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ButtonArray/Text])
	$VboxContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ButtonArray/Choice.connect("pressed", self, "add_node", [$VboxContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ButtonArray/Choice])
	$VboxContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ButtonArray/Input.connect("pressed", self, "add_node", [$VboxContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ButtonArray/Input])
	$VboxContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ButtonArray/Roll.connect("pressed", self, "add_node", [$VboxContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ButtonArray/Roll])

	get_tree().connect("files_dropped", self, "_on_files_dropped")

func _process(delta):
	if(self.get_focus_owner() != null):
		if(self.get_focus_owner() is LineEdit):
			on_focus = self.get_focus_owner()

func _on_files_dropped(uploaded_files,screen):
	var files = []
	var audios = []
	var images = []
	
	print("File Dropped" + str(uploaded_files))
	
	for upload in uploaded_files:
		var extension = upload.get_extension().to_lower()
		if(extension == "json"):
			var file = File.new()
			file.open(upload, File.READ)
			files.push_back( JSON.parse(file.get_as_text()).result )
			file.close()
		elif(extension == "mp3" or extension == "wav"):
			if(on_focus is LineEdit):
				on_focus.text = upload.get_file()
			
			audios.push_back(upload)
		elif(extension == "png" or extension == "jpg" or extension == "jpeg"):
			if(on_focus is LineEdit):
				on_focus.text = upload.get_file()
			
			images.push_back(upload)
	
	Main.addAudio(audios)
	Main.addStories(files)
	Main.addImages(images)

func read_nodes():
	story = {story_title:[]}
	
	var id = 1
	for node in nodes_container.get_children():
		var temp = node.get_story_data()
		temp["id"] = id
		story[story_title].push_back(temp)
		
		id = id + 1

	print(story)
	return story
	
func create_story():
	read_nodes()
	popup.set_title(story_title)
	popup.set_text_edit(story)
	popup.show_board()
	

func add_node(node):
	var new_node
	
	match node.name:
		"Text":
			new_node = text_template.instance()
		"Choice":
			new_node = choice_template.instance()
		"Input":
			new_node = input_template.instance()
		"Roll":
			new_node = roll_template.instance()
	nodes_container.add_child(new_node)
	new_node.connect("tree_exited", self, "update_id")
	update_id()

func _on_Title_text_changed(new_text):
	story_title = new_text

func update_id():
	var id = 1
	for node in nodes_container.get_children():
		node.set_id("ID: " + str(id) )
		id = id + 1


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
