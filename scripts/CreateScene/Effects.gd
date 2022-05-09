extends VBoxContainer

var effects_template = preload("res://scripts/CreateScene/Effect.tscn")
var effects = []

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_Button_pressed()


func _on_Button_pressed():
	#Create a new instance of Effect.
	var new_effect = effects_template.instance()
	get_node("MarginContainer/VBoxContainer").add_child(new_effect)
	
	
func read_effects():
	for effect in self.get_node("MarginContainer/VBoxContainer").get_children():
		if (effect.get_data() != null):
			effects.push_back(effect.effect_data)
			
	return effects
