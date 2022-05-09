extends VBoxContainer

var story_preload = preload("res://scenes/components/Story.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	readStories(Main.stories)
	Main.connect("updateStoryList",self, "readStories")


func readStories(stories):
	for story in stories.keys():
		#Check if not in List.
		for child in self.get_children():
			if child is Label:
				continue

			if child.title.text == story:
				child.queue_free()
		
		var story_entry = story_preload.instance()
		self.add_child(story_entry)
		story_entry.setTitle(story)
