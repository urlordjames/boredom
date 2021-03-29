extends "res://Scripts/Player.gd"

class_name AirPath

func _init():
	default_speed = 165
	default_coyote_time = INF
	
var hasdjump: bool = true

func jump() -> void:
	velocity.y = default_jump_strength
	# is_on_floor() prevents double jump if player is currently falling
	if hasdjump and is_on_floor():
		hasdjump = false
	else:
		coyote_time = 0
		hasdjump = true
