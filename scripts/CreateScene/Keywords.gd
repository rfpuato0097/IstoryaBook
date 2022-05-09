extends VBoxContainer

var keyword_template = preload("res://scripts/CreateScene/Keyword.tscn")
var keywords = []


func _ready():
	pass # Replace with function body.

func read_keywords():
	for keyword in self.get_node("MarginContainer/VBoxContainer").get_children():
		keywords.push_back(keyword.get_keyword())
	return keywords

func _on_Button_pressed():
	var new_keyword = keyword_template.instance()
	get_node("MarginContainer/VBoxContainer").add_child(new_keyword)
