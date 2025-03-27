extends CharacterBody3D

# Movement constants
const SPEED = 100.0
const BOOST_SPEED = 200.0
const MOUSE_SENSITIVITY = 0.002
const PROJECTILE_SPEED = 150.0
const PROJECTILE_DAMAGE = 15.0

# Health
var health = 100.0
var is_boosting = false
var boost_timer = 0.0
const BOOST_DURATION = 2.0

# References
@onready var camera = $Camera3D
@onready var projectile_spawn = $ProjectileSpawn

# Preload projectile scene
var projectile_scene = preload("res://scenes/projectile.tscn")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print("Player initialized with health: ", health)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
	
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
	# Handle boost
	if Input.is_action_pressed("boost") and boost_timer <= 0:
		is_boosting = true
		boost_timer = BOOST_DURATION
		print("Boost activated")
	
	if boost_timer > 0:
		boost_timer -= delta
		if boost_timer <= 0:
			is_boosting = false
			print("Boost ended")

func _physics_process(delta):
	# Get input direction
	var input_dir = Vector3.ZERO
	input_dir.x = Input.get_axis("move_left", "move_right")
	input_dir.z = Input.get_axis("move_forward", "move_backward")
	input_dir.y = Input.get_axis("move_down", "move_up")
	
	# Apply movement
	var current_speed = BOOST_SPEED if is_boosting else SPEED
	velocity = input_dir * current_speed
	move_and_slide()
	
	# Handle shooting
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var projectile = projectile_scene.instantiate()
	get_tree().root.add_child(projectile)
	projectile.global_transform = projectile_spawn.global_transform
	projectile.velocity = -global_transform.basis.z * PROJECTILE_SPEED
	projectile.damage = PROJECTILE_DAMAGE
	print("Projectile fired")

func take_damage(amount):
	health -= amount
	print("Player took damage: ", amount, ". Health remaining: ", health)
	if health <= 0:
		die()

func die():
	print("Player died")
	# Emit signal to game manager
	get_tree().call_group("game_manager", "on_player_died") 