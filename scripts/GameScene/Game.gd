extends Control

onready var inv_button = $Menu/Icons/Inventory
onready var rel_button = $Menu/Icons/Relationships
onready var notes_button = $Menu/Icons/Notes
onready var prev_button = $Menu/Icons/Prev

onready var inv_popup = $Inventory
onready var rel_popup = $Relationships
onready var notes_popup = $Notes
onready var prev_popup = $PrevStoryBoxes

onready var background = $Background

func _ready():
	inv_button.connect("pressed", self, "toggleView", [inv_popup])
	rel_button.connect("pressed", self, "toggleView", [rel_popup])
	notes_button.connect("pressed", self, "toggleView", [notes_popup])
	prev_button.connect("pressed", self, "toggleView", [prev_popup])

func toggleView(node):
	if not node.is_visible():
		node.show()
		for popup in [inv_popup, rel_popup, notes_popup, prev_popup]:
			if popup != node:
				popup.hide()
	else:
		node.hide()

func changeBackground(image):
	yield(get_tree(), "idle_frame")
	if(Main.images.has(image)):
		background.texture = Main.images[image]
	else:
		#Default Image.
		pass
