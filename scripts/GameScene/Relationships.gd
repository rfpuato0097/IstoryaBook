extends VBoxContainer

var relatioship_preload = preload("res://scenes/components/RelationshipBox.tscn")

func update_relationships(effect):
	var relationship_node
	
	for person in (self.get_children()):
		if(person.get_node("MarginContainer/VBoxContainer/PersonName").text == effect["person"]):
			person.get_node("MarginContainer/VBoxContainer/RelationshipLevel").text = str(int(person.get_node("VBoxContainer/RelationshipLevel").text) + int(effect["value"]))
			return
	
	relationship_node = relatioship_preload.instance()
	relationship_node.get_node("MarginContainer/VBoxContainer/PersonName").text = effect["person"]
	relationship_node.get_node("MarginContainer/VBoxContainer/RelationshipLevel").text = "- Relationship Level:  " + str(effect["value"])
	self.add_child(relationship_node)
