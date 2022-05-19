extends VBoxContainer

var item_preload = preload("res://scenes/components/ItemBox.tscn")
var inventory_list = []


func update_inventory(effect):
	var item_node
	
	match(effect["action"]):
		"store":
			item_node = item_preload.instance()
			item_node.get_node("MarginContainer/VBoxContainer/ItemName").text = effect["item"]
			self.add_child(item_node)
			
			inventory_list.push_back(effect["item"])
		"use":
			for item in self.get_children():
				if(item.get_node("MarginContainer/VBoxContainer/ItemName").text == effect["item"]):
					self.remove_child(item)
					item.queue_free()
					inventory_list.erase(effect["item"])
					break
	
	Main.inventory = inventory_list

func return_inventory():
	return inventory_list
