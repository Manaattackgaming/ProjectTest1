extends "res://enemy_base.gd"

func _ready():
	super._ready()
	health = 50.0
	speed = 150.0
	damage = 30.0
	is_cube = false
	
	# Set up shooting timer
	var shoot_timer = get_tree().create_timer(2.0, true)
	shoot_timer.timeout.connect(shoot)

func shoot():
	var projectile_scene = preload("res://scenes/projectile.tscn")
	var projectile = projectile_scene.instantiate()
	get_tree().root.add_child(projectile)
	projectile.global_transform = global_transform
	projectile.velocity = -global_transform.basis.z * 125.0
	projectile.damage = damage
	print("Circle enemy fired projectile") 