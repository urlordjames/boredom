extends "res://Scripts/Player.gd"

class_name FirePath

func _ready():
	default_speed = 165

func movement():
	move_cooldown = default_move_cooldown
	velocity -= head_basis.z * 50
	velocity.y = 0
