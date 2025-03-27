extends CharacterBody3D

# Enemy properties
var health = 100.0
var speed = 100.0
var damage = 30.0
var is_cube = false

# References
@onready var collision_shape = $CollisionShape3D
@onready var mesh_instance = $MeshInstance3D

func _ready():
	add_to_group("enemies")
	print("Enemy initialized with health: ", health)

func take_damage(amount):
	health -= amount
	print("Enemy took damage: ", amount, ". Health remaining: ", health)
	
	if health <= 0:
		die()

func die():
	print("Enemy destroyed")
	get_tree().call_group("game_manager", "on_enemy_destroyed")
	queue_free()

func _physics_process(delta):
	# Basic movement towards player
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		
		# For cube enemies, try to ram the player
		if is_cube:
			var collision = move_and_collide(velocity * delta)
			if collision and collision.get_collider().is_in_group("player"):
				collision.get_collider().take_damage(damage) 