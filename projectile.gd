extends Area3D

var velocity = Vector3.ZERO
var damage = 15.0
var lifetime = 5.0

func _ready():
	# Set up collision detection
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	
	# Set up lifetime timer
	var timer = get_tree().create_timer(lifetime)
	timer.timeout.connect(queue_free)

func _physics_process(delta):
	position += velocity * delta

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage)
		print("Projectile hit enemy: ", body.name, " for ", damage, " damage")
		queue_free()
	elif body.is_in_group("player"):
		body.take_damage(damage)
		print("Projectile hit player for ", damage, " damage")
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		area.take_damage(damage)
		print("Projectile hit enemy area: ", area.name, " for ", damage, " damage")
		queue_free() 