extends Node

var stories = {}
var selected_story

var audio_streams = {}
var images = {}

var end_game_stats = {"Events":[], "Choices":[], "Relationships":[], "Inventory":[]}

var inventory = []

signal updateStoryList

func _ready():
	pass # Replace with function body.

func storySelected(node):
	selected_story = node.title.text
	get_tree().change_scene("res://scenes/Game.tscn")

func addStories(files):
	for file in files:
		var title = file.keys()[0]
		stories[title] = file[title]
	emit_signal("updateStoryList", stories)
	
func addAudio(audios):
	for filepath in audios:
		audio_streams[filepath.get_file()] = GdScriptAudioImport.loadfile(filepath)

func addImages(uploaded_images):
	var image = Image.new()
	var texture = ImageTexture.new()
	for filepath in uploaded_images:
		image.load(filepath)
		texture.create_from_image(image)
		images[filepath.get_file()] = texture.duplicate()

func store_end_game_stats(category, value):
	match category:
		"Ending":
			end_game_stats[category] = value
		"Relationships":
			end_game_stats["Relationships"] = value
		"Inventory":
			end_game_stats["Inventory"] = value
		_:
			end_game_stats[category].push_back(value)
