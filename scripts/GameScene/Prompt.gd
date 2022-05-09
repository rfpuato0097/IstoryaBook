extends PanelContainer


onready var label = get_node("MarginContainer/Label")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_text(value):
	label.text = value
