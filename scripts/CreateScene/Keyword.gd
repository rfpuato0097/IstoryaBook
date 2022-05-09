extends VBoxContainer

var keyword  = {"keyword":"", "desc":"", "effects":[], "next":""}

onready var effects = $Effects

func _ready():
	$HBoxContainer/Keyword.connect("focus_exited", self, "store_keyword", [$HBoxContainer/Keyword])
	$HBoxContainer2/Desc.connect("focus_exited", self, "store_keyword", [$HBoxContainer2/Desc])
	$HBoxContainer3/Next.connect("focus_exited", self, "store_keyword", [$HBoxContainer3/Next])

func store_keyword(node):
	keyword[node.name.to_lower()] = node.text

func get_keyword():
	keyword["effects"] = effects.read_effects()
	return keyword

func _on_Remove_pressed():
	self.queue_free()
