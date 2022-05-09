extends Control

onready var text_edit_node = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/TextEdit
onready var results_node = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/PanelContainer
onready var title_node = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/Label

func _ready():
	title_node.text = Main.selected_story
	#text_edit_node.text = str(Main.end_game_stats)
	for category in Main.end_game_stats.keys():
		match category:
			"Events":
				text_edit_node.text = text_edit_node.text + category + "\n"
				for message in Main.end_game_stats[category]:
					text_edit_node.text = text_edit_node.text + "\t" + message + "\n"
			"Choices":
				text_edit_node.text = text_edit_node.text + category + "\n"
				for message in Main.end_game_stats[category]:
					text_edit_node.text = text_edit_node.text + "\t" + message + "\n"
			"Relationships":
				text_edit_node.text = text_edit_node.text + category + "\n"
				for message in Main.end_game_stats[category]:
					text_edit_node.text = text_edit_node.text + "\t" + message["person"] + ":" + str(message["value"]) + "\n"
			"Inventory":
				text_edit_node.text = text_edit_node.text + category + "\n"
				for message in Main.end_game_stats[category]:
					text_edit_node.text = text_edit_node.text + "\t" + message["item"] + "\n"


func _on_ToggleScreen_toggled(button_pressed):
	if button_pressed == true:
		text_edit_node.show()
		results_node.hide()
	else:
		text_edit_node.hide()
		results_node.show()

func _on_Exit_pressed():
	#Clear Main.endgamestats
	Main.end_game_stats = {"Events":[], "Choices":[], "Relationships":[], "Inventory":[]}
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	pass # Replace with function body.
