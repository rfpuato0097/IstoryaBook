extends WindowDialog

var story
var title

onready var title_label = self.get_node("MarginContainer/VBoxContainer/Label")
onready var text_edit = self.get_node("MarginContainer/VBoxContainer/TextEdit")

func _ready():
	pass # Replace with function body.

func set_title(value):
	title = value
	title_label.text = value
	

func set_text_edit(value):
	story = value
	text_edit.text = JSON.print(story, "\t")


func show_board():
	self.show()


func _on_Copy_pressed():
	OS.set_clipboard(text_edit.text)
	

func _on_Continue_pressed():
	Main.stories[title_label.text] = story[title]
	get_tree().change_scene("res://scenes/MainMenu.tscn")
