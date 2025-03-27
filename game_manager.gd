extends Node

# Game state
var game_start_time = 0.0
var current_time = 0.0
var enemies_destroyed = 0
var game_running = false
var best_times = []

# Constants
const REQUIRED_ENEMIES = 10
const MAX_BEST_TIMES = 5

# References
@onready var timer_label = $UI/TimerLabel
@onready var health_bar = $UI/HealthBar
@onready var enemies_label = $UI/EnemiesLabel
@onready var best_times_label = $UI/BestTimesLabel
@onready var game_over_screen = $UI/GameOverScreen
@onready var certificate_screen = $UI/CertificateScreen

func _ready():
	load_best_times()
	update_ui()

func _process(delta):
	if game_running:
		current_time = Time.get_ticks_msec() - game_start_time
		update_ui()

func start_game():
	game_running = true
	game_start_time = Time.get_ticks_msec()
	enemies_destroyed = 0
	update_ui()
	print("Game started")

func on_enemy_destroyed():
	enemies_destroyed += 1
	print("Enemy destroyed! Count: ", enemies_destroyed)
	update_ui()
	
	if enemies_destroyed >= REQUIRED_ENEMIES:
		win_game()

func on_player_died():
	game_running = false
	game_over_screen.show()
	print("Game over")

func win_game():
	game_running = false
	var completion_time = current_time / 1000.0  # Convert to seconds
	update_best_times(completion_time)
	certificate_screen.show()
	print("Game won! Time: ", completion_time, " seconds")

func update_best_times(new_time):
	best_times.append(new_time)
	best_times.sort()
	if best_times.size() > MAX_BEST_TIMES:
		best_times.pop_back()
	save_best_times()

func update_ui():
	# Update timer
	var minutes = floor(current_time / 60000)
	var seconds = floor((current_time % 60000) / 1000)
	var milliseconds = floor((current_time % 1000) / 10)
	timer_label.text = "%02d:%02d.%02d" % [minutes, seconds, milliseconds]
	
	# Update enemies count
	enemies_label.text = "Enemies: %d/%d" % [enemies_destroyed, REQUIRED_ENEMIES]
	
	# Update best times
	var times_text = "Best Times:\n"
	for i in range(best_times.size()):
		times_text += "%d. %.2f s\n" % [i + 1, best_times[i]]
	best_times_label.text = times_text

func save_best_times():
	var save_data = {
		"best_times": best_times
	}
	var save_file = FileAccess.open("user://best_times.save", FileAccess.WRITE)
	save_file.store_line(JSON.stringify(save_data))

func load_best_times():
	if FileAccess.file_exists("user://best_times.save"):
		var save_file = FileAccess.open("user://best_times.save", FileAccess.READ)
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if parse_result == OK:
			var data = json.get_data()
			best_times = data.get("best_times", []) 