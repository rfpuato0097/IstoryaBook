extends VBoxContainer

var choice_template = preload("res://scripts/CreateScene/Choice.tscn")
var choices = []

func _ready():
	pass # Replace with function body.

func read_choices():
	for choice in self.get_node("MarginContainer/VBoxContainer").get_children():
		choices.push_back(choice.get_choice())
	return choices

func _on_Button_pressed():
	var new_choice = choice_template.instance()
	get_node("MarginContainer/VBoxContainer").add_child(new_choice)
