extends PanelContainer

onready var title = $Margin/Organizer/Title
onready var play = $Margin/Organizer/Button

func _ready():
	title.text = "Story#0"
	play.connect("pressed", Main, "storySelected", [self])

func setTitle(name):
	title.text = name
