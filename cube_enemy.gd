extends "res://enemy_base.gd"

func _ready():
	super._ready()
	health = 200.0
	speed = 125.0
	damage = 75.0
	is_cube = true
	print("Cube enemy initialized with health: ", health) 