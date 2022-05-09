extends VBoxContainer

func update_storybox(storybox):
	var panel = PanelContainer.new()
	self.add_child(panel)
	panel.add_child(storybox)
