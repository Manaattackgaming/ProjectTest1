extends Node3D

# Preload scenes
var circle_enemy_scene = preload("res://scenes/circle_enemy.tscn")
var cube_enemy_scene = preload("res://scenes/cube_enemy.tscn")
var asteroid_scene = preload("res://scenes/asteroid.tscn")

# Spawn settings
const SPAWN_RADIUS = 100.0
const INITIAL_ASTEROIDS = 20
const MAX_ENEMIES = 5
const SPAWN_INTERVAL = 5.0

# References
@onready var spawn_timer = $SpawnTimer
@onready var game_manager = $GameManager

func _ready():
	spawn_timer.wait_time = SPAWN_INTERVAL
	spawn_timer.start()
	
	# Spawn initial asteroids
	for i in range(INITIAL_ASTEROIDS):
		spawn_asteroid()
	
	print("Main game initialized")

func spawn_asteroid():
	var asteroid = asteroid_scene.instantiate()
	add_child(asteroid)
	
	# Random position within spawn radius
	var random_pos = Vector3(
		randf_range(-SPAWN_RADIUS, SPAWN_RADIUS),
		randf_range(-SPAWN_RADIUS, SPAWN_RADIUS),
		randf_range(-SPAWN_RADIUS, SPAWN_RADIUS)
	)
	asteroid.position = random_pos

func spawn_enemy():
	if get_tree().get_nodes_in_group("enemies").size() >= MAX_ENEMIES:
		return
	
	# Randomly choose between circle and cube enemy
	var enemy_scene = circle_enemy_scene if randf() < 0.7 else cube_enemy_scene
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	
	# Random position on the edge of spawn radius
	var random_angle = randf_range(0, PI * 2)
	var random_pos = Vector3(
		cos(random_angle) * SPAWN_RADIUS,
		randf_range(-SPAWN_RADIUS/2, SPAWN_RADIUS/2),
		sin(random_angle) * SPAWN_RADIUS
	)
	enemy.position = random_pos
	
	print("Enemy spawned at position: ", random_pos)

func _on_spawn_timer_timeout():
	if game_manager.game_running:
		spawn_enemy() 