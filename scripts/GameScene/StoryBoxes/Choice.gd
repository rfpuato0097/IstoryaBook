extends MarginContainer

onready var label = $Container/Text
onready var buttons = $Container/ChoiceList
var text
var choices

#var pre_button = Button.new()
var button

func _ready():
	label.text = text
	set_buttons()

func set_buttons():
	var inventory_list = Main.inventory.duplicate(true)
	
	for choice in choices:

#		button = pre_button.instance()
		button = Button.new()
		button.text = choice["choice"]
		button.connect("pressed", get_parent(), "_choice_selected", [choice["effects"], choice["next"], buttons, choice["choice"], choice["desc"]])
		buttons.add_child(button)

		#Check Effect then Inventory
		#var found = []
		#var items = []
		for effect in choice["effects"]:
			if(effect["type"] == "inv"):
				if(effect["action"] == "use"):
					#items.push_back(effect["item"])
					#Search sa Inventory
					#for item in Main.end_game_stats["Inventory"]:
					#	if(item["item"] == effect["item"]):
					#		found.push_back( effect["item"] )

					for item in inventory_list:
						if(item == effect["item"]):
							#found.push_back( effect["item"] )
							inventory_list.erase( effect["item"] )
							break


		#for item in found:
		#	items.erase(item)

		#print(items)
		#if(items):
		#	button.disabled = true
