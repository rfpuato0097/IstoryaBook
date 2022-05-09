extends PanelContainer

onready var content_node = $MarginContainer/VBoxContainer/Content
onready var title_node = $MarginContainer/VBoxContainer/Title

var title = ""
var content = ""

func _ready():
	content_node.text = content
	title_node.text = title

func setText(sentTitle, sentContent):
	title = sentTitle
	content = sentContent
