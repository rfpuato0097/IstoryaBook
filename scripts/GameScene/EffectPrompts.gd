extends VBoxContainer

var prompt_res = preload("res://scenes/components/Prompt.tscn")
var prompts = []

onready var animate = self.get_node("Tween")

func _ready():
	pass # Replace with function body.

func show_prompts(effects, duration):
	for child in self.get_children():
		if(child != animate):
			child.queue_free()
	
	for effect in effects:
		var prompt = prompt_res.instance()
		self.add_child(prompt)
		prompts.push_back(prompt)
		
		match(effect["type"]):
			"rel":
				if(effect["value"] >= 0):
					#print("+" + str(effect["value"]) + " " + effect["person"])
					prompt.set_text("+" + str(effect["value"]) + " " + effect["person"])
				else:
					#print(str(effect["value"]) + " " + effect["person"])
					prompt.set_text(str(effect["value"]) + " " + effect["person"])
			"inv":
				if(effect["action"] == "store"):
					#print("Gained " + effect["item"])
					prompt.set_text("Gained " + effect["item"])
				if(effect["action"] == "use"):
					#print("Used " + effect["item"])
					prompt.set_text("Used " + effect["item"])
			_:
				print("Type not Listed")
	
	#Animate
	animate.interpolate_property(self, "rect_position:x", -300, 50, 0.75, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
	animate.start()

