extends VBoxContainer

var roll_template = preload("res://scripts/CreateScene/Roll.tscn")
var rolls = []

func _ready():
	pass # Replace with function body.

func read_rolls():
	for roll in self.get_node("MarginContainer/VBoxContainer").get_children():
		rolls.push_back(roll.get_roll())
	return rolls

func _on_Button_pressed():
	var new_roll = roll_template.instance()
	get_node("MarginContainer/VBoxContainer").add_child(new_roll)
