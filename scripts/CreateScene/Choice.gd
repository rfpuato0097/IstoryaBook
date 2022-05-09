extends VBoxContainer

var choice = {"choice":"", "desc":"", "next":"", "effects":[]}

onready var effects = $Effects

func _ready():
	$HBoxContainer/Choice.connect("focus_exited", self, "store_choice",[$HBoxContainer/Choice])
	$HBoxContainer2/Desc.connect("focus_exited", self, "store_choice",[$HBoxContainer2/Desc])
	$HBoxContainer3/Next.connect("focus_exited", self, "store_choice",[$HBoxContainer3/Next])

func store_choice(node):
	choice[node.name.to_lower()] = node.text
	
func get_choice():
	choice["effects"] = effects.read_effects()
	return choice


func _on_Remove_pressed():
	self.queue_free()
