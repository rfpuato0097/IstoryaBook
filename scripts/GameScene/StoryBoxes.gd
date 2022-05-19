extends PanelContainer

var rng = RandomNumberGenerator.new()

var story
var story_node

var text_preload = preload("res://scenes/storyboxestemplate/Text.tscn")
var choice_preload = preload("res://scenes/storyboxestemplate/Choice.tscn")
var input_preload = preload("res://scenes/storyboxestemplate/Input.tscn")
var roll_preload = preload("res://scenes/storyboxestemplate/Roll.tscn")


onready var bgm_player = $BGM
onready var sfx_player = $SFX
onready var voice_player = $Voice
var bgm: AudioStream
var sfx: AudioStream
var voice: AudioStream

onready var tween_node = $Tween

onready var inventory = get_node("../../Inventory/ScrollContainer/ItemBoxes")
onready var relationships = get_node("../../Relationships/ScrollContainer/RelationshipBoxes")
onready var notes = get_node("../../Notes")
onready var prevstoryboxes = get_node("../../PrevStoryBoxes/ScrollContainer/StoryBoxes")
onready var effectprompts = get_node("../../EffectPrompts")
onready var game = get_node("../..")

func _ready():
	story = Main.stories[Main.selected_story]
	print(story)
	progressStory(0)

func progressStory(storybox_index):
	#Add Storybox
	match(story[storybox_index]["type"]):
		"text":
			story_node = text_preload.instance()
			story_node.text = story[storybox_index]["text"]
			story_node.next = story[storybox_index]["next"]
			story_node.effects = story[storybox_index]["effects"]
			
		"choice":
			story_node = choice_preload.instance()
			story_node.text = story[storybox_index]["text"]
			story_node.choices = story[storybox_index]["choices"]
			
		"input":
			story_node = input_preload.instance()
			story_node.text = story[storybox_index]["text"]
			story_node.words = story[storybox_index]["words"]
			
		"roll":
			story_node = roll_preload.instance()
			story_node.text = story[storybox_index]["text"]
			story_node.data = story[storybox_index]["data"]

	self.add_child(story_node)
	
	#Animate StoryBox
	tween_node.interpolate_property(story_node.label, "percent_visible", 0, 1, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	tween_node.start()
	
	#Play Sounds
	for sound in story[storybox_index]["sounds"]:
		for key in sound.keys():
			match(key):
				"bgm":
					if(sound["bgm"] != null or sound["bgm"] != ""):
						#bgm = load(sound["bgm"])
						bgm = getAudio(sound["bgm"])
						bgm_player.set_stream(bgm)
						bgm_player.play()
					else:
						#bgm_player.stop()
						pass
				"sfx":
					if(sound["sfx"] != null or sound["sfx"] != "" ):
						#sfx = load(sound["sfx"])
						sfx = getAudio(sound["sfx"])
						sfx_player.set_stream(sfx)
						sfx_player.play()
					else:
						sfx_player.stop()
				"voice":
					if(sound["voice"] != null or sound["voice"] != ""):
						#voice = load(sound["voice"])
						voice = getAudio(sound["voice"])
						voice_player.set_stream(voice)
						voice_player.play()
					else:
						sfx_player.stop()
	
	#Set Background
	game.changeBackground(story[storybox_index]["images"])

func sendStoryBox(storybox):
	var send = storybox
	self.remove_child(storybox)
	prevstoryboxes.update_storybox(send)
	
func getAudio(filename):
	var dir = Directory.new()
	dir.open("res://assets/sound/")
	
	if(filename != null or filename != ""):
		if(dir.file_exists(filename)):
			return(load(dir.get_current_dir() + "/" + filename))
		elif(Main.audio_streams.has(filename)):
			return Main.audio_streams[filename]
		else:
			print("Audio File not Found")

func _continue(next, button, effects):
	button.disabled = true
	
	sendStoryBox(story_node)
	do_effects(effects)
	is_end(next)

func _choice_selected(effects, next, buttons_container, choice, desc):
	#Disable Buttons
	var buttons = buttons_container.get_children()
	for button in buttons:
		button.disabled = true
	
	#Reflect Actions to Inventory and Relationships
	do_effects(effects)

	#Update End Game Stats
	Main.store_end_game_stats("Choices", choice)
	Main.store_end_game_stats("Events", desc)

	sendStoryBox(story_node)
	is_end(next)

func _input_entered(message, words, input_node):
	print("Entered")
	#Check if message fits in word bank. Substring. Capitalization does not matter.
	var found_word = false
	for word in words:
		print(word)
		if word["keyword"].to_lower() in message.to_lower():
			#Check if command is doable
			for effect in word["effects"]:
				if(effect["type"] == "inv"):
					if(effect["action"] == "use"):
						#Check if the item is in the inventory
						print(inventory.return_inventory())
						if(not (effect["item"] in inventory.return_inventory())):
							input_node.text = ""
							return

			#Do effect
			do_effects(word["effects"])
			found_word = true
			input_node.editable = false
			
			Main.store_end_game_stats("Events", word["desc"])
			
			sendStoryBox(story_node)
			is_end(word["next"])
	if (found_word == false):
		input_node.text = ""
	
func _roll(roll):
	rng.randomize()
	var rand = rng.randi_range(1, 20)
	
	tween_node.interpolate_method(roll, "set_value", 0, rand, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN)
	roll.button.disabled = true

	tween_node.start()
	yield(tween_node, "tween_completed")

	if( rand >= int(roll.data[0]["value"])):
		Main.store_end_game_stats("Events", roll.data[0]["desc_pass"])
		yield(get_tree().create_timer(2.0), "timeout")
		sendStoryBox(story_node)
		do_effects(roll.data[0]["effects_pass"])
		is_end(roll.data[0]["next_pass"])
	else:
		Main.store_end_game_stats("Events", roll.data[0]["desc_fail"])
		yield(get_tree().create_timer(2.0), "timeout")
		sendStoryBox(story_node)
		do_effects(roll.data[0]["effects_fail"])
		is_end(roll.data[0]["next_fail"])

func do_effects(effects):
	for effect in effects:
		print("Doing this Effect")
		print(effect)
		match(effect["type"]):
			"inv":
				#if(effect["action"] == "store"):
				#Main.store_end_game_stats("Inventory", effect)
				inventory.update_inventory(effect)
			"rel":
				#Main.store_end_game_stats("Relationships", effect)
				relationships.update_relationships(effect)
			_:
				pass
		
	effectprompts.show_prompts(effects, 3)

func is_end(next):
#	if(typeof(next) == TYPE_STRING):
#		print("Is String.")
#		get_tree().change_scene("res://scenes/End.tscn")
#	else:
#		progressStory(next - 1)

	if(int(next) == 0):
		get_tree().change_scene("res://scenes/End.tscn")
	else:
		Main.store_end_game_stats("Relationships", relationships.read_relationships())
		Main.store_end_game_stats("Inventory", inventory.return_inventory())
		print("Main Inventory")
		print(Main.inventory)
		print(inventory.return_inventory())
		
		progressStory(int(next) - 1)
