extends "res://Scripts/Player.gd"

class_name EarthPath

func _init():
	default_speed = 165
	default_coyote_time = INF
	
var hasdjump: bool = true

func movement() -> void:
	coyote_time = 0
	velocity.y = default_jump_strength
	
func jump() -> void:
	velocity.y = default_jump_strength
	# is_on_floor() prevents double jump if player is currently falling
	if hasdjump and is_on_floor():
		hasdjump = false
	else:
		coyote_time = 0
		hasdjump = true
		velocity.x = 0
		velocity.z = 0
		velocity.y = -20

