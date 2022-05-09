extends HBoxContainer

onready var options = $OptionButton
var effect_data
var person_item = ""
var value_action = 0

var person_item_node
var value_action_node

func _ready():
	person_item_node = self.get_child(2)
	value_action_node = self.get_child(3)
	
	person_item_node.connect("focus_exited",self,"store_data",[person_item_node])
	value_action_node.connect("focus_exited",self,"store_data",[value_action_node])

func store_data(node):
	person_item_node = self.get_child(2)
	value_action_node = self.get_child(3)

	person_item = person_item_node.text

	#Format yung data
	match options.text:
		"relationship":
			value_action = int(value_action_node.text)
			effect_data = {"type":"rel", "person":person_item, "value":value_action}
		"inventory":
			value_action = value_action_node.text
			effect_data = {"type":"inv", "item":person_item, "action":value_action}

	print(effect_data)

func get_data():
	if(person_item_node.text == ""):
		return null
	if(value_action_node.text == ""):
		return null
	return effect_data

func _on_Button_pressed():
	self.queue_free()


func _on_OptionButton_item_selected(index):
	person_item_node = self.get_child(2)
	value_action_node = self.get_child(3)
	
	match options.text:
		"relationship":
			if value_action_node is OptionButton:
				person_item_node.placeholder_text = "Person"
				value_action_node.queue_free()
				var node = LineEdit.new()
				node.set_name("Value")
				node.placeholder_text = "Value"
				self.add_child_below_node(person_item_node, node)
				
				node.connect("focus_exited",self,"store_data", [node])
				
		"inventory":
			if value_action_node is LineEdit:
				person_item_node.placeholder_text = "Item"
				value_action_node.queue_free()
				var node = OptionButton.new()
				node.set_name("Action")
				node.add_item("store")
				node.add_item("use")
				self.add_child_below_node(person_item_node, node)
				
				value_action = "store"
				node.connect("item_selected",self,"store_data")

	person_item_node.text = ""
	
