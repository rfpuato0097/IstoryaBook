extends MarginContainer


onready var label = $Container/Text
onready var button = $Container/Button
onready var die  = $Container/Die/MarginContainer/Value
var text = "TEST"
var data = []

func _ready():
	label.text = text
	button.text = "ROLL"
	set_value(20)
	button.connect("pressed", get_parent(), "_roll", [self])

func set_value(value):
	die.text = str(value)
