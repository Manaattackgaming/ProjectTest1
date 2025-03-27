extends Control

@onready var start_button = $MenuContainer/StartButton
@onready var quit_button = $MenuContainer/QuitButton
@onready var score_list = $MenuContainer/ScorePanel/ScoreList

func _ready():
	# Connect button signals
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	# Load and display scores
	load_scores()

func _on_start_button_pressed():
	print("Start Game pressed")
	get_tree().change_scene_to_file("res://scenes/Game.tscn")

func _on_quit_button_pressed():
	print("Quit Game pressed")
	get_tree().quit()

func load_scores():
	var file = FileAccess.open("user://score_data.json", FileAccess.READ)
	if file == null:
		print("Error: Could not read score file")
		return
		
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	
	if parse_result != OK:
		print("Error: Could not parse score data")
		return
		
	var data = json.get_data()
	if not data.has("attempts"):
		print("Error: Score data does not contain attempts")
		return
		
	# Clear existing score labels
	for child in score_list.get_children():
		child.queue_free()
	
	# Add new score labels
	for time in data["attempts"]:
		var label = Label.new()
		label.text = time
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.add_theme_font_size_override("font_size", 20)
		score_list.add_child(label) 