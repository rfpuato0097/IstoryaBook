extends VBoxContainer

var roll = {"value":"", "desc_pass":"", "desc_fail":"", "effects_pass":[], "effects_fail":[], "next_pass":"", "next_fail":""}

onready var effects_pass = $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Effects
onready var effects_fail = $MarginContainer2/VBoxContainer/MarginContainer/VBoxContainer/Effects


func _ready():
	$HBoxContainer/Value.connect("focus_exited", self, "store_roll", [$HBoxContainer/Value])
	$MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Desc_pass.connect("focus_exited", self, "store_roll", [$MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Desc_pass])
	$MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Next_Pass.connect("focus_exited", self, "store_roll", [$MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Next_Pass])
	$MarginContainer2/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Desc_Fail.connect("focus_exited", self, "store_roll", [$MarginContainer2/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Desc_Fail])
	$MarginContainer2/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Next_Fail.connect("focus_exited", self, "store_roll", [$MarginContainer2/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Next_Fail])

func store_roll(node):
	roll[node.name.to_lower()] = node.text
	
func get_roll():
	roll["effects_pass"] = effects_pass.read_effects()
	roll["effects_fail"] = effects_fail.read_effects()
	return roll

func _on_Remove_pressed():
	self.queue_free()
