extends VBoxContainer

var textbox_preload = preload("res://scenes/components/EndTextBox.tscn")
var textbox

func _ready():
	for category in Main.end_game_stats.keys():
		textbox = textbox_preload.instance()
		match category:
			"Events":
				textbox.title = category
				for message in Main.end_game_stats[category]:
					textbox.content = textbox.content + message + "\n"
				print(Main.end_game_stats[category])
				self.add_child(textbox)
			"Choices":
				textbox.title = category
				for message in Main.end_game_stats[category]:
					textbox.content = textbox.content + message + "\n"
				print(Main.end_game_stats[category])
				self.add_child(textbox)
			"Relationships":
				textbox.title = category
				for message in Main.end_game_stats[category]:
					textbox.content = textbox.content + message["person"] + ":" + str(message["value"]) + "\n"
				print(Main.end_game_stats[category])
				self.add_child(textbox)
			"Inventory":
				textbox.title = category
				for message in Main.end_game_stats[category]:
					textbox.content = textbox.content + message + "\n"
				print(Main.end_game_stats[category])
				self.add_child(textbox)
