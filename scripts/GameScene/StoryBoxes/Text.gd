extends MarginContainer

onready var label = $Container/Text
onready var button = $Container/Button

var text = "TEST"
var next
var effects = []

func _ready():
	label.text = text
	button.text = "continue"
	button.connect("pressed", get_parent(), "_continue", [next, button, effects])
