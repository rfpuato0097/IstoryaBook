extends MarginContainer

onready var label = $Container/Text
onready var input = $Container/LineEdit
var text = ""
var words = []

func _ready():
	label.text = text
	input.connect("text_entered", get_parent(), "_input_entered", [words, input])
