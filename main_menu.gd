extends Control

@onready var start_button = $VBoxContainer/StartButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var credits_button = $VBoxContainer/CreditsButton
@onready var score_list = $VBoxContainer/ScorePanel/VBoxContainer/ScoreList
@onready var credits_popup = $CreditsPopup

func _ready():
	# Connect button signals
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	
	# Load and display scores
	load_scores()
	
	# Fade in animation for UI elements
	animate_ui_elements()

func _on_start_button_pressed():
	print("Start Game button pressed")
	# Add a fade out transition
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	tween.tween_callback(func():
		get_tree().change_scene_to_file("res://scenes/Game.tscn"))

func _on_quit_button_pressed():
	print("Quit Game button pressed")
	get_tree().quit()

func _on_credits_button_pressed():
	print("Credits button pressed")
	credits_popup.popup_centered()

func load_scores():
	var file = FileAccess.open("user://score_data.json", FileAccess.READ)
	if file:
		var json = JSON.new()
		var error = json.parse(file.get_as_text())
		if error == OK:
			var data = json.get_data()
			if data.has("scores"):
				display_scores(data["scores"])
		else:
			print("Error parsing score data: ", json.get_error_message())
		file.close()
	else:
		print("No score data found")

func display_scores(scores: Array):
	score_list.clear()
	for i in range(min(5, scores.size())):
		var score = scores[i]
		var time_str = format_time(score)
		score_list.add_item(time_str)

func format_time(seconds: float) -> String:
	var minutes = floor(seconds / 60)
	var remaining_seconds = floor(seconds) % 60
	return "%02d:%02d" % [minutes, remaining_seconds]

func animate_ui_elements():
	var elements = [
		$VBoxContainer/Title,
		$VBoxContainer/StartButton,
		$VBoxContainer/ScorePanel,
		$VBoxContainer/CreditsButton,
		$VBoxContainer/QuitButton
	]
	
	for i in range(elements.size()):
		var element = elements[i]
		element.modulate.a = 0
		var tween = create_tween()
		tween.tween_property(element, "modulate:a", 1.0, 0.5)
		tween.set_delay(i * 0.1) 