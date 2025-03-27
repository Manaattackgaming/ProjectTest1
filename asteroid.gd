extends StaticBody3D

const DAMAGE = 10.0
var rotation_speed = Vector3.ZERO

func _ready():
	# Random rotation speed
	rotation_speed = Vector3(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	)
	
	# Random initial rotation
	rotation = Vector3(
		randf_range(0, PI * 2),
		randf_range(0, PI * 2),
		randf_range(0, PI * 2)
	)
	
	print("Asteroid initialized")

func _process(delta):
	# Apply rotation
	rotate_x(rotation_speed.x * delta)
	rotate_y(rotation_speed.y * delta)
	rotate_z(rotation_speed.z * delta)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(DAMAGE)
		print("Asteroid collision with player, damage: ", DAMAGE) 