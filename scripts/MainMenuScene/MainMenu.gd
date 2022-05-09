extends Control

onready var info_panel = $Information

func _ready():
	get_tree().connect("files_dropped", self, "_on_files_dropped")


func _on_files_dropped(uploaded_files,screen):
	var files = []
	var audios = []
	var images = []
	
	for upload in uploaded_files:
		var extension = upload.get_extension()
		if(extension == "json"):
			var file = File.new()
			file.open(upload, File.READ)
			files.push_back( JSON.parse(file.get_as_text()).result )
			file.close()
		elif(extension == "mp3" or extension == "wav"):
			audios.push_back(upload)
		elif(extension == "png" or extension == "jpg" or extension == "jpeg"):
			images.push_back(upload)
	
	Main.addAudio(audios)
	Main.addStories(files)
	Main.addImages(images)



func _on_InfoButton_pressed():
	info_panel.popup()
	pass # Replace with function body.


func _on_CreateStory_pressed():
	get_tree().change_scene("res://scenes/Create.tscn")
	pass # Replace with function body.
