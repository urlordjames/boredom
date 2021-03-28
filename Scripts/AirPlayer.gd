extends "res://Scripts/Player.gd"

class_name AirPath

func _ready():
	default_speed = 165
	default_coyote_time = INF
	
var hasdjump: bool = true

func jump() -> void:
	velocity.y = max(velocity.y, 0) + 15
	if hasdjump:
		hasdjump = false
	else:
		coyote_time = 0
		hasdjump = true
